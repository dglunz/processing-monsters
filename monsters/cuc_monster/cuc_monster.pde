int num = 50;
int[] x = new int[num];
int[] y = new int[num];
int indexPosicion = 0;

void setup() {
  size(300, 300);
  noStroke();
  smooth();
  fill(0, 102);

}
void draw() {

  background(255);

  x[indexPosicion] = mouseX;
  y[indexPosicion] = mouseY;

  indexPosicion = (indexPosicion + 1) % num;

  for (int i = 0; i < num; i++) {

    int pos = (indexPosicion + i) % num;
    float radius = (num-i) / 2.0;

    ellipse(x[pos], y[pos], radius*0.2, radius*0.2);
    fill(0, 50);
    ellipse(x[pos], y[pos], radius*0.5, radius*0.5);
    fill(0, 90);
    ellipse(x[pos], y[pos], radius*1.5, radius*1.5);
    fill(0, 70);
    ellipse(x[pos]+0.3, y[pos]+0.3, radius*1.9, radius*1.9);

    if (millis()> 2000 && mousePressed) {
      noCursor();
      fill(255);

      ellipse(x[pos]-5,y[pos]-5, 15,15);
      fill(0);
      smooth();
      ellipse(x[pos]-3,y[pos]-3, 10,10);
      fill(255);
      ellipse(x[pos]+10,y[pos]+10,15,15);
      fill(0);
      smooth();
      ellipse(x[pos]+9,y[pos]+9, 10,10);


    }
    else{
      cursor();
    }



  }

}
