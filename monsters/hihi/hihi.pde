int hihi;
void setup() {
 size(500,400);
 smooth();
 noStroke();
}

void draw () {
 fill(0);
 background(255);
 translate(mouseX+random(-hihi,hihi),mouseY+random(-hihi,hihi));
 //body
 float r = 50;
 float n = r/1.5;
 float c = r/sqrt(n);
 float deg = 137.5;
 for(float j = n*0.8;j < n;j++) {
   float rNow = c*sqrt(j);
   float x = sin(deg*j)*rNow*0.2;
   float y = cos(deg*j)*rNow;
   ellipse(0,0,r*0.4,r*2);
   pushMatrix();
   translate(x,y);
   int r1 = 20;
   float r2 = r1 + (r1 * 3);
   ellipse(0,0,r1*2.1,r1*2.1);
   for(int i = 0;i<360;i++) {
     beginShape();
     vertex(cos(i-0.02)*r1,sin(i-0.02)*r1);
     vertex(cos(i+random(-0.1,0.1))*r2,sin(i+random(-0.1,0.1))*r2);
     vertex(cos(i+0.02)*r1,sin(i+0.02)*r1);
     endShape(CLOSE);
   }
   popMatrix();
 }
 //eyes
 if(frameCount%20!=0 && !mousePressed) {
   fill(255);
   ellipse(-r/4,-r/2,r*0.35,r*0.35);
   ellipse(r/4,-r/2,r*0.35,r*0.35);
   fill(0);
   ellipse(-r/4,-r/2,r*0.15,r*0.05);
   ellipse(r/4,-r/2,r*0.15,r*0.05);
 }

 if(mousePressed) {
   //mouth
   stroke(255);
   line(-r*0.4,0,r*0.4,0);
   hihi++;
   noStroke();
 } else {
   //mouth
   fill(255);
   ellipse(0,0,r*0.7,r*0.4);
 }
}

void mousePressed() {
 cursor(HAND);
}

void mouseReleased() {
 cursor(ARROW);
 hihi = 0;
}
