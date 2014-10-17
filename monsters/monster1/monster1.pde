float points = 150;
float ainc = 360/points;
float radius = 60;
float jiggle = radius/19;
float distance = radius/2;
//float jiggle = 20;
float angle;
float xv,yv, dx,dy, lxv,lyv;
float crx,cry;
float flx, fly;
float xoff1 = 0.0;
float xoff2 = 1.0;

void setup(){
  size(500,400);
   flx = width/2;
   fly = height/2;
}

void draw(){
  background(255);
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


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
       if(points < 300){ points+=3; ainc = 360/points;}
    } else if (keyCode == DOWN) {
        if(points > 10){ points-=3; ainc = 360/points;}
    } else if (keyCode == LEFT) {
       if(radius > 50){ radius-=3; jiggle = radius/19; distance = radius/2; }
    } else if (keyCode == RIGHT) {
       if(radius < 200){ radius+=3; jiggle = radius/19; distance = radius/2; }
    }
  }
}
