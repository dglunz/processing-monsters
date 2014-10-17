class VEC3D {// implements Comparable {

  float X,Y,Z;
  int count;

  VEC3D () {
    X = 1;
    Y = 0;
    Z = 0;
    count = 0;
  }

  VEC3D(VEC3D t) {
    X = t.X;
    Y = t.Y;
    Z = t.Z;
    count = 0;
  }

  VEC3D (float x1,float y1,float z1) {
    X= x1; 
    Y = y1; 
    Z= z1; 
    count =0;
  }

  public void ADD_VEC (VEC3D temp) {
    X += temp.X;
    Y += temp.Y;
    Z += temp.Z; 
  }

  public void DIV_VEC (float divid) {
    X /= divid;
    Y /= divid;
    Z /= divid; 
  }

  public void MULT_VEC (float divid) {
    X *= divid;
    Y *= divid;
    Z *= divid; 
  }

  public void NORMALIZE2D () {
    float d = dist(0,0,X,Y);
    X /= d;
    Y /= d;
  }

  float DIST2D() {
    return dist(0,0,X,Y); 
  }
  
  public void PERP2D() {
    float tempX = X;
    X = 0 - Y;
    Y = tempX;
  }
  
  public void FROM_TO(VEC3D FROM,VEC3D TO) {
    X = TO.X - FROM.X;
    Y = TO.Y - FROM.Y;
    NORMALIZE2D();
  }

}

