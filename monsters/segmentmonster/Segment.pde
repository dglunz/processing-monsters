class Segment {
  float x;
  float y;
  float w;
  float h;
  float rotation;
  PVector v;
  
  Segment(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    v = new PVector();
  }
  
  void render() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    fill(0);
    noStroke();
    rect(0, -h*0.5, w, h);
    popMatrix();
  }
  
  PVector getPin() {
    v.x = x + cos(rotation) * w;
    v.y = y + sin(rotation) * w;
    return v;
  }
}
