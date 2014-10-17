void setup() {
size(400, 400);
smooth();
background(255);
noStroke();
}

void draw() {
  float size = 400;
  float j = random(255);
  background(255);
  for(int i=0; i<100; i++) {
  float r = random(255);
  float a = random(50);
  float c = random(50);
  float d = random(50);
  float e = random(50);
  stroke(r);
  ellipse((mouseX + c - d), (mouseY + a - e), 25, 25);
  }
  fill(j);
  float r = random(255);
  stroke(0, 0, 0);
  rect((mouseX - 30), (mouseY - 20), 20, 20);
  rect((mouseX + 15), (mouseY - 20), 20, 20);
  rect((mouseX - ((mouseX*.035)+15)), (mouseY - ((mouseY*.035)+5)), 2, 2);
  rect((mouseX + (((400-mouseX)*.035)+15)), (mouseY - ((mouseY*.035)+5)), 2, 2);
}
