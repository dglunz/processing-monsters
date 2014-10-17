
int [] dna = {
  15, 15, 14, 15, 6};
int traitBits = 4;
int [] mutationMask;
float x,y,mySize,spin;
int blinkTime = 300;
int blinkTimer = blinkTime;
float lid = 1.5;
void setup(){
  size(400,400);
  x = width/2;
  y = height/2;
  mySize = 100;
  spin = 0;
  mutationMask = new int[traitBits];
  for(int i = 0; i < traitBits; i++){
    mutationMask[i] = 1<<i;
  }
  smooth();
}
void draw(){
  background(255);//200, 180, 160);
  //mySize = mouseX;
  if(blinkTimer > 0){
    blinkTimer--;
  }
  else if(blinkTimer == 0){
    lid = lid * 0.5;
    if(lid < 0.01){
      blinkTimer--;
    }
  }
  else if(blinkTimer == -1){
    lid += (1.5 - lid) * 0.5;
    if(lid > 1.49){
      blinkTimer = blinkTime;
    }
  }
  spin += 0.01;
  bezierEye(x, y, mySize, mySize * lid, dna, color(200), color(250));//color(150), color(250));//color(60, 40, 200), color(180, 190, 250));//color(200, 40, 60), color(250, 90, 110));

}
void mousePressed(){
  blinkTimer = 0;
}
void bezierEye(float x, float y, float radius, float lift, int [] dna, color col, color highCol){
  float xm = ((-(x-mouseX))/(width*0.5))*radius;
  float ym = ((-(y-mouseY))/(height*0.5))*radius;
  pushMatrix();
  translate(x, y);
  strokeWeight(radius * 0.05);
  // body
  pushMatrix();
  fill(0);
  stroke(0);
  translate(xm*0.02, ym*0.02);
  rotate(spin);
  bezierEllipse(0 + (radius * 1.3), 0, radius * 0.5);
  bezierEllipse(0 - (radius * 1.3), 0, radius * 0.5);
  bezierEllipse(0, 0 + (radius * 1.3), radius * 0.5);
  bezierEllipse(0, 0 - (radius * 1.3), radius * 0.5);
  popMatrix();
  bezierEllipse(xm*0.05, ym*0.05, radius * 1.5);
  pushMatrix();
  noStroke();
  fill(255);
  translate(xm*0.1, ym*0.1);
  rotate(spin);
  bezierEllipse(0 + radius, 0, radius * 0.4);
  bezierEllipse(0 - radius, 0, radius * 0.4);
  bezierEllipse(0, 0 + radius, radius * 0.4);
  bezierEllipse(0, 0 - radius, radius * 0.4);
  popMatrix();
  bezierEllipse(xm*0.1, ym*0.1, radius * 1.2);
  // white and eye
  fill(255);
  stroke(0);
  bezierEllipse(xm*0.15, ym*0.15, radius);
  // iris
  fill(255);
  stroke(0);
  ellipse(xm*0.45, ym*0.45, radius, radius);
  int spokes = dna.length * traitBits;
  float rad = spin + (TWO_PI / spokes);
  stroke(0);
  for(int i = 0; i < dna.length; i++){
    for(int j = 0; j < traitBits; j++){
      if((dna[i] & mutationMask[j]) > 0){
        float ix = (xm*0.45)+cos(rad * (j + i * traitBits)) * radius * 0.5;
        float iy = (ym*0.45)+sin(rad * (j + i * traitBits)) * radius * 0.5;
        line(xm*0.45, ym*0.45, ix, iy);
      }
    }
  }
  // pupil
  fill(0);
  ellipse(xm*0.5, ym*0.5, radius * 0.7, radius * 0.7);
  // highlight
  fill(255);
  noStroke();
  pushMatrix();
  translate(xm*0.15, ym*0.15);
  rotate(-HALF_PI * 0.5);
  ellipse(0, -radius * 0.4, radius * 0.3, radius * 0.9);
  popMatrix();
  // eye lid
  fill(0);
  stroke(0);
  pushMatrix();
  translate(xm*0.15, ym*0.15);
  beginShape(POLYGON);
  vertex(radius, 0);
  bezierVertex(radius, radius * 0.5, radius * 0.5, radius - lift, 0, radius - lift);
  bezierVertex(-radius * 0.5, radius - lift, -radius, radius * 0.5, -radius, 0);
  bezierVertex(-radius, -radius * 0.5, -radius * 0.5, -radius, 0, -radius);
  bezierVertex(radius * 0.5, -radius, radius, -radius * 0.5, radius, 0);
  endShape();
  // eye lid highlight
  fill(highCol);
  noStroke();
  pushMatrix();
  rotate(-HALF_PI * 0.5);
  ellipse(0, -radius * 0.7, radius * 0.6, radius * 0.3);
  popMatrix();
  popMatrix();
  popMatrix();
}


void bezierEllipse(float x, float y, float radius){
  beginShape(POLYGON);
  vertex(x + radius, y);
  bezierVertex(x + radius, y + (radius * 0.5), x + (radius * 0.5), y + radius, x, y + radius);
  bezierVertex(x - (radius * 0.5), y + radius, x - radius, y + (radius * 0.5), x - radius, y);
  bezierVertex(x - radius, y - (radius * 0.5), x - (radius * 0.5), y - radius, x, y - radius);
  bezierVertex(x + (radius * 0.5), y - radius, x + radius, y - (radius * 0.5), x + radius, y);
  endShape();
}


