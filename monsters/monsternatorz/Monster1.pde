class Monster1{
float points = 150;
float ainc = 360/points;
float radius = 20;
float jiggle = radius/19;
float distance = radius/2;
//float jiggle = 20;
float angle;
float xv,yv, dx,dy, lxv,lyv;
float crx,cry;
float flx, fly;
float xoff1 = 0.0;
float xoff2 = 1.0;

int FREE = 0;
int CAUGHT = 1;
int DEAD = 2;
int STATE = FREE;


Monster1(){
   flx = random(width/2-100,width/2+100);
   fly = height-50;
}

void drawMe(){
  if(STATE == FREE){
    flx += random(-2,2); fly+=random(-2,2);
  }
  
  if(STATE == CAUGHT){
    goTo(TheMonsternator);
  }
  
  fill(0);
 // drawing fluffy
  beginShape();
  for(int i=0;i<points;i++){
    // preparing for sin/cos
    angle = ainc * i;
    crx = radius;
    cry = radius;
    
    // mouse shaving interaction (editing radius for points according to mouse pos
    if(abs(lxv-mouseX) < distance){ crx *= map(abs(lxv-mouseX), 0, width/2, .8, 1);}
    if(abs(lyv-mouseY) < distance){ cry *= map(abs(lxv-mouseY), 0, height/2, .8, 1);}
    
    // calculating vertex position + jiggeling with random
    xv = sin(radians(angle)) * crx + flx + random(-jiggle,jiggle);
    yv = cos(radians(angle)) * cry + fly + random(-jiggle,jiggle);
 
    vertex(xv,yv);
    
    lxv = xv;
    lyv = yv;
    
   // println(angle);    
  }
  endShape();

  // drawing eyes 
  fill(255);
  ellipseMode(CENTER);
  ellipse((flx-radius/5)+noise(xoff1)*radius/5,fly-radius/5-noise(xoff1)*radius/5, radius/7,radius/7);
  ellipse((flx+radius/5)+noise(xoff2)*radius/5,fly-radius/5-noise(xoff2)*radius/5, radius/7,radius/7);
  
  // drawing mouth
  for(int i = 0; i<5;i++){
    ellipse((radius/7)*i + (flx-radius/4),fly+radius/3,radius/15+noise(xoff1)*radius/10,radius/15+noise(xoff1)*radius/10);
  }
  
  // changing values for perlin noise
  xoff1+=.01;
  xoff2+=.01;
 
}

void goTo(Monsternator m){
 float dx = m.x-flx; 
 float dy = m.y-fly;
 flx+=dx/32;
 fly+=dy/32;
 if(dist(flx,fly,m.x,m.y) < 10){
  flx = m.x; fly = m.y;
 } 
}
}
