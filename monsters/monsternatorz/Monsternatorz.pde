
Monsternator TheMonsternator;
ArrayList monsters;

void setup(){
  size(600,500,JAVA2D);
  background(255,255,255);
  ellipseMode(CENTER);
  smooth();
  TheMonsternator = new Monsternator();
  monsters = new ArrayList();
  monsters.add(new Monster1());
}

void draw(){
  background(255);
  line(0,20,width,20);
  int closest = findClosestMonsterIndex();
  if(closest >=0){
    TheMonsternator.targetX = ((Monster1)monsters.get(closest)).flx;
    TheMonsternator.targetY = ((Monster1)monsters.get(closest)).fly;   
  }
  for(int i = 0; i < monsters.size(); i++){
    if(TheMonsternator.isCloseToCatching((Monster1)monsters.get(i))){
      ((Monster1)monsters.get(i)).STATE = ((Monster1)monsters.get(i)).CAUGHT;
    }  
  }
  if(monsters.isEmpty()){
   TheMonsternator.drawMe(mouseX,mouseY); 
  }else{
    TheMonsternator.drawMe();
  }
  drawMonsters();
  
  eliminateDeadMonsters();
}

void drawMonsters(){
 for(int i = 0; i < monsters.size(); i++){
  Monster1 m = (Monster1)monsters.get(i);
  m.drawMe();
 } 
}

int findClosestMonsterIndex(){
  int closest = 0;
  float min;

  if(!monsters.isEmpty()){
      Monster1 m = (Monster1)monsters.get(0);
      min = dist(TheMonsternator.eye.x[0], TheMonsternator.eye.y[0],
                  m.flx,m.fly);
    for(int i = 0; i < monsters.size();i++){
      m = (Monster1)monsters.get(i);
      float d = dist(TheMonsternator.eye.x[0],TheMonsternator.eye.y[0],
                     m.flx,m.fly);
      if(d < min) closest = i;
      
    }
    
    return closest;
  }else return -1;  
}

void mousePressed(){
   monsters.add(new Monster1());
}

void eliminateDeadMonsters(){
 for(int i = 0; i < monsters.size(); i++){
  Monster1 m = (Monster1) monsters.get(i);
  if(dist(m.flx,m.fly,TheMonsternator.x,TheMonsternator.y) < 5){
   monsters.remove(i); 
  }
 } 
}
