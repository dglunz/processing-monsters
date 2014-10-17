/*
Monsternatorz
-------------
11/25/08
Originally created by Jim Soliven
written for http://rmx.cz/monsters/
http://aut.ologo.us

Monster1 is a rendition of Lukas Vojir's Monster 1

The creator of this software is not responsible for any damage it may cause your computer.  It should be safe to use though.
*/
class Monsternator{
 float x,y;
 float radius = 100;
 float teethRadius = 30;
 float noiseScale = 0.1;
 float noiseVal;
 float count = 0;
 float utx,uty,ltx,lty;
 float tcount = 0;
 float targetX, targetY;
 
 Tentacle anchor;
 Tentacle eye;
 Tentacle t1;
 Tentacle t2;
 
 Monsternator(){
  x = width/2;//width-50;
  y = 150;//50;
  utx = x; ltx = x;
  uty = y-15; lty = y+15;
 
  anchor = new Tentacle(width/2,20,0,3,50);
  anchor.TYPE = anchor.INCREASING;
  
  eye = new Tentacle(x,y,0,4,60);
  eye.TYPE = eye.EYE;
  t1 = new Tentacle(x-5,y,0,5,50);
  t1.TYPE = t1.DECREASING;
 
 }

 void drawMe(float tx, float ty){
  move();
  drawAnchor();
  drawArms(tx,ty);
  drawEye(tx,ty);
  drawBody();
  drawTeeth();

 }

void drawMe(){
  move();
  drawAnchor();
  drawArms(targetX,targetY);
  drawEye(targetX,targetY);
  drawBody();
  drawTeeth();

 }
 
 void move(){
   x = x+sin(count)*.2;
   y = y+cos(count)*.2; 
 }
 
 void drawBody(){
   float detail = 40;
   float delta = TWO_PI/detail; 
   noiseDetail(3,.05);
   fill(0,0,0);
   noStroke();
   beginShape();
     for(int i = 0; i < detail; i++){
       count+=0.0001;
           noiseVal = noise(i*delta+sin(delta)*count,i*delta+cos(delta)*count)*radius/50;
       vertex(x+sin(i*delta)*constrain(radius*noiseVal,teethRadius+10,teethRadius+35), 
              y+cos(i*delta)*constrain(radius*noiseVal,teethRadius+10,teethRadius+35));
     }
   endShape(CLOSE);
 } 
 
 void drawTeeth(){

  int numTeeth = 5;
  int teethSize = 10;
  int teethWidth = numTeeth*teethSize;
  utx = x; ltx = x;
  uty = y-15; lty = y+15;
  fill(255,255,255);
  stroke(0,0,0);
  for(int i = 0; i < numTeeth; i++){
    rect(utx-teethWidth/2+i*teethSize,uty,teethSize,teethSize);
    rect(ltx-teethWidth/2+i*teethSize,lty+cos(tcount)*5,teethSize,teethSize);
  }
  tcount+=0.1;
 }
 
 void drawAnchor(){
   stroke(0,0,0);
   fill(0,0,0);
   ellipse(width/2,20,30,25);
   anchor.setTarget(x,y,0);
   anchor.drawMe();
 }
 
 void drawEye(float tx,float ty){
   float dx,dy;
   float angle;
   stroke(0,0,0);
   fill(0,0,0);
   eye.angle[0]+=1;
   eye.setBase(x,y,0);
   eye.setTarget(x-200,y,0);
   eye.drawMe();
   //ellipse(eye.x[int(eye.segLength-1)],eye.y[int(eye.segLength-1)],15,15);
   ellipse(eye.x[0],eye.y[0],25,25);
   fill(255,255,255);
   stroke(255,255,255);
   dx = eye.x[0]-tx;//max(tx,eye.x[0])-min(tx,eye.x[0]);
   dy = eye.y[0]-ty;//max(ty,eye.y[0])-min(ty,eye.y[0]);
   angle = atan2(dy,dx);
   //line(eye.x[0],eye.y[0],eye.x[0]+sin(angle)*10,eye.y[0]+cos(angle)*10);
   pushMatrix();
     translate(eye.x[0],eye.y[0]);
     rotate(angle);
     ellipse(-10,0,10,10);
     fill(0,0,0);
     ellipse(-10,0,5,5);
     //line(0,0,-10,0);
   popMatrix();
 }
 
 void drawArms(float tx, float ty){
  t1.setTarget(tx,ty,0);
  t1.setBase(x,y,0);
  t1.drawMe();
 }
 
 boolean isCloseToCatching(Monster1 m){
  if(dist(m.flx,m.fly,t1.x[0],t1.y[0]) < t1.segLength+20){
    targetX = m.flx; targetY = m.fly;
    return true;
  } 
  else return false; 
 }
 
 
}
