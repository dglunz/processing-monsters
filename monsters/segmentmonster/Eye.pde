class Eye {
  float eyeSize;
  float pupilSize;
  float x;
  float y;
  float pupilX;
  float pupilY;

  Eye(float x, float y) {
    eyeSize = 24;
    pupilSize = 12;
    this.x = x;
    this.y = y;

    pupilX = x;
    pupilY = y;
  }

  void draw() {
    // eyeball
    fill(255);
    ellipse(x, y, eyeSize, eyeSize);
    
    float mX = map(mouseX, 0, height, -eyeSize*0.25, eyeSize*0.25);
    pupilX = x + mX;
    float mY = map(mouseY, 0, height, -eyeSize*0.25, eyeSize*0.25);
    pupilY = y + mY;

    // pupil
    fill(0);
    ellipse(pupilX, pupilY, pupilSize, pupilSize);    
  }
}

