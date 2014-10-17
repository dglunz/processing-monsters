//Written by Hampus Berndtson

int numOfCells = 200;
Cell[] objCell = new Cell[numOfCells];
float spin;
boolean formation;

void setup(){
  frameRate(100);
  size(350,350);
  smooth();
  noCursor();
  float _random = (random(TWO_PI));
  for(int i=0; i<numOfCells; i++){
    objCell[i] = new Cell(0,0,0,0,0,0);
    if(i==0){
      objCell[i] = new Cell(1,50,width/2,height/2,random(TWO_PI),color(255));
    }
  } 
}
void draw(){
  background(255);
  for(int i=0; i<numOfCells; i++){
    if(objCell[i].alive==1){
      objCell[i].move();
      objCell[i].hitTest();
      objCell[i].grow();
      objCell[i].update();
    }
  }
  fill(255);
  stroke(50);
  if(formation){
    spin+=0.03;
  } 
  int x=mouseX;
  int y=mouseY;
  spin+=sqrt(sq(mouseX-pmouseX)+sq(mouseY-pmouseY))/100;
  for(int i=0; i<4; i++){
    beginShape();
    vertex(x+cos(spin+i*PI/2+0.3)*6,y+sin(spin+i*PI/2+0.3)*6);
    vertex(x+cos(spin+i*PI/2+0.2)*10,y+sin(spin+i*PI/2+0.2)*10);
    bezierVertex(x+cos(spin+i*PI/2+0.2)*10,y+sin(spin+i*PI/2+0.2)*10, x+cos(spin+i*PI/2+PI/4)*14,y+sin(spin+i*PI/2+PI/4)*14, x+cos(spin+i*PI/2+PI/2-0.2)*10, y+sin(spin+i*PI/2+PI/2-0.2)*10);
    vertex(x+cos(spin+i*PI/2+PI/2-0.2)*10,y+sin(spin+i*PI/2+PI/2-0.2)*10);
    vertex(x+cos(spin+i*PI/2+PI/2-0.3)*6,y+sin(spin+i*PI/2+PI/2-0.3)*6);
    bezierVertex(x+cos(spin+i*PI/2+PI/2-0.3)*6,y+sin(spin+i*PI/2+PI/2-0.3)*6, x+cos(spin+i*PI/2+PI/4)*8, y+sin(spin+i*PI/2+PI/4)*6,x+cos(spin+i*PI/2+0.3)*6, y+sin(spin+i*PI/2+0.3)*6);
    endShape();
    ellipse(mouseX,mouseY,4,4);
  }
}



