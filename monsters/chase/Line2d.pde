
class Line2d {
  Vector2d o;
  Vector2d u;

  Line2d(Vector2d o, Vector2d u) {
    this.o = o; 
    this.u = u;
  }
  Line2d(Line2d line2d) {
    this.o = new Vector2d(line2d.o); 
    this.u = new Vector2d(line2d.u);
  }
  Vector2d getPtU() {
    return addVts(this.u, this.o);
  }
  float lengthLn() {
    return this.u.lengthVt();
  }
  boolean isParallel(Line2d line2d) {
    return this.u.equalVt(line2d.u);
  }
}

boolean pointOnLine(Line2d line2d, Vector2d vector) {
  // find out, if point is really on the line
  Vector2d newO = addVts(line2d.o, scaleVtScal(line2d.u, line2d.u.lengthVt() / 2));
  if (abs(diffVts(newO, vector).lengthVt()) <= line2d.u.lengthVt() / 2) {
    return true;
  }
  return false;
}

Vector2d intersectionLn(Line2d line1, Line2d line2) {
  // found this on the internet, thanks to Darel Rex Finley
  if (line1 != null && line2 != null) {
    //  public domain function by Darel Rex Finley, 2006
    //
    //  Determines the intersection point of the line defined by points A and B with the
    //  line defined by points C and D.
    //  Returns YES if the intersection point was found, and stores that point in X,Y.
    //  Returns NO if there is no determinable intersection point, in which case X,Y will
    //  be unmodified.

    float Ax = line1.o.x; 
    float Ay = line1.o.y;
    float Bx = line1.getPtU().x; 
    float By = line1.getPtU().y;
    float Cx = line2.o.x; 
    float Cy = line2.o.y;
    float Dx = line2.getPtU().x; 
    float Dy = line2.getPtU().y;


    float distAB;
    float theCos;
    float theSin;
    float newX;
    float ABpos;

    // Fail if either line is undefined.
    if (Ax==Bx && Ay==By || Cx==Dx && Cy==Dy) { 
      return null; 
    }

    //  (1) Translate the system so that point A is on the origin.
    Bx-=Ax; 
    By-=Ay;
    Cx-=Ax; 
    Cy-=Ay;
    Dx-=Ax; 
    Dy-=Ay;

    //  Discover the length of segment A-B.
    distAB=sqrt(Bx*Bx+By*By);

    //  (2) Rotate the system so that point B is on the positive X axis.
    theCos=Bx/distAB;
    theSin=By/distAB;

    newX=Cx*theCos+Cy*theSin;
    Cy  =Cy*theCos-Cx*theSin; 
    Cx=newX;

    newX=Dx*theCos+Dy*theSin;
    Dy  =Dy*theCos-Dx*theSin; 
    Dx=newX;

    //  Fail if the lines are parallel.
    if (Cy==Dy) { 
      return null; 
    }

    //  (3) Discover the position of the intersection point along line A-B.
    ABpos=Dx+(Cx-Dx)*Dy/(Dy-Cy);

    //  (4) Apply the discovered position to line A-B in the original coordinate system.
    Vector2d v = new Vector2d(Ax+ABpos*theCos, Ay+ABpos*theSin);

    if (pointOnLine(line1, v) & pointOnLine(line2, v)) {
      return v;
    }
  }
  return null;
}

