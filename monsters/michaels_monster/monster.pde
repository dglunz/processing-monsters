/**

Frigthend Monster by Michael Schieben
2008-11-17
http://www.rockitbaby.de/

for the great monster show
http://rmx.cz/monsters/

A monster that is fritghtend when you move
your mouse to fast.
What I like most:
- eyes in painted 3D
- toNoisyBW function
- the dist(mouseX, mouseY, pmouseX, pmouseY) thing

*/

static boolean BLACK = false;
static boolean WHITE = true;
boolean inverted = false;

int wobble = 10;
int framesSinceFrightend = 0;

void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(9);
  noStroke();

  inverted = false;
  framesSinceFrightend++;
  
  monster(180, 200);
  
  if (wobble < 40) {
    wobble *= 1.5; 
  } else {
    wobble = 40;
  }
  
  if (dist(mouseX, mouseY, pmouseX, pmouseY) > 50) {
    wobble = 10; 
    inverted = !inverted;
    framesSinceFrightend = 0;
    frameRate(30);
  }

  toNoisyBW();
}

void monster(int x, int y) {
  pushMatrix();
  translate(x, y);
  float scatterRange = 20; //45 - map(min(200, framesSinceFrightend), 0, 200, 0, 40);
  translate(random(-scatterRange / 2, scatterRange / 2), random(-scatterRange / 2, scatterRange / 2));
  fill(2);
  rect(0, 0, 300, 350);
  ellipse(150, 0, 300, 300);
  eye(80, 40, x, y);
  eye(230, 40, x, y);
  popMatrix();
}

void eye(int x, int y, int xTrans, int yTrans) {
  pushMatrix();
  
  translate(x, y);
  float tlx = dist(x + xTrans, y, mouseX, y);
  if (mouseX < x + xTrans) {
    tlx *= -1; 
  }
  float tly = dist(x, y + yTrans, x, mouseY);
  if (mouseY < y + yTrans) {
    tly *= -1; 
  }
  fill(250);
  for(int i = 1; i < 10; i++) {
    translate(tlx / wobble, tly / wobble, -2);
    pushMatrix();   
    rotateX(radians(-10 * i) + random(-10, 10));
    rotateY(radians(-10 * i) + random(-10, 10));
    box(90 - wobble, 90 - wobble, 90 - wobble);
    popMatrix();
  }
  popMatrix();
}

void toNoisyBW() {
  loadPixels();
  for (int i = width * height - 1; i > 0; i--) {
    boolean c = WHITE;
    if (random(0, 255) > brightness(pixels[i])) {
      c = BLACK;
    }
    if (inverted) {
      c = !c;
    }
    pixels[i] = (c == WHITE) ? color(255) : color(0); 
  }
  updatePixels(); 
}
