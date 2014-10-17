
int nQ=16;
Chose[][] choses = new Chose[nQ][nQ];
float pupilles=0;
float pX,pY;
float mX,mY;

void setup() {
  size(600,600);
  frameRate(50);
  background(255);
  smooth();
  pX=mX=width/2;
  pY=mY=height/2;  
  for (int a=0;a<nQ;a++) {
    for (int d=0;d<nQ;d++) {
      choses[a][d]=new Chose(a,d);
    }    
  }
}

void draw() {
  mX=(mX*9/10+mouseX*1/10);
  mY=(mY*9/10+mouseY*1/10);  
  background(255);
  fill(0);
  noStroke();
  for (int a=0;a<nQ;a++) {
    for (int d=0;d<nQ;d++) {
      choses[a][d].display();
    }
  }
  yeux();  
}

class Chose {
  float x;
  float y;
  int a;
  int d;
  float origX,oX2;
  float origY,oY2;
  Chose(int a, int d) {
    this.a=a;
    this.d=d;
    this.x=(float)width/2 + cos(a+d)*(d+3)*20;
    this.y=(float)height/2 + sin(a+d)*(d+3)*20;
    this.origX=oX2=x;
    this.origY=oY2=y;
  }
  void display() {
    if (mousePressed) {
      x=x*19/20+origX*1/20;
      y=y*19/20+origY*1/20;
    }
    else{
      x=(x+cos(a)*(d/10+1)+width)%width;
      y=(y+sin(a)*(d/10+1)+height)%height;      
    }
    if ((float)(width+height)/7-dist(x,y,mouseX,mouseY)>(float)(width+height)/50) {
      pushMatrix();
      translate(x,y);
      scale(((width+height)-dist(x,y,mX,mY)*40)/(width+height));
      rotate(atan2(y-mouseY,x-mouseX)+PI/7);
      triangle(0,-5,-5,5,5,5);
      popMatrix();  
    }
  }
  void bouge(float x, float y) {
    origX=oX2+x;
    origY=oY2+y;
  }
}

void yeux() {
  pupilles-=10;
  noStroke();
  fill(0);  
  ellipse(mouseX-width/9,mouseY-height/10,width/13,height/13);
  ellipse(mouseX+width/9,mouseY-height/10,width/13,height/13);
  if (random(pupilles)>10) {
    stroke(0);
    noFill();
    ellipse(pX-width/9,pY-height/10,width/50,height/50);
    ellipse(pX+width/9,pY-height/10,width/50,height/50);  
  }
  noStroke();  
}

void mousePressed() {
  float x=random(width)-(width/2);
  float y=random(height)-(height/2);  
  for (int a=0;a<nQ;a++) {
    for (int d=0;d<nQ;d++) {
      choses[a][d].bouge(x,y);
    }
  }
}

void mouseReleased() {
  pupilles=255;
  pX=mouseX;
  pY=mouseY;  
}




