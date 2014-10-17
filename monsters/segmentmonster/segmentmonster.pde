Segment[] s;
float cycle = 0;
float offset = -PI*0.5;
float speed = 0.03;
float targetX = 0;
float targetY = 0;
float aRange = HALF_PI;
float bRange = PI;
float cRange = TWO_PI;
float offSet = 0.33;
Eye e1;
Eye e2;

void setup() {
  size(300, 300);
  smooth();
  frameRate(30);
  fill(255);
  s = new Segment[66];
  for(int i=0; i < s.length; i+=3) {
    s[i] = new Segment(width*0.5, height*0.5, 30, 6);
    s[i+1] = new Segment(s[i].getPin().x, s[i].getPin().y, 30, 6);
    s[i+2] = new Segment(s[i+1].getPin().x, s[i+1].getPin().y, 30, 6);
  }
  e1 = new Eye(width*0.5-16, height*0.5);
  e2 = new Eye(width*0.5+16, height*0.5);
}

void draw() {
  background(255);
  for(int i=0; i < s.length; i+=3) {
    walk(s[i], s[i+1], s[i+2], cycle+i*offSet);
  }

  cycle += speed;

}

void walk(Segment segA, Segment segB, Segment segC, float cyc) {
  float angleA = sin(cyc) * aRange + HALF_PI;
  float angleB = sin(cyc+offset) * bRange;
  float angleC = sin(cyc+offset) * cRange;
  segA.rotation = angleA;
  segB.rotation = segA.rotation + angleB;
  segC.rotation = segB.rotation + angleC;
  segA.x += (mouseX - segA.x) * speed;
  segA.y += (mouseY - segA.y) * speed;
  segB.x = segA.getPin().x;
  segB.y = segA.getPin().y;
  segC.x = segB.getPin().x;
  segC.y = segB.getPin().y;
  segA.render();
  segB.render();
  segC.render();
  
  e1.x = segA.x-12;
  e1.y = segA.y;
  e1.draw();
  e2.x = segA.x+12;
  e2.y = segA.y;
  e2.draw();
}

void mousePressed() {
  aRange = random(TWO_PI);
  bRange = random(TWO_PI);
  cRange = random(TWO_PI);
  speed = random(0.001, 0.05);
  offSet = random(TWO_PI);
}
