class Cell{
  int alive, crowded;
  float xpos, ypos, direction, energy, weight; 
  float speed = .1;
  int maxenergy = int(random(20))+50;
  color colour;
  Cell (int _a, float _e, float _xpos, float _ypos, float _d, color _c){
    alive = _a;
    energy = _e;
    xpos = _xpos;
    ypos = _ypos;
    direction = _d;
    colour = _c;
  }
  void move(){
    if(mousePressed){
      formation=true;
    } 
    else {
      formation = false;
    }
    if(!formation){
      direction+=(random(PI/8)-PI/16);
    } 
    else {
      direction=(atan2(ypos-mouseY,xpos-mouseX))+PI;
      direction+=random(PI/25)-(PI/50); 
    }
    xpos+=cos(direction)*speed;
    ypos+=sin(direction)*speed;
    if(sqrt(sq(xpos-width/2)+sq(ypos-height/2))>width/2.2){
      xpos=width/2+cos(atan2(ypos-height/2,xpos-width/2))*(width/2.2-1);
      ypos=height/2+sin(atan2(ypos-height/2,xpos-width/2))*(height/2.2-1);
      crowded++;
    } 
  }
  void hitTest(){ 
    for(int j=0; j<numOfCells; j++){
      if(this!=objCell[j]){
        if(objCell[j].alive==1){
          if(sqrt(sq(xpos-objCell[j].xpos)+sq(ypos-objCell[j].ypos))<(objCell[j].weight/2+weight/2)){
            xpos+=cos(atan2(ypos-objCell[j].ypos,xpos-objCell[j].xpos))/3;
            ypos+=sin(atan2(ypos-objCell[j].ypos,xpos-objCell[j].xpos))/3;
            crowded++;
          }
        }
      }
    }
    if(mousePressed){
      if(sqrt(sq(xpos-mouseX)+sq(ypos-mouseY))<weight/4){
        energy-=10;
      }
    }
  }
  void grow(){
    if(crowded==0){
      energy+=.5;
    }
    crowded=0;
    if(energy>maxenergy){
      for(int j=0; j<numOfCells; j++){
        if(objCell[j].alive==0){
          energy=maxenergy/3;
          objCell[j] = new Cell(1,energy,xpos,ypos,random(TWO_PI),color(random(150)+150));
          j=numOfCells;
        }
      }
    }
    if(energy>maxenergy){
      energy=maxenergy;
    }
    if(energy<10){
      energy=0;
      alive=0;
      numOfCells--;
    }
    weight=energy/5+2;
  }
  void update(){
    strokeWeight(1);
    stroke(0);
    fill(colour,150);
    ellipse(xpos,ypos,weight,weight);
    stroke(0,150);
    fill(255,150);
    ellipse(xpos,ypos,weight/2,weight/2);
  }
}



