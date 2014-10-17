Monsta monsta;
int monstaPosX = 300;
boolean isAngry = true;

void setup() {
  size(600,250);
  colorMode(RGB,255);
  background(255);
  monsta = new Monsta();
}

void draw() {
  fill(255,255,255);
  noStroke();
  rect(0,0,600,250);
  if ( mousePressed == true ) {
    if ( mouseButton == LEFT ) {
      monsta.moodAngry();
      isAngry = true;
      if ( mouseX < ( monstaPosX + 30 ) ) {
        monstaPosX--;
        monstaPosX--;
      }
      else {
        monstaPosX++;
        monstaPosX++;
      }
    }
    if ( mouseButton == RIGHT ) {
      monsta.moodAfraid();
      isAngry = false;
      if ( mouseX < monstaPosX ) {
        monstaPosX++;
      }
      else {
        monstaPosX--;
      }
    }
  }

  monsta.drawMe(monstaPosX,110);

  if ( isAngry ) {
    ellipse(mouseX,mouseY,7,7);
  } 
  else {
    rect(mouseX,mouseY,7,7);
  }

}




class Monsta {
  int x,y;
  Eye leftEye, rightEye;

  Monsta() {
    leftEye = new Eye(20,2);
    rightEye = new Eye(20,1);

  }

  void drawMe(int x, int y) {
    fill(0,0,0);
    smooth();
    stroke(0,0,0);
    strokeCap(ROUND);
    strokeWeight(4);  
    rect(x,y+40,65,70);
    fill(255,255,255);
    rect(x-3,y+70,71,20);
    line(x,y+80,x+65,y+80);
    for (int lauf = 0; lauf < 6; lauf++) {
      line(x+8+(lauf*10),y+70,x+8+(lauf*10),y+90);
    }

    leftEye.drawMe(x,y);
    rightEye.drawMe(x+45,y);
  
    curve(x-random(19),y+random(-50,50),x,y+110,x-23,y+130,x,y-random(-40,40));
    curve(x-random(19)+20,y+random(-50,50),x+20,y+110,x-23+20,y+130,x+20,y-random(-40,40));
    curve(x+65+random(19),y+random(-50,50),x+65,y+110,x+23+65,y+130,x,y-random(-40,40));
    curve(x+45+random(19),y+random(-50,50),x+45,y+110,x+23+45,y+130,x,y-random(-40,40));
    
  }

  void moodAngry() {
    leftEye.setBrow(2);
    rightEye.setBrow(1);
  }

  void moodAfraid() {
    leftEye.setBrow(1);
    rightEye.setBrow(2);
  }

}

class Eye {
  int sizeX,brow;

  Eye(int sizeX, int brow) {
    this.sizeX = sizeX;
    this.brow  = brow;
  }

  void drawMe(int x, int y) {

    noFill();
    smooth();
    stroke(0,0,0);
    strokeCap(ROUND);
    strokeWeight(4);  
    rect(x,y,sizeX,sizeX);
    line(x+(this.sizeX/2),y+this.sizeX,x+(this.sizeX/2),y+this.sizeX+20);
    if ( this.brow == 1 ) {
      line(x-(this.sizeX*0.3)-4,y+(this.sizeX*0.3)-4,x+(this.sizeX*0.3)-4,y-(this.sizeX*0.3)-4);
    }
    else {
      line(x+this.sizeX-(this.sizeX*0.3)+4,y-(this.sizeX*0.3)-4,x+this.sizeX+(this.sizeX*0.3)+4,y+(this.sizeX*0.3)-4);
    }

    this.updateIris(x,y);


  }

  void setBrow(int brow) {
    this.brow = brow;
  }

  private void updateIris(int x, int y) {
    float offsetX, offsetY;
    if ( (x+(this.sizeX*0.5)) < mouseX ) {
      offsetX = 0.75;
    } 
    else {
      offsetX = 0.25;
    }

    if ( (y+(this.sizeX*0.5)) < mouseY ) {
      offsetY = 0.75;
    } 
    else {
      offsetY = 0.25;
    }
    ellipse(x+(this.sizeX*offsetX),y+(this.sizeX*offsetY),1,1);
  }

}
