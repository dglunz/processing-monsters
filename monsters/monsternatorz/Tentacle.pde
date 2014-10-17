class Tentacle{
  int numSegments = 3;
  float[] x;// = new float[numSegments];
  float[] y;// = new float[numSegments];
  float[] z;// = new float[numSegments];
  float[] angle;// = new float[numSegments];
  float[] zangle;// = new float[numSegments];
  float segLength = 2;
  float targetX, targetY, targetZ;
  float counter = 0;
  int alpha = 255;
  color c = color(255,255,255,alpha);
  int INCREASING = 0;
  int DECREASING = 1;
  int EYE = 2;
  int TYPE = INCREASING;
  
  Tentacle(float nx, float ny, float nz, int nseg, float nseglength){
   numSegments = nseg;
   segLength = nseglength;
   x = new float[numSegments];
   y = new float[numSegments];
   z = new float[numSegments];
   angle = new float[numSegments];
   zangle = new float[numSegments];
   
   x[x.length-1] = nx;     // Set base x-coordinate
   y[x.length-1] = ny;  // Set base y-coordinate
   z[x.length-1] = nz; 
  }
  
  void setBase(float nx, float ny, float nz){
   x[x.length-1] = nx;     // Set base x-coordinate
   y[x.length-1] = ny;  // Set base y-coordinate
   z[x.length-1] = nz; 
  }
  
  float getX(){
   return x[0];  
  }
  
  float getY(){
   return y[0];  
  }
  
  float getZ(){
   return z[0];  
  }
  
  void setTarget(float nx, float ny, float nz){
    targetX = nx; targetY = ny; targetZ = nz;  
  }
  
  void drawMe(){
   float sw = 20;
   reachSegment(0, targetX, targetY, targetZ);
   for(int i=1; i<numSegments; i++) {
     reachSegment(i, targetX, targetY, targetZ);
   }
   for(int i=x.length-1; i>=1; i--) {
     positionSegment(i, i-1);  
   }
  
   if(TYPE == INCREASING){ 
     for(int i=0; i<x.length; i++) {
       segment(x[i], y[i],z[i], angle[i], zangle[i],sw-i*5); 
     }
   }else if(TYPE == DECREASING){
     for(int i=0; i<x.length; i++) {
       segment(x[i], y[i],z[i], angle[i], zangle[i],(i+1)*segLength/sw); 
     }
   }else if(TYPE == EYE){
     for(int i=1; i<x.length; i++) {
       segment(x[i], y[i],z[i], angle[i], zangle[i],(i+1)*segLength/sw); 
     }
   }
  }
  

void positionSegment(int a, int b) {
  x[b] = x[a] + cos(angle[a]) * segLength;
  y[b] = y[a] + sin(angle[a]) * segLength; 
  z[b] = z[a] + sin(zangle[a]) * segLength;
}

void reachSegment(int i, float xin, float yin,float zin) {
  float dx = xin - x[i];
  float dy = yin - y[i];
  float dz = zin - z[i];

  angle[i] = atan2(dy, dx);
  zangle[i] =   atan2(dz, sqrt(dx*dx + dy*dy));
  targetX = xin - cos(angle[i]) * segLength;
  targetY = yin - sin(angle[i]) * segLength;
  targetZ = zin - sin(zangle[i]) * segLength;
}

void segment(float x, float y, float z, float a, float az, float sw) {
  strokeWeight(sw);
  pushMatrix();
    translate(x, y);
    rotate(a);
    line(0, 0, segLength, 0);
  popMatrix();
  strokeWeight(1);
}
}
