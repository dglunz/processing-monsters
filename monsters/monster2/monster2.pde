int points = 20; // max points
float cW; // creature width
double vyD,cj,cjc;
float vx,vy,mj,inc; // vertex x,y, current jump
float xdiff = 160;

float[] vxA = new float[points];
float[] vyA = new float[points];




void setup(){
  size(500,400);
  cW = width/1.5;
  mj=height/10;
}

void draw(){
  background(255);
  stroke(0);
  fill(0);
  smooth();
  strokeWeight(3);
  beginShape();
    
  // draw a skeleton first
  for(int i=0; i<points; i++){
   // calculating x position of a vertex
   vx = (width/2 - cW/2) + (cW/points)*i;
   
   // calculating increment for curve (works only if its between 0-10)
   inc = map(i,0,points,0,10);
   // calculating maximum shift (maping it on a frequency curve)
   // http://www-groups.dcs.st-and.ac.uk/~history/Curves/Frequency.html
   // it outpus a value in Double type.. 
   cj = Math.sqrt(2)*Math.exp(-Math.pow(inc-4.6,2.0)/2)*mj;


  // mouse interaction
   if(abs(mouseX-vx)<xdiff){
      cjc = max((mouseY-height/2)/xdiff,-.9);
      if(cjc>1){cjc = 1;}
      cj*=cjc*1.4;
   }else{
     cj = 0;
   }

   vyD = height/2 + cj;
   // double type needs to be converted to float before drawing a vertex
   vy = (float) vyD;

   // drawing vertex
   curveVertex(vx,vy);
   vxA[i]=vx;
   vyA[i]=vy;
  }  
  endShape();
  // skeleton ended
  
  for(int i=0; i<points; i++){
    fill(0);
    rectMode(CENTER);  
    rect(vxA[i], vyA[i], 5, 50);
  }
  
  ellipseMode(CENTER);
  stroke(255);
  ellipse(vxA[7], vyA[7],30,30);
  ellipse(vxA[12], vyA[12],30,30);
  noStroke(); 
  fill(255);
  ellipse(vxA[7], vyA[7],10,10);
  ellipse(vxA[12], vyA[12],10,10);

}


