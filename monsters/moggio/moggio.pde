Pelliccia p, e1, e2;
float ix, iy;
////////////////////////////////
void setup(){
  size(555,555,P3D);  
  
  float ox = width/2;
  float oy = height/2;
  p  = new Pelliccia(ox,        oy,        200.0, 7000,  17.0);  
  e1 = new Pelliccia(ox - 57.0, oy - 42.0, 12.0,    65,  17.0); 
  e2 = new Pelliccia(ox + 51.0, oy - 35.0, 12.0,    65,  17.0); 
  
  ix = 0.0;
  iy = 0.0;

  noFill();
  stroke(0);
}


////////////////////////////////
void draw(){
  background(255); 

  float mx,my;
  if (!mousePressed){
    mx = cos(ix*0.00013) * 0.015;
    my = sin(iy*0.00012) * 0.015;
  } 
  else {
    mx = constrain(pmouseX - mouseX, -10, 10) * 0.01;
    my = constrain(pmouseY - mouseY, -10, 10) * 0.01;
  }
  ix += (mx - ix) * 0.05;
  iy += (my - iy) * 0.05;

  p.wave(0.006, ix, iy);  
  p.paint();
  e1.wave(0.006, ix, iy);
  e1.paint();
  e2.wave(0.006, ix, iy);
  e2.paint();
}
////////////////////////////////
void keyPressed(){
  save("moggio.png");
}


