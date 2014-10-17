class Pelo{

  float x, y;
  float l;
  float a;
  //color colore;

  ////////////////////////////////
  Pelo(float x, float y, float l){
    this.x = x;
    this.y = y; 
    this.l = l;
    this.a = 0; 
    //this.colore = c;  
  }

  ////////////////////////////////
  void paint(){
    //fill(colore);
      float X = x + cos(a) * l;
      float Y = y + sin(a) * l;
      line(x, y, X, Y);
  }
}




