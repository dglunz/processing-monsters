/*
rastaCreature - 2008 by  Luis Bustamante. 
Click on the screen to pull its rastas and help relaxing this nervous thing
http://protonumerique.net
bled -at- protonumerique.net
Some parts Recycled from "SonicHair" by Toxi ( http://toxi.co.uk/p5/sonicHair/)

*/

import noc.*;
/*Vector Library by Dan Shiffmann 
 http://www.shiffman.net/teaching/nature/library/
*/


Limb[] h;
int hCount=0;
float xdist=8;
float ydist=8;
float movement=0.15;
float wPos,hPos, zPos;
float angle, anglez;
float ex,ey,ez;
int radius;

float xoff = 200.0;
float yoff = 0.0;
float zoff = 2.0;
float xincrement = 0.01;
float yincrement = -0.009;
float zincrement = 0.01;
float n, m, o;
float ang=0;
float num = 0.1;


void setup(){
  size(600,600,P3D);
  wPos=width*0.5;
  hPos=height*0.5;
  zPos = 0;
  ellipseMode(CENTER);
  rectMode(CORNER);
  h=new Limb[50];
  radius = 23;
}

void draw(){
  background(255);
  //check state and change movement rate accordingly
  if(!mousePressed){
    xincrement = 0.01;
    yincrement = -0.009;
    zincrement = 0.01;
  } else{
    xincrement = 0.0001;
    yincrement = -0.0009;
    zincrement = 0.0001;
  }

  n = noise(xoff)*width;
  m = noise(yoff)*height;
  o = noise(zoff)*600 - 300 ;
  ex = n; ey = m; ez = o;
 

  xoff += xincrement;
  yoff += yincrement;    
  zoff += zincrement;
  
    ///move noisily in a constrained 3D space
  levitate(n,m,o);
  translate(wPos,hPos,zPos);

  ////Start producing Hairs if they aren't there yet
  if (hCount<h.length) {
 
    float newy=random(-1,1)*ydist;
    float newx=random(-1,1)*xdist*((ydist-abs(newy))/ydist);

    float nx=random(-1,1);
    float ny=random(-1,1);
    float nz=2;
    // different lengths in hair pieces
    float l = random(5,10);
    // make more hairs
    for(int i=0; i<5; i++) {
      h[hCount++]=new Limb(newx+random(-2,2),newy+random(-2,2),0,nx,ny,nz,l);
    }
  }
  
  
  
  if (mousePressed) {
    // if clicked, point hairs towards mouse position
    float wx,wy;
    wx=-(float)(wPos-mouseX)/wPos;
    wy=-(float)(hPos-mouseY)/hPos;
    for(int i=0; i<hCount; i++) {
      h[i].update(random(wx-movement*2,wx+movement*2),random(wy-movement*2,wy+movement*2),0.01);
      h[i].display();
    }

    // ...or randomly crawl around if idle
  } else {
    float wx,wy;
    wx=-(float)(wPos-mouseX)/wPos;
    wy=-(float)(hPos-mouseY)/hPos;
    
    for(int i=0; i<hCount; i++) {
      h[i].update(random(-1,1),random(-1,1),0.06);
      h[i].display();
    }

  }
  
  
  fill(0);
  sphere(radius);
  
}

void levitate(float n, float m, float o) {


  wPos=n;
  hPos=m;
  zPos=o;
  
  wPos = constrain(wPos,0,width-30);
  hPos = constrain(hPos,100,height-30);
  zPos = constrain(zPos,-300,300);


}


class Limb {
  // vertex list arrays
  float[] vx, vy, vz;
  // current directional vector
  float nx, ny, nz;
  // segment length params
  float seg_len, max_len, grow_speed;
  // responsiveness to directional changes
  float smoothness,straightness;
  // curl parameters
  float curlR,curlAngle,curlStrength;
  int nVert;
  // number of particles in the system
  int maxSegments=15;

  Limb(float x,float y, float z, float nvx, float nvy, float nvz, float len) {
    vx=new float[maxSegments];
    vy=new float[maxSegments];
    vz=new float[maxSegments];
    nx=nvx; ny=nvy; nz=nvz;
    max_len=len;
    seg_len=1;
    // randomize basic looks/behaviour
    grow_speed=random(0.008,0.015);
    smoothness=random(0.75,0.85)+0.05;
    straightness=random(0.88,0.94)+0.02;
    // curl radius and rotation speed
    curlR=random(2);
    curlStrength=random(0.05,0.3)*20;

    // build initial segments
    nVert=0;
    addSegment(x,y,z);
    while(nVert<maxSegments) {
      // change direction randomly
      nx+=random(-1,1); ny+=random(-1,1); nz+=random(-1,1);
      // normalize vector
      float d=sqrt(nx*nx+ny*ny+nz*nz);
      if (d>0) {
        d=1/d; nx*=d; ny*=d; nz*=d;
      }
      // add to vertex list
      addSegment(x+=seg_len*nx,y+=seg_len*ny,z+=seg_len*nz);
    }
  }

  void addSegment(float x,float y, float z) {
    vx[nVert]=x; vy[nVert]=y; vz[nVert++]=z;
  }

  // align hair to new direction vector
  // applies smoothness, curling and gravity

  void update(float nnx,float nny, float nnz) {
    // increase hair length
    seg_len+=(max_len-seg_len)*grow_speed;
    // add new direction to existing vector
    nx+=nnx; ny+=nny; nz+=nnz;
    // normalize new vector
    float d=sqrt(nx*nx+ny*ny+nz*nz);
    if (d>0) d=(1/d)*seg_len;
    nx*=d; ny*=d; nz*=d;
    // iterate and update all vertices with decreasing effect
    float sm=smoothness*(seg_len/max_len);
    float grav=0;
    curlAngle=0;
    for(int i=1; i<nVert; i++) {
      vx[i]+=(vx[i-1]+nx-vx[i])*sm+curlR*cos(curlAngle);
      vy[i]+=(vy[i-1]+ny-vy[i])*sm+grav;
      vz[i]+=(vz[i-1]+nz-vz[i])*sm+curlR*sin(curlAngle);
      sm*=straightness;
      grav+=0.15;
      curlAngle+=curlStrength;
    }
  }

  // draw the rastas
  void display() {
    
    // mark the hair root
    fill(0);
    noStroke();
    ellipse(vx[0],vy[0],5,5);
    beginShape();
    for(int i=0; i<nVert; i++) {
      stroke(0);
      strokeWeight(nVert-i-1);
      vertex(vx[i],vy[i],vz[i]);
    }
    endShape();
  }
}



