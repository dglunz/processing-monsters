 
 
///MONSTER BY MOVOPE:DE
// DON'T BE SCARED !!!!
 
float a;                          // Angle of rotation
float offset = PI/24.0;             // Angle offset between boxes
int num = 12;                     // Number of boxes
int polyAnz=40;
int eyeDist=40;



void setup() 
{ 
  size(400, 400, P3D);    
  frameRate(25);
} 
 

void draw() 
{     
  background(255);
  translate(width/2, height/2);
  
  translate(sin(millis()/200)*(10+mouseX/5),sin(millis())*(10+mouseX/2-100),0);
  a += 0.01;   
  float rot= ((mouseX*100)/width * HALF_PI)/100 - HALF_PI/2;
  float rotX= ((height-mouseY*50)/height * HALF_PI)/100 + HALF_PI/4;
// EYES
  pushMatrix();
    rotateY(rot);
    rotateX(rotX);
   // rotateX(a/2 + offset*5);
  // box(2,150,2);
   stroke(0);
   noFill();
   translate(-eyeDist,-60,0);
    for(int i=0; i<20; i++)
    {
      box(40+random(40));
      rotate(random(1));
    }
    popMatrix();
    
    pushMatrix();
    rotateY(rot);
    rotateX(rotX);
    translate(eyeDist,-60,0);
    for(int i=0; i<20; i++)
    {
      box(40+random(40));
      rotate(random(1));
    }
    popMatrix();
  
    pushMatrix();
    fill(0);
    rotateY(rot);
    rotateX(rotX);
    translate(-eyeDist,-60+mouseY/20-15,0);
    for(int i=0; i<20; i++)
    {
      box(10+random(10));
      rotate(random(1));
    }
    popMatrix();
  
      pushMatrix();
    fill(0);
    rotateY(rot);
    rotateX(rotX);
    translate(eyeDist,-60+mouseY/20-15,0);
    for(int i=0; i<20; i++)
    {
      box(10+random(10));
      rotate(random(1));
    }
    popMatrix();
// MOUTH
    pushMatrix();
    rotateY(rot);
    rotateX(rotX);
   // rotateX(a/2 + offset*5);
   stroke(0);
   noFill();
   translate(0,20,0);
    for(int i=0; i<20; i++)
    {
      box(100+random(40));
      rotate(random(1));
    }
    popMatrix();
    
     pushMatrix();
    rotateY(rot);
    rotateX(rotX);
   // rotateX(a/2 + offset*5);
   stroke(0);
   noFill();
   translate(0,20,0);
    for(int i=0; i<20; i++)
    {
      box(40+random(40));
      rotate(random(1));
    }
    popMatrix();
    
   pushMatrix();
    rotateY(rot);
    rotateX(rotX);
   // rotateX(a/2 + offset*5);
   stroke(0);
   noFill();
   translate(0,20,0);
    for(int i=0; i<10; i++)
    {
      box(50+random(70),30+random(10),30+random(10));
      rotateX(random(1));
    }
    popMatrix();
    
 
    
    
    fill(255);
    
    pushMatrix();
    translate(0,50,0);

    popMatrix();
} 
