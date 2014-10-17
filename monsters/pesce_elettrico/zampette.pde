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






