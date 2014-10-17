/*deffekt.ch*/

import saito.objloader.*;
import toxi.geom.*;
import processing.opengl.*;

OBJModel model;

Vec3D area;
Vec3D pos;
Vec3D mousearea;
Vec3D mousepos;


void setup(){
  size(800,800,OPENGL);
  smooth();
  rectMode(CENTER);

  model = new OBJModel(this);
  model.load("tank.obj");
  model.debugMode();
  model.enableTexture();
  model.drawMode(TRIANGLES);

  pos = new Vec3D(0,0,0);
  mousepos = new Vec3D(0,0,0);
  area = new Vec3D(height*2,width,0);
  mousearea = new Vec3D(height,width,0);
}


void draw(){
  background(255);
  noStroke();
  camera(400, 0, -100, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0);
  fill(0);
  tank(interpolate(pos,area,20));
}


void tank(Vec3D newpos){
  pushMatrix();
  translate(newpos.x,newpos.y,0);
  rotate(newpos.z);
  translate(50,-25,5);
  rotateX(radians(90));
  scale(0.3);
  model.draw();
  popMatrix();
  rotateweapon(new Vec3D(800,interpolate(mousepos,mousearea,20).y,interpolate(mousepos,mousearea,20).x-100),new Vec3D(pos.x,pos.y,-20));
}


void rotateweapon(Vec3D v1, Vec3D v2){
  float deltaX = v1.x - v2.x; 
  float deltaY = v1.y - v2.y; 
  float deltaZ = v1.z - v2.z; 

  float angleZ = atan2( deltaY,deltaX ); 
  float hyp = sqrt( sq( deltaX ) + sq( deltaY ) ); 
  float angleY = atan2( hyp,deltaZ ); 

  fill(0);

  pushMatrix();
  translate(v2.x, v2.y, v2.z);
  rotateZ(angleZ);
  rotateY(angleY);

  sphereDetail(5);
  sphere(18);
  translate(0,0,75);
  drawCyl(6,70);
  translate(0,0,80);
  drawCyl(2,50);
  translate(0,0,50);
  drawCyl(5,10);
  if (mousePressed == true ) {
    shoot();
  } 
  popMatrix();
}


void shoot(){
  if(random(1)>0.1){
    background(0);
    stroke(255);

    int x1 = 0;
    int y1 = 1000;
    int x2 = 0;
    int y2 = 0;

    int anz = (int)random(80);

    for(int i=0; i<=anz; i++) {
      float x = lerp(x1, x2, i/(float)anz);
      float y = lerp(y1, y2, i/(float)anz);
      strokeWeight(random(0,10));
      line(0,x,y+20,0,x,y);
      pushMatrix();
      translate(0,x,y);
      drawCyl(i*10,5);
      popMatrix();
    }
  }
  noStroke();
}


Vec3D interpolate(Vec3D _pos, Vec3D _area, float _delay){

  float mapMouseX = map(mouseY,0,width,-_area.x/2,_area.x/2);
  float mapMouseY = map(mouseX,0,height,-_area.y/2,_area.y/2);

  float dx = mapMouseX - _pos.x;
  if(abs(dx) > 1) {
    _pos.x += dx/_delay;
  }
  float dy = mapMouseY - _pos.y;
  if(abs(dy) > 1) {
    _pos.y += dy/_delay;
  }

  dx = mapMouseX - _pos.x;
  dy = mapMouseY - _pos.y;
  _pos.z = atan2(dy, dx);  

  return new Vec3D(_pos.x,_pos.y,_pos.z);
}


void drawCyl(float xr,float yr) {
  float degree,num,cosval,sinval;

  num=20;
  degree=radians(360/num);
  beginShape(QUAD_STRIP);
  for(int i=0; i<num+1; i++) {
    cosval=cos(degree*i);
    sinval=sin(degree*i);
    vertex(sinval*xr,cosval*xr,-yr);
    vertex(sinval*xr,cosval*xr,yr);
  }
  endShape();
}





