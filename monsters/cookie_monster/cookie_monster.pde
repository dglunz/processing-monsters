/**
 * Cookie Monster
 *
 * Dethe Elza
 * 
 * Created 23 November 2008
 */
 
Cookie[] cookies;
int no_cookies;
int top, bottom, left, right;
 
void setup(){
    size(600, 600);
    right = width / 2;
    left = -right;
    bottom = height / 2;
    top = -bottom;
    frameRate(20);
    smooth();
    noStroke();
    no_cookies = 24;
    cookies= new Cookie[no_cookies];
    for (int i = 0; i < no_cookies; i++){
      cookies[i] = new Cookie(random(left, right), random(top, bottom), 50, 6);
    }
}

void draw(){
    background(255);
    translate(right, bottom);
    for (int i = 0; i < no_cookies; i++){
        cookies[i].update();
    }
}

class Cookie{
  float x, y;
  int radius;
  PositionedCircle[] chips;
  int no_chips;
  PositionedCircle cookie;
  Cookie(float posx, float posy, int rad, int noChips){
    x = posx;
    y = posy;
    radius = rad;
    no_chips = noChips;
    chips = new PositionedCircle[noChips];
    for (int i=0; i < noChips; i++){
      float offsetAngle = radians(random(256));
      float offsetDistance = random(radius - 5);
      float dx = x + cos(offsetAngle) * offsetDistance;
      float dy = y + sin(offsetAngle) * offsetDistance;
      chips[i] = new PositionedCircle(dx, dy, 5, 255);
    }
    cookie = new PositionedCircle(x,y,radius, 0);
  }
  void update(){
      float direction;
      float magnitude;
      int adjustedMouseX = mouseX - right;
      int adjustedMouseY = mouseY - bottom;
      float dX = x - adjustedMouseX;
      float dY = y - adjustedMouseY;
      println("cookieX: " + x + ", cookieY: " + y);
      println("mouseX: " + mouseX + ", mouseY: " + mouseY);
      println("dX: " + dX + ", dY: " + dY);
      direction = atan2(dY, dX) + radians(random(-5,5));
      magnitude = sqrt(dX * dX + dY * dY) + random(-5, 5);
      println("magnitude: " + magnitude);  
      cookie.update(direction, magnitude);
      for (int i = 0; i < no_chips; i++){
        chips[i].update(direction, magnitude);
      }
      x = cookie.x;
      y = cookie.y;
   }
}

class PositionedCircle{
    float x;
    float y;
    int radius;
    int _color;
    PositionedCircle(float xpos, float ypos, int rad, int col){
        x = xpos;
        y = ypos;
        radius = rad;
        _color = col;
    }
    void update(float direction, float magnitude){
      if (magnitude > 200){
        magnitude *= -1;
        direction = atan2(y,x);
      }
      x += cos(direction) * (magnitude / 20);
      y += sin(direction) * (magnitude / 20);
      fill(_color);
      ellipse(x,y,radius, radius);
    }
}
