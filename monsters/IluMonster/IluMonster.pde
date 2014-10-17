void setup() {
 size(400, 400);

 background(255);
 smooth();
}

void draw() {
 eye(width/2, height/2);
}

void eye(int x, int y) {
 background(255);

 stroke(0);
 strokeWeight(map(spikeLength, 80, min(width, height), 2, 8));
 for(int i = 0; i < 360; i+=10) {
   pushMatrix();
   translate(x, y);
   rotate((2*PI/360) * i);
   line(0, 0, random(10, spikeLength), 0);
   popMatrix();
 }

 noStroke();
 fill(0);
 ellipse(x, y, 80, 80);

 fill(255);
 ellipse(x, y, 40, 40);

 int pX = (int) map(mouseX, 0, width, -20, 20);
 int pY = (int) map(mouseY, 0, height, -20, 20);

 fill(0);
 ellipse(x + pX, y + pY, 10, 10);

 if(mousePressed && spikeLength < min(width, height) && frameCount%2 == 0) {
   spikeLength+=2;
 } else if(spikeLength > 80 && frameCount%2 == 0) {
   spikeLength-=2;
 }
}

int spikeLength = 80;
