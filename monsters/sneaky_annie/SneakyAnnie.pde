Monster monster;

void setup() {
  size(400,400,P2D);
  noSmooth();
  frameRate(30);
  
  monster = new Monster(60);
}

void draw() {
  background(255);
  monster.update();
  monster.draw();
} 

void mousePressed() {
  monster.rotation = atan2(mouseY - monster.y, mouseX - monster.x);
}

class Monster {
  int size = 60;
  int eyeX = 13, eyeY = -16, eyeSize = 20;
  int inEyeX = 17, inEyeY = -18, inEyeSize = 8;
  float speed = 5, rotSpeed = radians(3), maxMouthOpening = radians(30);
  
  float x, y;
  float rotation;
  float dx, dy;
  
  Monster(int size) {
    x = width / 2;
    y = height / 2;
  }
  
  void update() {
    if(dx != 0 || dy != 0) { // jumping
      x += dx;
      y += dy;
    
      float minWallDist = min(new float[]{monster.x, width - monster.x,monster.y, height - monster.y});   
      if(minWallDist <= 10) {
        x -= dx;
        y -= dy;
        dx = dy = 0; 
      }
    }
    
    if(dx == 0 && dy == 0) {
      float dr = constrain(atan2(mouseY - y, mouseX - x) - rotation,-rotSpeed,rotSpeed);
      rotation += dr;
      if(dr == 0) {
        dx = speed * cos(rotation);
        dy = speed * sin(rotation);
      }      
    }
  }
    
  void draw() { 
    pushMatrix();
    
    translate(int(x),int(y));
    rotate(rotation);
    
    float mDist = sqrt(sq(x - mouseX) + sq(y - mouseY));
    float mouthProx = constrain(norm(mDist,width / 4,15),0,1); 
    float mouthOpening = lerp(0,maxMouthOpening, mouthProx);
    
    float minWallDist = min(new float[]{monster.x, width - monster.x,monster.y, height - monster.y}); 
    float wallProx = constrain(norm(minWallDist,10,width/3),0,1);
    int col = int(lerp(0,255,wallProx));

    noStroke();
    fill(255-col);
    arc(0,0,size,size,mouthOpening,TWO_PI - mouthOpening);
    
    stroke(0+col);
    fill(255);
    ellipse(eyeX,eyeY,eyeSize,eyeSize);

    noStroke();    
    fill(0);
    ellipse(inEyeX,inEyeY,inEyeSize,inEyeSize);
    
    popMatrix();
  }
}
