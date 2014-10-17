FlockingPart[] myFlock;
void setup(){
  size(300,300);
  smooth();
  frameRate(24);
  //background(0);
  myFlock=new FlockingPart[0];
  
  for(int i=0; i<80; i++){
    FlockingPart part=new FlockingPart(width/2,height/2,random(TWO_PI),random(0.5,1),random(0.3,4),myFlock);
    myFlock=(FlockingPart[])append(myFlock,part);
  }
  
}
void draw(){
  /*
  FlockingPart part=new FlockingPart(random(width),random(height),random(TWO_PI),random(0.5,1),random(0.5,4),myFlock);
   myFlock=(FlockingPart[])append(myFlock,part);
   */
  float cohKX=0;
  float cohKY=0;
  float vecX=0;
  float vecY=0;



  background(255);
  //fill(255,2);
  //rect(0,0,width,height);
  beginShape(TRIANGLE_STRIP);
  for(int i=0;i<myFlock.length;i++){
    myFlock[i].update(myFlock,mouseX,mouseY);
    myFlock[i].display();
    //  println(myFlock[i].posX);  
    noFill();
    stroke(0,25);
    vertex(myFlock[i].getPosX(),myFlock[i].getPosY());
  }
  endShape();//la forma autista, para hacer protectyor de pantalla ochentero :D
  //ellipse(cohKX,cohKY,5,5);
}


