float testa_w;
float testa_h;

//_________________________________
void setup(){
  size(555,555);
  smooth();

  testa_w=77;
  testa_h=50;
}
//_________________________________
//_________________________________
void draw(){
  background(255,255,255,1);
  fill(0);
  stroke(255);

  float testa_x=width/2 +(mouseX-width/2)*0.5;
  float testa_y=height/2 +(mouseY-height/2)*0.5;

  float bocca_x = testa_x;
  float bocca_y = testa_y+30;

  //zampette
  zampa( 50, 300, testa_x, testa_y);
  zampa(150, 300, testa_x, testa_y);
  zampa(250, 300, testa_x, testa_y);
  zampa(350, 300, testa_x, testa_y);


  //testa_______________________
  ellipse(testa_x,testa_y,testa_h+83,testa_w-12);
  fill(0);

  fill(255);
  strokeWeight(1);

  float diamBocca=sin (frameCount*0.08)*30;
  fill(0);
  ellipse(bocca_x,bocca_y,diamBocca+33,diamBocca);

  float diamBocca1=sin (frameCount*0.01)*70;
  fill(0);
  ellipse(bocca_x-3,bocca_y-3,diamBocca1+33,diamBocca1);
   fill(0);


  float x1 =testa_x/2;
  float y1 =testa_y;
  float x2 =testa_x;
  float y2 =testa_y+20;
  float x3 = testa_x-53;
  float y3 = 97;

 triangle(testa_x-10, testa_y, x2+11, y2+55, x3, y3);

  float ax1 =testa_x;
  float ay1 =testa_y/2;
  float ax2 =testa_x+20;
  float ay2 =testa_y;
  float ax3 = testa_y-53;
  float ay3 = testa_y-53;

 triangle(testa_x, testa_y, x2, y2+15, ax3, ay3);

 float bx1 =testa_x;
  float by1 =testa_y/2;
  float bx2 =testa_x/12;
  float by2 =testa_y;
  float bx3 = testa_y-53;
  float by3 = testa_y-53;

 triangle(testa_x, testa_y-2, x2+11, y2+55, bx3-20, by3-22);

float occhio_x = testa_x;
  float occhio_y = testa_y+30;
  fill(255);
  ellipse (testa_x,testa_y,60,60);

  float diamOcchio1=sin (frameCount*0.8)*90;
  float occhio1_x = testa_x;
  float occhio1_y = testa_y+30;
  fill(0);

  ellipse (testa_x,testa_y,diamOcchio1,diamOcchio1);


}


void zampa(float zampa_x,float zampa_y,float testa_x,float testa_y){
  float gx = testa_x+(zampa_x-testa_x)/3;
  float gy = testa_y+(zampa_y-testa_y)/3;

  gy = gy + sin(frameCount *0.1) * 60;

  stroke (0);


  line (zampa_x-30,zampa_y-30,gx,gy);
  line(gx,gy,testa_x,testa_y);

  line (zampa_x+30,zampa_y+30,gx,gy);
  line(gx,gy,testa_x+10,testa_y+10);

  line (zampa_x-1,zampa_y-1,gx,gy);
  line(gx,gy,testa_x+2,testa_y+1);

  line (zampa_x-50,zampa_y-50,gx,gy);
  line(gx,gy,testa_x+2,testa_y+1);


  noStroke();
  fill(0);
  float diamPiedino=sin (frameCount*0.8)*20;
  ellipse(gx,gy,10,12);
  ellipse(zampa_x-30,zampa_y-30,diamPiedino,diamPiedino);

  float diamPiedino1=sin (frameCount*2)*17;
  ellipse(gx+0,gy+3,6,8);
  ellipse(zampa_x+30,zampa_y+30,diamPiedino1,diamPiedino1);

  float diamPiedino2=sin (frameCount*0.2)*10;
  ellipse(gx,gy,10,12);
  ellipse(zampa_x-1,zampa_y-1,diamPiedino2,diamPiedino2);


  float diamPiedino3=sin(frameCount*0.7)*33;
  ellipse(gx,gy,10,12);
  ellipse(zampa_x-50,zampa_y-50,diamPiedino3,diamPiedino3);

}
