float[] xPos, pxPos;
float[] yPos, pyPos;
color[] fillColor;
final int sizeOf = (int)sq(16);
final int index = (int)sqrt(sizeOf);
final int dimension = 5;
boolean teleport = false;
int[] pic = {     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0,
                  0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,
                  0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

void setup() {
  size(555, 555);
  background(255);
  noStroke();
  fill(0);
  frameRate(50);
  
  xPos = new float[sizeOf];
  yPos = new float[sizeOf];
  pxPos = new float[sizeOf];
  pyPos = new float[sizeOf];
  fillColor = new color[sizeOf];
  
  for(int i = 0;i < sizeOf;i++) {
    xPos[i] = width/2-(index/2*dimension)+(i%index)*dimension;
    yPos[i] = height/2-(index/2*dimension)+(i/index)*dimension;
    pxPos[i] = width/2-(index/2*dimension)+(i%index)*dimension;
    pyPos[i] = height/2-(index/2*dimension)+(i/index)*dimension;
    if(pic[i] == 1) {
      fillColor[i] = color(255);
    } else {
      fillColor[i] = color(0);
    }
  }
}

void draw() {
  background(255);


  for(int i = 0;i < sizeOf;i++) {
    if(pxPos[i] != xPos[i] && pyPos[i] != yPos[i] && random(100) < 50) {
      pxPos[i] += (xPos[i] - pxPos[i])*0.2;
      pyPos[i] += (yPos[i] - pyPos[i])*0.2;
    }
      fill(fillColor[i]);
      ellipse(pxPos[i], pyPos[i], dimension, dimension);
//      pxPos[i] = xPos[i];
//      pyPos[i] = yPos[i];
  }
}

void update() {
    for(int i = 0;i < sizeOf;i++) {
      xPos[i] = mouseX-(index/2*dimension)+(i%index)*dimension;
      yPos[i] = mouseY-(index/2*dimension)+(i/index)*dimension;
    }
}

void mouseReleased() {
  update();
  teleport = true;
}
