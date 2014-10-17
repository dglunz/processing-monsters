// waveyslimes for the Processing monsters project
// written by dan lipert @ danlipert@gmail.com
// oh god please don't look at my source...
// i am not good with computers


int mySize = 500;
int tableSize = mySize;
float[] sinTable = new float[tableSize];
float[] mappedTable = new float[mySize];
int tableCounter = 0;  
slime[] slimes = new slime[0];
int phase = 0;
//slime drawing info
  int cx1 = 0;
  float cy1 = 20;
  int cx2 = 100;
  float cy2 = -50;
    //c__ points are derivations from center of slime (i.e. xPos, yPos)

void setup()
{
  ellipseMode(RADIUS);
  size (500,500);
   
  //setting up table of sin values 
  for(int i = 0; i < tableSize; i++)
  {
    sinTable[i] = sin(1.5*TWO_PI * i/tableSize);
  }
  
  
  //create a mapped version for our resolution
  for(int i = 0; i < width; i++)
  {
    mappedTable[i] = map(sinTable[i], -1, 1, -3*height/10, 3*height/10);
  }
}

void draw()
{
  background(255);
  for(int i = 0; i < slimes.length; i++)
  {
    slimes[i].update();
  }
  phase += 5;
}

void mousePressed()
{
  slime newSlime = new slime(10, mouseX);
  //this next line is confusing, need to cast when appending an
  //array of objects for some reason
  slimes = (slime[]) append(slimes, newSlime);
}

class slime 
{
  int slimeRadius;
  float yPos;
  int xPos;
  float blinkY;

  
  slime (int r, int x)
  {
    slimeRadius = r;
    xPos = x;
  }
  
  
  //draw the slime and update its yPos
  void update()
  {
    //dont go past the end of the array!!! %!
    yPos = mappedTable[(xPos + phase)%mySize];
    if(yPos < 0)
    {
      yPos = yPos * -1;
    }
    //blink the eyes!
    blinkY = map(yPos, 0, 3*height/10, 0, 10);
    //c__ points are derivations from center (i.e. xPos, yPos)
    //drawing slime!
    fill(0); 
    bezier(xPos, height-(yPos+50)-50, xPos+cx1, height-(yPos+cy1)-50, xPos+cx2, height-(yPos+cy2)-50, xPos, height-(yPos-50)-50);
    bezier(xPos, height-(yPos+50)-50, xPos-cx1, height-(yPos+cy1)-50, xPos-cx2, height-(yPos+cy2)-50, xPos, height-(yPos-50)-50);
    fill(255);
    ellipse(xPos+13, height-(yPos+37), 10, blinkY);
    ellipse(xPos-13, height-(yPos+37), 10, blinkY);
    fill(0);
    ellipse(xPos+13, height-(yPos+37), 6, 6);
    ellipse(xPos-13, height-(yPos+37), 6, 6);
    
    //flip upside down so bouncing ont he bottom of the screen
    //ellipse(xPos, height - yPos, slimeRadius, slimeRadius);
    
  }
}
