class Pelliccia{
  Pelo[] peli;
  float nX, nY; //noise offset

  /////////////////////////////////////
  Pelliccia(float px, float py, float rad, int numPeli, float lPelo){
    peli = new Pelo[0];  
    nX = 0.0;
    nY = 0.0;
    for (int i=0; i<numPeli; i++){
      float r = random(rad*rad);
      float x = px + cos(TWO_PI/numPeli*i) * sqrt(r);
      float y = py + sin(TWO_PI/numPeli*i) * sqrt(r);
      /*
      color col;
       float c = noise(x * 0.01, y * 0.01);
       if (c < 0.5) {
       col = color(0);
       } else {
       col = color(200);
       }
       */
      addPelo(x,y,lPelo);
    }
  } 

  /////////////////////////////////////
  void setLen(float l){
    for (int i=0; i<peli.length; i++){
      peli[i].l = l;
     }
  }
  /////////////////////////////////////
  void addPelo(float x, float y, float l){
    peli = (Pelo[])append(peli, new Pelo(x,y,l));
  }

  /////////////////////////////////////
  void wave(float nScale, float incX, float incY){
    nX += incX;
    nY += incY;
    for (int i=0; i<peli.length; i++){
      peli[i].a = noise(peli[i].x*nScale+nX, peli[i].y*nScale+nY) * TWO_PI;
    }
  }

  /////////////////////////////////////
  void paint(){
    //stroke(0);
    for (int i=0; i<peli.length; i++){
      peli[i].paint();
    }
  }  
}








