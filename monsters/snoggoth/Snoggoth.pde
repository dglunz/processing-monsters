/**
 * Snoggoth: a cuter version of a Lovecraft classic. Try clicking and dragging the eyes.
 *<p/>
 * Contains ideas and bits of code from http://www.cricketschirping.com/processing/CirclePacking1/CirclePacking1.pde
 *<p/>
 * <a href="http://projects.logicalzero.com/">David Stokes</a>, 2008. 
 * 
 */
 
// Vector3D library, found here -- http://www.shiffman.net/teaching/nature/library/
import noc.*;

///////////////////////////////////////////////////////////////////////////
// WARNING!
// The folowing code is very, very ugly. It was cobbled together in a couple
// of hours and incorporates a lot of bits and pieces of my other sketches,
// hence the occasional non-apropos comment and/or variable name.
///////////////////////////////////////////////////////////////////////////

final static int NUM_BUBBLES = 8;        // Number of body bubbles (no parent)
final static int NUM_EYES = 11;          // Number of bubbles with eyes
final static int NUM_EYE_BUBBLES = 3;    // Number of little child bubbles attached to eye bubbles
final static int MIN_RADIUS = 10;        // Min. radius of the bubbles
final static int MAX_RADIUS = 30;
final static int EYE_MIN_RADIUS = 12;    // Min radius of eyeball (not its bubble)
final static int EYE_MAX_RADIUS = 28;
final static float MAX_SPEED = 5.0;       // The maximum speed in pixels-per-frame.
final static int OVERLAP = 60;            // Pixels by which the bubbles overlap
final static float LAG = 10.0;            // Ease-out factor for movement.
final static float GROW_MIN = .75;        // Normalized percentage.
final static float GROW_MAX = 1.25;       // "" 
final static float BLINK_TIMING = 120.0;  // Time between blinks. No real units, just guestimate.
final static float BLINK_SPEED = 40.0;    // Time it takes to blink. Also arbitrary units, but higher is faster.

final static int packingIterations = 10;  // Iterations between frames that bubbles are adjusted to reduce coarse jitter

///////////////////////////////////////////////////////////////////////////

ArrayList bubbles;              // The list of all displayed bubbles
Bubble dragBubble;              // The bubble currently being dragged (or null)

////////////////////////////////////////////////////////////////////////////////
//
// Bubble class: One unit of monster.
//
public class Bubble 
{
  Bubble parent;
  float x, y;
  float drawX, drawY;
  float baseRadius = 100;
  float radius = 100;
  float diameter = 200;            // 2x radius, cached for faster computation. 
  float eyeRadius, eyeDiameter;
  float pupilDistance;
  float pupilDiameter; 
  boolean isEye;
  float growOffset;
  float growSpeed;
  float drawdiameter;
  
  //
  //
  public Bubble(int radius, Bubble parent, boolean isEye)
  {
    this.baseRadius = radius;
    this.radius = radius;
    this.diameter = radius * 2;
    this.parent = parent;
    this.isEye = isEye;
    
    this.x = (width/2) + random(-10,10); //random(width);
    this.y = (height/2) + random(-10,10); //random(height);
    this.drawX = this.x;
    this.drawY = this.y;
    this.growOffset = random(-2.0,2.0);
    this.growSpeed = random(200.0, 800.0);
    this.drawdiameter = this.diameter;
    
    if (isEye)
    {
      this.eyeRadius = this.radius / 1.5; //random(EYE_MIN_RADIUS, EYE_MAX_RADIUS);
      this.eyeDiameter = this.eyeRadius * 2; //this.eyeRadius * 2;
      this.pupilDiameter = this.eyeRadius;
      this.pupilDistance = this.pupilDiameter * 0.9;
    }
  }
  
  //
  // Update the bubble's drawn position and size.
  //
  void update()
  {
    // Dragged bubbles move at mouse speed
    if (dragBubble != null && (dragBubble == this || dragBubble == this.parent))
    {
      drawX = x;
      drawY = y;
    }
    else
    {
      float d = dist(x, y, drawX, drawY) / LAG;
      if (isEye) d /= 2;
      if (d > MAX_SPEED)
        d = MAX_SPEED;
    
      float a = atan2(y - drawY, x - drawX);
      drawX += cos(a) * d;
      drawY += sin(a) * d;
    }
    
    // throb
    radius = baseRadius * map(sin((millis()/growSpeed) + growOffset), -1, 1, GROW_MIN, GROW_MAX);
    diameter = radius * 2;
  }
  
  //
  // Display the bubble background.
  //
  public void draw()
  {
    noStroke();
    fill(0);
    ellipse(drawX, drawY, diameter + OVERLAP, diameter + OVERLAP);
  }
  
  //
  // Display the little specular highlight.
  // This is a different method so backgrounds won't overlap highlights.
  //
  public void drawHighlight()
  {
    noStroke();
    fill(16);
    ellipse(drawX + radius/HALF_PI, drawY - radius/HALF_PI, radius, radius);
  }
 

  // 
  // Draw the eyeball.
  //
  public void drawEye()
  {
    float eyeV = map(sin((frameCount+drawX)/BLINK_SPEED), -1.0, 1.0, 0.0, BLINK_TIMING);
    if (eyeV > 1.0) eyeV = 1.0;
    
    // eyeball body
    fill(255);
    stroke(0,64);
    strokeWeight(2);
    ellipse(drawX, drawY, eyeDiameter, eyeDiameter * eyeV);
    
    // Eyeball shadow
    strokeWeight(4);
    noFill();
    ellipse(drawX + eyeDiameter/20, drawY - eyeDiameter / 20, eyeDiameter, eyeDiameter);
    fill(0);
    noStroke();
    
    // pupil, following mouse
    float eDist = map(dist(drawX, drawY, mouseX, mouseY), 0, height, 0, pupilDistance);
    float a = atan2(mouseY - y, mouseX - drawX);
    float ex = cos(a) * eDist + drawX;
    float ey = sin(a) * eDist + drawY;
    ellipse(ex,ey,pupilDiameter,pupilDiameter);
    
    // Specular highlight
    if (eyeV > 0.5)
    {
      fill(255,64);
      ellipse(drawX+pupilDistance/2.5, drawY-pupilDistance/2.5, pupilDiameter /2, pupilDiameter /2);
    }
  }    
 
  //
  // Retrive the parent's X position
  // (or the center of the screen)
  //
  float getParentX()
  {
    if (parent == null)
      return width * .5;
    else
      return parent.x;
  }
  
  //
  // Retrive the parent's Y position
  // (or the center of the screen)
  //
  float getParentY()
  {
    if (parent == null)
      return height * .5;
    else
      return parent.y;
  }
  
  // The next three methods were taken almost verbatim from CirclePacking1  
  public boolean contains(float x, float y) 
  {
    float dx = this.x - x;
    float dy = this.y - y;
    return sqrt(sq(dx) + sq(dy)) <= radius;
  }
  
  public float distanceToCenter() 
  {
    float dx = x - getParentX();
    float dy = y - getParentY();
    return sqrt(sq(dx) + sq(dy));
  } 
  
  public boolean intersects(Bubble c) 
  {
    float dx = c.x - x;
    float dy = c.y - y;
    float d = sqrt(sq(dx) + sq(dy));
    return d < radius || d < c.radius;
  }
}

///////////////////////////////////////////////////////////////////////////
// Circle packing methods.
///////////////////////////////////////////////////////////////////////////

Comparator comp = new Comparator() 
{
    public int compare(Object p1, Object p2) {
      Bubble a = (Bubble)p1;
      Bubble b = (Bubble)p2;
      if (a.distanceToCenter() < b.distanceToCenter()) 
        return 1;
      else if (a.distanceToCenter() > b.distanceToCenter())
        return -1;
      else
        return 0;
    }
};


void iterateLayout(int iterationCounter)
{
  Object bubs[] = bubbles.toArray();
  Arrays.sort(bubs, comp);

  //fix overlaps
  Bubble ci, cj;
  Vector3D v = new Vector3D();

  for (int i=0; i<bubs.length; i++) 
  {
    ci = (Bubble)bubs[i];
    for (int j=i+1; j<bubs.length; j++) 
    {
      if (i != j) 
      {
        cj = (Bubble)bubs[j];
        float dx = cj.x - ci.x;
        float dy = cj.y - ci.y;
        float r = ci.radius + cj.radius;
        float d = (dx*dx) + (dy*dy);
        if (d < (r * r) - 0.01 )
        {
          v.x = dx;
          v.y = dy;

          v.normalize();
          v.mult((r-sqrt(d))*0.5);

          if (cj != dragBubble) 
          {
            cj.x += v.x;
            cj.y += v.y;
          }

          if (ci != dragBubble) 
          {     
            ci.x -= v.x;
            ci.y -= v.y;       
          }
        }
      }
    }
  }

  // Contract: draw in towards parent (or center of screen)
  float damping = 0.1/(float)(iterationCounter);
  for (int i=0; i<bubs.length; i++) 
  {
    Bubble c = (Bubble)bubs[i];
    if (c != dragBubble) 
    {
      v.x = c.x - c.getParentX();
      v.y = c.y - c.getParentY();
      v.mult(damping);
      c.x -= v.x;
      c.y -= v.y;
    }
  }
}


Bubble getBubble(int i) 
{
  return (Bubble)bubbles.get(i);
}


///////////////////////////////////////////////////////////////////////////
// Main Processing methods.
///////////////////////////////////////////////////////////////////////////

//
// setup(): Standard Processing method.
//
void setup()
{
  smooth();
  
  size(800, 600);
  rectMode(CENTER);

  // The big bubble list.
  bubbles = new ArrayList();
  
  // Add body bubbles.
  for (int i = 0; i < NUM_BUBBLES; i++)
  {
    bubbles.add(new Bubble(int(random(MIN_RADIUS, MAX_RADIUS)), null, false));
  }
  
  // Add eyeball bubbles
  for (int i = 0; i < NUM_EYES; i++)
  {
    Bubble thisEye = new Bubble(int(random(EYE_MIN_RADIUS, EYE_MAX_RADIUS)), null, true);
    bubbles.add(thisEye);
    // Add the children of the eyeball bubbles
    for (int j = 0; j < NUM_EYE_BUBBLES; j++)
    {
      bubbles.add(new Bubble(int(random(MIN_RADIUS/2, thisEye.radius/2)), thisEye, false));
    }
  }
  
}


//
// draw(): Standard Processing method.
//
void draw() 
{
  Bubble b;
  
  background(255);
  
    // From CirclePacking1; iterate the packing before drawing to get it more settled.
    for (int i=1; i < packingIterations; i++) 
    {
      iterateLayout(i);
    }
   
    // Background drawing pass
    for (int i=0; i < bubbles.size(); i++) 
    {
      b = getBubble(i);
      b.update();
      b.draw();
    } 
   
    // Highlight drawing pass
    for (int i=0; i < bubbles.size(); i++) 
    {
      b = getBubble(i);
      b.drawHighlight();
    } 
    
    // Eyeball drawing pass
    for (int i=0; i < bubbles.size(); i++) 
    {
      b = getBubble(i);
      if (b.isEye) b.drawEye();
    } 
  

}

///////////////////////////////////////////////////////////////////////////
// Event-handling methods
///////////////////////////////////////////////////////////////////////////

// Example interaction code taken largely from CirclePacking1
void mousePressed() 
{
  dragBubble = null;
    for(int i=0; i<bubbles.size(); i++) 
    {
      Bubble c = getBubble(i);
      // Only eye bubbles can be dragged.
      if (c.contains(mouseX, mouseY) && c.isEye) 
      {
        dragBubble = c;
      }  
    }
}

void mouseDragged() 
{
  if (dragBubble != null) 
  {
    dragBubble.x = mouseX;
    dragBubble.y = mouseY;
  }
}

void mouseReleased() 
{
  dragBubble = null;
}

