  float OTTO_X = 200;
  float OTTO_Y = 200; 
  int BLINK_COUNTER = 0;
  float GNASH_COUNTER = 0;
  int COUNTER = 0;
  /* Otto's state of mind 0 = happy, 1 = angry, 2 = bitey */
  int OTTO_MENTAL_STATE = 0;


void setup()
{
  size(400,400);
  smooth();
  strokeWeight(2);
}

void draw()
{
 background(255);
 drawBorder();
 
 float[] ottoMove = computeOttoPos(OTTO_X,OTTO_Y,mouseX,mouseY,OTTO_MENTAL_STATE);
 
 OTTO_X = ottoMove[0] + (1-(2*noise(COUNTER*0.1)))*(0.5*OTTO_MENTAL_STATE);
 OTTO_Y = ottoMove[1] + (1-(2*noise(COUNTER)))*(5*OTTO_MENTAL_STATE);
 OTTO_MENTAL_STATE = computeMentalState(OTTO_X,OTTO_Y);
 drawOttoBody(OTTO_X,OTTO_Y);
 drawOttoEyes(OTTO_X,OTTO_Y,OTTO_MENTAL_STATE,BLINK_COUNTER);
 if (OTTO_MENTAL_STATE == 2){
   drawOttoMouth(OTTO_X,OTTO_Y,GNASH_COUNTER);
 }

  if (BLINK_COUNTER < 0)
  {
    BLINK_COUNTER = int(random(50))+100; 
  }
  if(GNASH_COUNTER > 90){
    GNASH_COUNTER = 0;
  }
  BLINK_COUNTER -= 1;
  GNASH_COUNTER += 20;
  COUNTER += 1;
  
}

float[] computeOttoPos(float inXVal, float inYVal, float inMouseX, float inMouseY, int mentalState)
{
  float moveOTTO[] = {inXVal, inYVal};
  
  float diffX = inMouseX - inXVal;
  float diffY = inMouseY - inYVal;
 
  float mag = sqrt((diffX*diffX)+(diffY*diffY));
  if(mag != 0)
  {
    diffX = diffX/mag;
    diffY = diffY/mag;
    if(mentalState >= 1)
    {
      diffX *= (mentalState+1);
      diffY *= (mentalState+1);
    }
    moveOTTO[0] = diffX + inXVal;
    moveOTTO[1] = diffY + inYVal;
  }
  
  
  return moveOTTO;
  
}

void drawOttoBody (float OTTO_X, float OTTO_Y)
{
 /* Draw Otto's angry little body */
 fill(0);

 ellipse(OTTO_X,(OTTO_Y-20),80,80);
 ellipse(OTTO_X,(OTTO_Y-60),50,30);
 triangle((OTTO_X-38.5),(OTTO_Y-30),(OTTO_X-15),(OTTO_Y-95),(OTTO_X+15),(OTTO_Y-20));
 triangle((OTTO_X+38.5),(OTTO_Y-30),(OTTO_X+15),(OTTO_Y-95),(OTTO_X-15),(OTTO_Y-20)); 
 
}

void drawOttoEyes (float OTTO_X, float OTTO_Y, int OTTO_MENTAL_STATE, int BLINK_COUNTER)
{
  /* Draw Otto's eyes, frowning if neccessary, with timed blinks */
  if(BLINK_COUNTER > 10){
    fill(255);
    
    float LeyeX = OTTO_X-10;
    float eyeY = OTTO_Y-50;
    float ReyeX = OTTO_X+10;

    ellipse(LeyeX,eyeY,15,15);
    ellipse(ReyeX,eyeY,15,15);
    
    float LPupilOffsetX = mouseX - LeyeX;
    float RPupilOffsetX = mouseX - ReyeX;
    float RPupilOffsetY = mouseY - eyeY;
    float LPupilOffsetY = mouseY - eyeY;
    
    float magLeft = sqrt((LPupilOffsetX*LPupilOffsetX)+(LPupilOffsetY*LPupilOffsetY));
    float magRight = sqrt((RPupilOffsetX*RPupilOffsetX)+(RPupilOffsetY*RPupilOffsetY));
    
    LPupilOffsetX /= magLeft;
    LPupilOffsetY /= magLeft;
    RPupilOffsetX /= magRight;
    RPupilOffsetY /= magRight;
    
    LPupilOffsetX *= 5;
    LPupilOffsetY *= 5;
    RPupilOffsetX *= 5;
    RPupilOffsetY *= 5;
    
    if(OTTO_MENTAL_STATE > 0){
      if(LPupilOffsetY < -1){
        LPupilOffsetY = -1;
      }
      if(RPupilOffsetY < -1){
        RPupilOffsetY = -1;
      }
    }
    
    fill(0);
    
    ellipse((LeyeX+LPupilOffsetX),(eyeY+LPupilOffsetY),4,4);
    ellipse((ReyeX+RPupilOffsetX),(eyeY+RPupilOffsetY),4,4);
    
    if(OTTO_MENTAL_STATE > 0){
      fill(0);
      quad((LeyeX-12),(eyeY-5),(LeyeX+12),(eyeY-0),(LeyeX+12),(eyeY-10),(LeyeX-12),(eyeY-15));
      quad((ReyeX+12),(eyeY-5),(ReyeX-12),(eyeY-0),(ReyeX-12),(eyeY-10),(ReyeX+12),(eyeY-15));
    }
    
    
    
    
    
  }
}

void drawOttoMouth (float OTTO_X, float OTTO_Y, float GNASH_COUNTER)
{
 /* Draw Otto's bitey cake-hole */
 
 float gnashAmount = radians(GNASH_COUNTER);
 
 float topRowY = (OTTO_Y-20) + cos(gnashAmount)*15 + 5;
 float bottomRowY = (OTTO_Y-20) - cos(gnashAmount)*15 - 5;
 fill(255);
 //rect((OTTO_X-30),topRowY,60,(bottomRowY-topRowY));
 
 quad((OTTO_X-30),bottomRowY,(OTTO_X+30),bottomRowY,(OTTO_X+25),topRowY,(OTTO_X-25),topRowY);
 
 triangle((OTTO_X-30),bottomRowY,(OTTO_X-25),(bottomRowY+10),(OTTO_X-20),bottomRowY);
 triangle((OTTO_X-20),bottomRowY,(OTTO_X-15),(bottomRowY+10),(OTTO_X-10),bottomRowY);
 triangle((OTTO_X-10),bottomRowY,(OTTO_X-5),(bottomRowY+10),(OTTO_X),bottomRowY);
 triangle((OTTO_X+30),bottomRowY,(OTTO_X+25),(bottomRowY+10),(OTTO_X+20),bottomRowY);
 triangle((OTTO_X+20),bottomRowY,(OTTO_X+15),(bottomRowY+10),(OTTO_X+10),bottomRowY);
 triangle((OTTO_X+10),bottomRowY,(OTTO_X+5),(bottomRowY+10),(OTTO_X),bottomRowY); 
 
 triangle((OTTO_X-25),topRowY,(OTTO_X-20),(topRowY-10),(OTTO_X-15),topRowY);
 triangle((OTTO_X-15),topRowY,(OTTO_X-10),(topRowY-10),(OTTO_X-5),topRowY);
 triangle((OTTO_X-5),topRowY,(OTTO_X),(topRowY-10),(OTTO_X+5),topRowY);
 triangle((OTTO_X+25),topRowY,(OTTO_X+20),(topRowY-10),(OTTO_X+15),topRowY);
 triangle((OTTO_X+15),topRowY,(OTTO_X+10),(topRowY-10),(OTTO_X+5),topRowY); 
 
}

void drawBorder()
{
 /* Draw black border around screen */ 
}

int computeMentalState(float OTTO_X, float OTTO_Y)
{
  
  int mentalStateOut = 0;
  
 float diffX = mouseX - OTTO_X;
 float diffY = mouseY - OTTO_Y;

 float magnitude = sqrt((diffX*diffX)+(diffY*diffY));
 if(magnitude < 150 ){
   mentalStateOut = 1;
 }
 if(magnitude < 50){
   mentalStateOut = 2;
 }
 
 
 return mentalStateOut;
}
