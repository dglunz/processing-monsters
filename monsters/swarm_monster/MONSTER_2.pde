// SORRY FOR THE MESS: ANY QUESTIONS PLEASE CONTACT ME SCHAF82@AON.AT


ArrayList Larven;
LARVE tempLARVE;

void setup() {
  size(400,400);
  smooth();
  frameRate(100);
  noCursor();
  background(255);
  Larven = new ArrayList();
  for (int i =0;i < 20;i++){
    Larven.add(new LARVE()); 
  }

}

void draw() {
 background(255);
 
  if ( focused ) {
    pushStyle(); 
    strokeWeight(3);
    stroke(120);
    noFill();
    ellipse(mouseX,mouseY,15,15);
    popStyle();
  }
  for (int i =0;i <Larven.size();i++){
    tempLARVE  = (LARVE) Larven.get(i);
    tempLARVE.CRAWL(Larven);
  }

  for (int i =0;i <Larven.size();i++){
    tempLARVE  = (LARVE) Larven.get(i);
    tempLARVE.EAT(Larven);
    tempLARVE.RENDER();
  }
}





