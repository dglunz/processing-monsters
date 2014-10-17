//BlobbyBlinky

//This is a Processing monster made of circles that gets bigger as 
//you put your cursor closer to the center
//and the blinking will change too

color c1 = color (0); // 
color c2 = color (255);//
color blink = color (255);
int sideSide = 0;
int upDown = 0;


int centerX = 320; // width/2;
int centerY = 240; //height/2;

int eyeX = centerX;
int eyeY = centerY;

int spread = 2; //This is how much the blobs spread out.  The smaller number the more the spread
int diameter = 120;  //Diameter of circles
int turn = 0;  // This is how many "turns"have passed

void setup(){
  size(640,480);
  noStroke();
  
}

void draw (){
//reset the image by making the background balnk
   int zeroOrOneThree = int(random(2));
     
  background(zeroOrOneThree*255);
  smooth();
  


// Draw some triangles in the background

   int zeroOrOneTwo = int(random(2));
    fill(zeroOrOneTwo*255); 
quad(centerX,centerY,width/4,0,0,0,0,height/4);
quad(centerX,centerY,.75*width,0,width,0,width,.25*height);
quad(centerX,centerY,width,.75*height,width,height,.75*width,height);
quad(centerX, centerY,.25*width,height,0,height,0,.75*height);

 
  
sideSide = mouseX;
upDown = mouseY;  
  
//find the absolute value from the center point of the screen based on where your mouse is 
  int distanceFromCenter = (abs((centerX)-sideSide) + abs((centerY)-upDown))/2;
  

  
for (int num = 0; num < 10; num++)
  {
    //Pick any number you want. (As long as it is 0 or 1)
    int zeroOrOne = int(random(2));
    fill(zeroOrOne*255); 
    
    int xLow = (centerX) - (distanceFromCenter/spread);
    int xHigh = (centerX) + (distanceFromCenter/spread);
    int yLow = (centerY) - (distanceFromCenter/spread);
    int yHigh = (centerY) + (distanceFromCenter/spread);
    
    
    //Draw the circles in a range
    int ranX = int(random(xLow,xHigh));
    int ranY = int(random(yLow,yHigh));   
    ellipse(ranX,ranY,diameter,diameter);
  } 
  
  
  //Blinky Eyeball Part
  if (turn%600 == 0)
  {
    blink = (0);
  }
  if (turn%635 == 0)
  {
    blink = (255);
  }
  
  
  //Draw the Eyeball
  ellipseMode(CENTER);
  stroke(0);
  fill(blink);
  ellipse(centerX, centerY,20,20);
  //Make Eyeball Move
  
  int rollSide = int((centerX-mouseX)/60);
  
  int rollUp = int((centerY-mouseY)/50);
  
  noStroke(); 
  fill(0);
  ellipse(centerX-rollSide, centerY-rollUp,5,5);
  
  
 //Blink Section - not happy with this yet

  

  
  
  turn++;
}//End Draw


void mouseClicked() {
centerX = mouseX;
centerY = mouseY;
  
}
