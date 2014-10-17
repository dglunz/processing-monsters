MorphBall mb, mb1, mb2, mb3;
void setup()
{
  smooth();
  size(300,300);
  mb = new MorphBall(width/2, height/2, 50, 270,0);
  mb1 = new MorphBall(mb.x1, mb.y1, 50, 90,0);
  mb2 = new MorphBall(mb.x1, mb.y1, 50, 0,0);
  mb3 = new MorphBall(mb.x1, mb.y1, 50, 180,0);
 
  background(255);
}

void draw()
{
  background(255);
  mb.displayAux();
  mb1.displayAux();
  mb2.displayAux();
  mb3.displayAux();  

  mb.display();
  mb1.display();
  mb2.display();
  mb3.display();
  
}
class MorphBall
{
  float x1,y1,x2,y2,x3,y3,x4,y4;
  float R, r1,r2,r3,r4;
  float ex1, ey1, ex2, ey2;
  float angle, targetAngle;
  float currentPos, xPos, yPos;
  float dir = 1;
  boolean changingDir = false;
  boolean showEyes = true;
  float angleInc = 90;
  float ea1, ea2;
  color col = color(0);

  MorphBall(float x, float y, float r, float angle, int inv)
  {
    this.R = r;
    if (inv==1)
    {
       dir = -1;
       this.x2 = x;
       this.y2 = y;
    }
    else
    {
      this.x1 = x;
      this.y1 = y;
    }
    this.angle = this.targetAngle = angle;
    this.currentPos = R/2;
  } 

  void render()
  {
    if (dir > 0)
    {
      x2=x1+(cos(radians(angle))*R);
      y2=y1+(sin(radians(angle))*R);
    }
    else
    {
      x1=x2+(cos(radians(angle+180))*R);
      y1=y2+(sin(radians(angle+180))*R);
    }
    xPos = x1+(cos(radians(angle))*currentPos);
    yPos = y1+(sin(radians(angle))*currentPos);
    x3 = xPos+cos(radians(angle+90))*(R/2);
    y3 = yPos+sin(radians(angle+90))*(R/2);
    x4 = xPos+cos(radians(angle-90))*(R/2);
    y4 = yPos+sin(radians(angle-90))*(R/2);

    if (showEyes)
    {
      float dx1 = x1-mouseX;
      float dy1 = y1-mouseY;
      float dx2 = x2-mouseX;
      float dy2 = y2-mouseY;
      ea1 = atan2(dy1,dx1);
      ea2 = atan2(dy2,dx2);
      ex1 = x1-cos(ea1)*r1/4;
      ey1 = y1-sin(ea1)*r1/4;
      ex2 = x2-cos(ea2)*r2/4;
      ey2 = y2-sin(ea2)*r2/4;
    }
    float d1 = dist(x1,y1,x3,y3);
    float d2 = dist(x2,y2,x3,y3);
    r3 = r4 = R/2;
    r1=d1-r3/2;
    r2=d2-r3/2;
    if (!changingDir)
    {
      currentPos += 1*dir;
      if (currentPos >= R || currentPos <= 0)
      {
        dir = dir*-1;
        changeDir();
      }
    }
    else  
      if ((int)angle != (int)targetAngle)
      angle = (angle+1)%360; 
    else
      changingDir=false;

  }

  void changeDir()
  {
    changingDir = true;
    targetAngle = (targetAngle+angleInc)%360;

  }

  void displayAux()
  {
    fill(col);
    triangle(x1,y1,x2,y2,x3,y3);
    triangle(x1,y1,x2,y2,x4,y4);

    fill(255);
    ellipse(x3,y3,r3,r3);
    ellipse(x4,y4,r4,r4);
    
  }

  void display()
  {
    render();
    noStroke();
    fill(col);
    ellipse(x1,y1,r1*2,r1*2);
    ellipse(x2,y2,r2*2,r2*2);

    fill(255);
    ellipse(x1,y1,r1,r1);
    ellipse(x2,y2,r2,r2);    
    if (showEyes)
    {
      fill(0);
      ellipse(ex1,ey1,r1/2,r1/2);
      ellipse(ex2,ey2,r2/2,r2/2);
      fill(255);
      ellipse(ex1-r1/10,ey1-r1/10,r1/5,r1/5);
      ellipse(ex2-r2/10,ey2-r2/10,r2/5,r2/5);
    }
  }
}
