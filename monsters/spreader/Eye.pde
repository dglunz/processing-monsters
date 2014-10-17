int DAMPER = 1;

class Eye {
  int x, y;
  int size;

  int destX, destY;

  public Eye() {
    this(width/2, height/2, min(width, height)/3);
  }

  public Eye(int a, int b, int c) {
    place(a, b);
    size = c;
  }

  void move(int a, int b) {
    destX = a;
    destY = b;
  }
  
  void place(int a, int b) {
    x = a; 
    y = b;
    destX = x;
    destY = y;
  }

  void tick() {
    if(destX != x) {
      int deltaX = destX - x;
      if(deltaX != 0) {
//        int moveX = deltaX / DAMPER;
        int moveX = deltaX > 0 ? DAMPER : -DAMPER;
        if(moveX != 0) {
          x += moveX;
        } 
        else {
          x = destX;
        }
      } 
      else {
        x = destX;
      }
    }

    if(destY != y) {
      int deltaY = destY - y;
      if(deltaY != 0) {
//        int moveY = deltaY / DAMPER;
        int moveY = deltaY > 0 ? DAMPER : -DAMPER;
        if(moveY != 0) {
          y += moveY;
        } 
        else {
          y = destY;
        }
      } 
      else {
        y = destY;
      }
    }
  }

  void draw() {
    noStroke();
    fill(0);
    ellipse(x, y, size, size/2);

    fill(255);
    int whiteSpotSize = size/3;
    ellipse(x, y, whiteSpotSize, whiteSpotSize);

    int pX = (int) map(mouseX, 0, width, -whiteSpotSize/2, whiteSpotSize/2);
    int pY = (int) map(mouseY, 0, height, -whiteSpotSize/2, whiteSpotSize/2);

    fill(0);
    ellipse(x + pX, y + pY, size/6, size/6);
  }
}




