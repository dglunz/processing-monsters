class FlockingPart{
  int myIndex;
  float posX;
  float posY;
  float heading;
  float pScale;
  float speed;
  float cohesion;
  float follow;
  float avoid;
  color pColor;
  FlockingPart[] flock;

  FlockingPart(float x,float y,float theta,float inScale,float inSpeed,FlockingPart[] inFlock){
    posX=x;
    posY=y;
    heading=theta;
    pScale=inScale;
    speed=inSpeed;
    flock=inFlock;
    pColor=color(random(inSpeed*50),random(inSpeed*50),random(inSpeed*50));
  }
  //////////////
  void display(){
    //    println("wtf?");
    //fill(pColor,100);
    fill(0);
    noStroke();
    //  strokeWeight(3);
    //point(posX,posY);
    pushMatrix();
    translate(posX,posY);
    scale(pScale*0.4);
    rotate(heading+HALF_PI);
    //translate(10,15);
    triangle(-10,15,0,-15,10,15);
    popMatrix();
    noFill();
    //stroke(pColor,55);
  }
  //////////
  void update(FlockingPart[] inFlock, float followX, float followY){

    float oldHeading=heading;
    if(inFlock.length>1){
      flock=inFlock;
      //cohesion=steering(cohKX, cohKY, posX,posY);
      follow=steering(followX, followY, posX,posY);

    }
    float[] will={heading,cohesion(),avoid(),follow,orient()};
    float[] weight={0.4, 0.05,       0.3 ,   0.2,   0.05};
    heading=angleWeighter(will,weight);
    posX=posX+(cos(heading)*speed);
    posY=posY+(sin(heading)*speed);

    if(posX>width){
      posX=10;
    }
    if(posX<0){
      posX=width-10;
    }
    if(posY>height){
      posY=10;
    }
    if(posY<0){
      posY=height-10;
    }    

  }

  float steering(float xPos, float yPos, float currentX,float currentY){
    float pxPos=xPos-currentX;
    float pyPos=yPos-currentY;
      return atan2(pyPos,pxPos)%PI; 
  }


  public float getPosX(){
    return posX;
  }


  public float getPosY(){
    return posY;
  }

  public float orient(){
    int nearFlockmates=0;
    float orient=0;
    for(int i=0;i<flock.length;i++){
      if(posX!=flock[i].posX && posY!=flock[i].posY){
        if(intersectCircle(posX,posY,flock[i].posX,flock[i].posY,pScale*50)){
          avoid+=flock[i].heading;
          nearFlockmates++;
        }
      }
    }

    if(nearFlockmates>0){
      return orient=-(orient)/nearFlockmates;
    }  
    else {
      return orient=follow;
    }
    /*
    float averageOrientation=heading;
    if(flock.length>1){
      for(int i=0; i<flock.length; i++){
        averageOrientation+=flock[i].heading;
      }
      averageOrientation/=flock.length+1;

    }
    return averageOrientation;
    */
  }

  public float avoid(){
    int nearFlockmates=0;
    float avoid=0;
    for(int i=0;i<flock.length;i++){
      if(posX!=flock[i].posX && posY!=flock[i].posY){
        if(intersectCircle(posX,posY,flock[i].posX,flock[i].posY,pScale*25)){
          avoid+=steering(flock[i].posX, flock[i].posY, posX,posY);
          //stroke(255,0,0,150);
          stroke(0,200);
          line(flock[i].posX, flock[i].posY, posX,posY);
          nearFlockmates++;
        }
      }
    }

    if(nearFlockmates>0){
      return avoid=(avoid)/nearFlockmates+PI;
    }  
    else {
      return avoid=follow;
    }

  }

  public float cohesion(){
    int nearFlockmates=0;
    float cohesion=0;
    float cohesionX=0;
    float cohesionY=0;
    for(int i=0;i<flock.length;i++){
      if(posX!=flock[i].posX && posY!=flock[i].posY){
        if(intersectCircle2(posX,posY,flock[i].posX,flock[i].posY,pScale*70,pScale*25)){
          cohesionX+=flock[i].posX;
          cohesionY+=flock[i].posY;
          //stroke(0,255,0,50);
          stroke(0,20);
          line(flock[i].posX, flock[i].posY, posX,posY);
          nearFlockmates++;
        }
      }
    }

    if(nearFlockmates>0){      
      cohesionX=cohesionX/nearFlockmates;
      cohesionY=cohesionY/nearFlockmates;
      return cohesion=steering(cohesionX, cohesionY, posX,posY);
    }  
    else {
      return cohesion=follow;
    }

  }

  boolean intersectCircle(float x1,float y1, float x2, float y2, float radius){
    if(dist(x1,y1,x2,y2)<radius){
      return true;
    }  
    return false;
  }

  boolean intersectCircle2(float x1,float y1, float x2, float y2, float radius1,float radius2){
    if(dist(x1,y1,x2,y2)<radius1&&dist(x1,y1,x2,y2)>radius2){
      return true;
    }  
    return false;
  }

  float angleWeighter(float angles[],float weights[]){
    PVector[] vectors=new PVector[angles.length];
    for(int i=0; i<angles.length;i++){
      vectors[i]=new PVector(cos(angles[i]),sin(angles[i]));
      vectors[i].mult(weights[i]);
    }
    for(int i=0; i<angles.length-1;i++){
      vectors[i+1].add(vectors[i]);
    }  
    return atan2(vectors[angles.length-1].y,vectors[angles.length-1].x);
  }
}

















