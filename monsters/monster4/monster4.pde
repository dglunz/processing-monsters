
int count = 150;
float mSw = 10;

float mSm = 100;
float mS = 100;
float rM = 120;
float xv,yv,n,md;
float cPx,cPy;

float[] n1 = new float[count];
float[] angle = new float[count];
float[] radius = new float[count];
float[] sW = new float[count];
float[] aR = new float[count];


void setup(){
  size(500,500);
  cPx = width/2;
  cPy = height/2;
  for(int i=0;i<count;i++){
   n1[i] = random(0,20);
   angle[i] = random(0,360);
   radius[i] = random(rM/4,rM);
   sW[i] = random(1,mSw);
   aR[i] = random(0,.5);
  }
  md = dist(width/2,height/2,width,height);
}

void draw(){
 background(255);
 stroke(0);
 noFill();
 for(int i=0;i<count;i++){
   strokeWeight(sW[i]);
   // end points of bezier are positioned on a virtual circle around centre point
   //xv = sin(radians(random(0,360))) * random(radius/4,radius) + cPx;
   //yv = cos(radians(random(0,360))) * random(radius/4,radius) + cPy;
   xv = sin(radians(angle[i])) * radius[i] + cPx;
   yv = cos(radians(angle[i])) * radius[i] + cPy;
   angle[i]+=aR[i];
   
   //  bezier(cPx,cPy,cPx+random(-mS,mS),cPy + random(-mS,mS),xv+random(-mS,mS),yv+random(-mS,mS),xv,yv);
   bezier(cPx,cPy,cPx+((noise(n+n1[i]))*2*mS)-mS,cPy +((noise(n+n1[i]+5.2))*2*mS)-mS, xv+((noise(n+n1[i]+7.4))*2*mS)-mS,yv+((noise(n+n1[i]+8.7))*2*mS)-mS,xv+((noise(n+n1[i]+8.7))*2*20)-20,yv+((noise(n+n1[i]+8.7))*2*20)-20);
   n+=.001;
 }
 
 
   float d = dist(width/2, height/2, mouseX, mouseY);
   float dx = abs((d/md)-1);
   println(dx);
   mS = dx* mSm; 
   
  ellipseMode(CENTER);
  stroke(255);
  ellipse(width/2, height/2,20,20);
  noStroke(); 
  fill(255);
  ellipse(width/2, height/2,5,5);
   
}
