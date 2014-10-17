//import processing.opengl.*;

float cW;
int sC = 100;
float a = 0;
float md;
float maxSpread = 100;
// x and y locations of particles
float[] sx = new float[sC];
float[] sy = new float[sC];
// diameter 
float[] sd = new float[sC];
// x and y increments of particles
float[] six = new float[sC];
float[] siy = new float[sC];
// angle and angle increment of particle sin
float[] sa = new float[sC];
float[] sai = new float[sC];



void setup(){
  //size(500,500,OPENGL);
  size(500,500);
  cW = height/3;
  
  for(int i=0;i<sC;i++){
    sx[i] = width/2;
    sy[i] = height/2;
    sai[i] = random(100,200);
    sd[i] = random(30,60);
    six[i] = random(-maxSpread,maxSpread);
    siy[i] = random(-maxSpread,maxSpread);
  }
  md = dist(width/2,height/2,width,height);
}

void draw(){
  background(255);
  //fill(0,230);
  fill(0);
  noStroke();
  ellipse(width/2,height/2,cW,cW);
  
  float d = dist(width/2, height/2, mouseX, mouseY);
  float dx = abs((d/md)-1);
  println(dx);
  
  for(int i=0;i<sC;i++){
    
    ellipse(sx[i],sy[i],sd[i] + dx * 100,sd[i] + dx * 100);
    sx[i]= sin(sa[i])*six[i] + width/2;
    sy[i]= sin(sa[i])*siy[i] + height/2;
    sa[i]+= TWO_PI/(sai[i]);
  }

  ellipseMode(CENTER);
  stroke(255);
  ellipse(width/2-30-dx*30, height/2,30,30);
  ellipse(width/2+30+dx*30, height/2,30,30);
  noStroke(); 
  fill(255);
  ellipse(width/2-30-dx*30, height/2,10,10);
  ellipse(width/2+30+dx*30, height/2,10,10);

}


