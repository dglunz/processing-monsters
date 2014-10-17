/**
 * I dont know if this already exists somewhere in the libraries,
 * but i guess so, anyway, now i dont have to search for it, 
 * perhaps its useful to others, too.
 */

class Vector2d {
  float x; 
  float y;

  Vector2d() {
    this.x = 0; 
    this.y = 0;
  }
  Vector2d(float x, float y) {
    this.x = x; 
    this.y = y;
  }
  Vector2d(Vector2d vector) {
    this.setVt(vector);
  }
  void setVt(Vector2d vector) {
    this.x = vector.x; 
    this.y = vector.y;
  }
  boolean equalVt(Vector2d vector) {
    return this.x == vector.x & this.y == vector.y;
  }
  float lengthVt() {
    return sqrt(this.x * this.x + this.y * this.y);
  }
  void scaleVt(float s) {
    this.setVt(scaleVtScal(this, s));
  }
  void addVt(Vector2d vector) {
    this.setVt(addVts(this, vector));
  }
  void diffVt(Vector2d vector) {
    this.setVt(diffVts(this, vector));
  }
  void multVt(Vector2d vector) {
    this.setVt(multVts(this, vector));
  }
  void multScal(float s) {
    this.setVt(multVtScal(this, s));
  }
  void divScal(float s) {
    this.setVt(divVtScal(this, s));
  }
  float scalarPrVt(Vector2d vector) {
    return scalarPrVts(this, vector);
  }
  void rotateVt(Vector2d center, float angle) {
    this.setVt(rotateVtS(this, center, angle));
  }
}

// staic functions, i hope the names are not too confusing
Vector2d scaleVtScal(Vector2d vector, float s) {
  float len = vector.lengthVt();
  if (len != 0) {
    return multVtScal(divVtScal(vector, len), s);
  }
  return null;
}
Vector2d addVts(Vector2d vector1, Vector2d vector2) {
  return new Vector2d(vector1.x + vector2.x, vector1.y + vector2.y);
}
Vector2d diffVts(Vector2d vector1, Vector2d vector2) {
  return new Vector2d(vector1.x - vector2.x, vector1.y - vector2.y);
}
Vector2d multVts(Vector2d vector1, Vector2d vector2) {
  return new Vector2d(vector1.x * vector2.x, vector1.y * vector2.y);
}
Vector2d multVtScal(Vector2d vector, float s) {
  return new Vector2d(vector.x * s, vector.y * s);
}
Vector2d divVtScal(Vector2d vector, float s) {
  if (s != 0) {
    return new Vector2d(vector.x / s, vector.y / s);
  }
  return null;
}
float scalarPrVts(Vector2d vector1, Vector2d vector2) {
  return vector1.x * vector2.x + vector1.y * vector2.y;
}

Vector2d rotateVtS(Vector2d vector, Vector2d center, float angle) {
  Vector2d tmp = diffVts(vector, center);
  return addVts(center, new Vector2d(tmp.x * cos(angle) - tmp.y * sin(angle), tmp.x * sin(angle) + tmp.y * cos(angle)));
}

