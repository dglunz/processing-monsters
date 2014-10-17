// W:Blut 2008
// Frederik Vanhoutte
// 
// Gibber: a Processing Monster

// The gibber is a collection of blobs (well, actually an array ;-) ) in a bounding box.
// The bounding box is centered around (0,0,0). To draw the gibber properly the sketch coordinates
// have to be shifted by (-width/2, -height/2, 0).
// The blobs are attracted to a common goal: the mouse position.
// At the same time all blobs try to keep a minimum distance or higher from each other.
// Each blob has one leader from which it wants to keep exactly the minimum distance. 

// Interaction: move the mouse around, a mouse click resets the gibber.


int alpha;
float bufferedMouseX,bufferedMouseY;

GibberingMonster gibber;

void setup(){
  size(500, 500,P3D);
  noStroke();
  frameRate(30);
  gibber=new GibberingMonster(200,400f,400f,400f);  // number of blobs, width, height and depth of the bounding box
}


void draw(){
  background(255);
  translate(width/2,height/2,0);
  bufferedMouseX=0.9f*bufferedMouseX+0.1f*mouseX;// smooths out mouse motion.
  bufferedMouseY=0.9f*bufferedMouseY+0.1f*mouseY;
  
  for(int cycle=0;cycle<10;cycle++){// every frame, the gibber is updated 10 cycles and drawn with varying alpha.
    alpha=cycle*15;
    PVector toMouse=new PVector(bufferedMouseX-width/2,bufferedMouseY-height/2,0f);// update common goal. 
    gibber.updateBlobs(toMouse);// pass common goal to gibber and update all blobs.
    gibber.render(alpha,cycle==9);// render the blobs, only render the eyes on the last cycle.
  }
}

void mouseReleased(){
  gibber=new GibberingMonster(200,400f,400f,400f);
}

class GibberingMonster{
  Blob[] blobs; // the blobs
  int NUMBLOBS; // number of blobs
  int[] leaders; // stores the index of each blob's leader
  float blobSize =15;
  float blobSeparation = 20;
  
  //dimensions of bounding box
  float depth;
  float width;
  float height;

  GibberingMonster(int n, float w, float h, float d){
    NUMBLOBS=n;
    width=w;
    height=h;
    depth=d;
    blobs=new Blob[NUMBLOBS];
    leaders= new int[NUMBLOBS];
    initAllBlobs();
  }

  void updateBlobs(PVector tgt){
    // The movement of the blobs is determined by setting different targets an adding these together as vectors.
    // Finally the blob is moved towards the compound target.
    
    
    updateCommonTarget(tgt); // moves the target of each blob towards the common goal.
    updateSeparations(); // adjusts the target of each blob to maintain separation.
    followTheLeader(); // moves the target of each blob towards its leader.
    updateBlobs(); // moves the blob towards its target.
    constrainPositions();// bounce the blob of the sides of the bounding box.
    cullDeadBlobs();// rest runaway (too fast) or dead (isolated, static) blobs
  } 

  void updateCommonTarget(PVector tgt){
    for(int i = 0; i < NUMBLOBS; i++){
      blobs[i].tgt.add((tgt.x-blobs[i].pos.x)/500f,(tgt.y-blobs[i].pos.y)/500f,(tgt.z-blobs[i].pos.z)/500f);
    }
  }

  void updateSeparations(){
    // For each couple of blobs, check their distance. If too close set a target at 1/10th of the needed distance.
    
    for(int i = 0; i < NUMBLOBS; i++){
      Blob bi=blobs[i];
      for(int j = i+1; j < NUMBLOBS; j++){
        Blob bj=blobs[j];
        float d = max(PVector.dist(bi.pos,bj.pos),0.0001);
        if(d < blobSeparation){
          float sep=bi.size+bj.size;
          PVector tmp = PVector.sub(bi.pos,bj.pos);
          tmp.mult(sep/d);
          tmp.add(bj.pos);
          PVector delta=PVector.sub(tmp,bi.pos);
          delta.mult(0.1f);
          bi.tgt.add(delta);
          bj.tgt.sub(delta);
        }
      }
    }
  }

  void followTheLeader(){
    // Set a target at 1/"step"th of the distance of the blob's leader.  "Step" is a property of the blob
    // with a certain spread, effectively creating slow and fast followers.
    
    for(int i = 0; i < NUMBLOBS; i++){
      Blob bi=blobs[i];  
      Blob bj=blobs[leaders[i]];   
      PVector delta = PVector.sub(bi.pos, bj.pos);
      if(delta.mag() < blobSeparation){
        delta.div(bi.step);
        bi.tgt.add(delta);
      }
      else{
        delta.div(bi.step);
        bi.tgt.sub(delta);
      }
    }
  }

  void updateBlobs(){
    // Move each blob towards it target.
    
    for(int i = 0; i < NUMBLOBS; i++){
      blobs[i].update();  
    }
  }

  void constrainPositions(){
    // If the blob is centered outside the bounding box, mirror it back inside.
    // If XL is the limit and X is a position outside, 2*XL-X is the mirrored position.
    
    for(int i = 0; i < NUMBLOBS; i++){
      if(blobs[i].pos.x  <-width/2) blobs[i].pos.x = -width-blobs[i].pos.x;
      if(blobs[i].pos.x  > width/2) blobs[i].pos.x = width-blobs[i].pos.x;
      if(blobs[i].pos.y  <-height/2) blobs[i].pos.y = -height-blobs[i].pos.y;
      if(blobs[i].pos.y  > height/2) blobs[i].pos.y = height-blobs[i].pos.y;
      if(blobs[i].pos.z  <-depth/2) blobs[i].pos.z = -depth-blobs[i].pos.z;
      if(blobs[i].pos.z  > depth/2) blobs[i].pos.z = depth-blobs[i].pos.z;
    }
  }

  void cullDeadBlobs(){
    //Sometimes static lonely blobs show up, kill these.
    //Very fast blobs tend to destabilize, kill them too.
    
    for(int i = 0; i < NUMBLOBS; i++){
      if ((blobs[i].speed<0.01f)||(blobs[i].speed>10))
      {
        blobs[i] = initOneBlob(blobs[i]);// Resets everything but keep the position, otherwise blobs pop up in emty space.
        // A blob cannot be its own leader.
        leaders[i] = (int)random(NUMBLOBS-0.000001f);
        while(leaders[i]==i){
          leaders[i] = (int)random(NUMBLOBS-0.000001f);
        }
      }
    }
  }






  void initAllBlobs(){
    for(int i = 0; i < NUMBLOBS; i++){
      blobs[i] = initOneBlob();
      leaders[i] = (int)random(NUMBLOBS-0.000001f);
      while(leaders[i]==i){
        leaders[i] = (int)random(NUMBLOBS-0.000001f);
      }
    }
  }

  Blob initOneBlob(){
    //create a random blob in the center of te bounding box;
    return new Blob( random(-50,50), random(-50,50), random(-50,50),random(0.25,1.5)*blobSize);
  }

  Blob initOneBlob(Blob b){
    //create a new blob at the position of the passed blob.
    return new Blob( b.pos.x, b.pos.y,b.pos.z,random(0.25,1.5)*blobSize);
  }

  void render(float alpha, boolean showEyes){
    // draw the blobs, alpha varies with the drawing cycle, older cycles are more faint.
    // showEyes is only true during the last cycle.
    
    for(int i = 0; i < NUMBLOBS; i++){
      blobs[i].render(alpha);
      if(showEyes) blobs[i].renderEye(alpha);
    }

  }


}


class Blob{
  float size; 
  PVector pos;
  PVector tgt;
  float speed;
  float step;// number of updates needed to reach a target.
  boolean eyeSphere; // is the blob an eye?
  
  // the blob can blink, these parameters are used to determine the state.
  boolean blinking; 
  int blinktimer; 


  Blob(float x, float y, float z, float sz){
    pos=new PVector(x,y,z);
    tgt=pos.get();
    speed=0;
    step = 10+random(10);
    eyeSphere=(random(1.0f)<0.25f);// 25% chance of having an eye.
    blinking=false;
    blinktimer=0;
    size=sz;
  }

  void update(){
    PVector delta = PVector.sub(tgt, pos);
    delta.div(step);
    pos.add(delta);
    speed=delta.mag();
    if((!blinking)&&random(1.0f)<0.002f){ //There's a 1/500 chance per update that the eye blinks. The blinks takes 30 frames.
      blinking=true;
      blinktimer=0;
    }
    blinktimer++;
    if(blinktimer>30){// Blink is complete.
      blinking=false;
    }
  }

  void render(float a){ // draw the black body
    pushMatrix();
    translate(0,0,pos.z);
    noStroke();
    fill(0,max(0,(0.5f-speed/10))*a);
    float s=size/75*(a+15);
    ellipse(pos.x,pos.y, s, s);
    popMatrix();
  }

  void renderEye(float a){ // draw the white eye and black pupil
    if(eyeSphere){
      pushMatrix();
      translate(0,0,pos.z);
      noStroke();
      fill(255,(1-speed/20)*255);
      if(blinking){
        ellipse(pos.x,pos.y, size/150*(a+15), size/300*(a+15));
      }
      else{
        ellipse(pos.x,pos.y, size/150*(a+15), size/150*(a+15));
      }
      fill(0,(1-speed/10)*255);
      ellipse(pos.x+(mouseX-pos.x-width/2)/(float)width*10/150*(a+15),pos.y+(mouseY-pos.y-height/2)/(float)height*10/150*(a+15), size/300*(a+15), size/300*(a+15));
      popMatrix();
    }
  }



}




















