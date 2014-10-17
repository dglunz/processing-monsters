int points = 100;
float spAm = 360; // spiral angle maximum
float radius = 100; // spiral radius
float jiggle = 5; // jiggle - affects the noise animation
float rdec = radius/points;
float xv, yv, angle,flx, fly,ainc,md,spA,dx; // helping tools ,]

void setup(){
  size(500,500);
  flx = width/2;
  fly = height/2;
  md = dist(width/2,height/2,width,height);
  spA = spAm;  
}

void draw(){

  background(255);
  noStroke();
  stroke(255);
  fill(0);
  
  // mouse interaction:
  dx = mouseY/ (float) height;
  spA = dx*spAm + 360;
  ainc = spA/points;
  
  for(int i=0;i<points;i++){
    // preparing for sin/cos
    angle = ainc * i;
    
    // calculating vertex position + jiggeling with random - rdec*i is making the spiral effect
    xv = sin(radians(angle)) * (rdec*i+50) + flx + random(-jiggle,jiggle);
    yv = cos(radians(angle)) * (rdec*i+50) + fly + random(-jiggle,jiggle);
    
    triangle(flx+10,fly+10,flx-10,fly-10,xv,yv);
    ellipseMode(CENTER);
    ellipse(xv,yv,i/4,i/4);
    
  
    
  }
  stroke(255);
  strokeWeight(2);
  ellipse(flx-15,fly,30+dx*10,30+dx*10); // right eye
  ellipse(flx+15,fly,30+dx*10,30+dx*10); // left eye
  triangle(flx-15,fly+20,flx+15,fly+20,flx,fly+30+dx*20); // mouth
  
  fill(255);
  ellipse(flx-15,fly,10+dx*10,10+dx*10); // right inner eye
  ellipse(flx+15,fly,10+dx*10,10+dx*10); // left inner eye
}
