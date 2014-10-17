/*
 *
 * by Evan Raskob
 * http://lowfrequency.org/interactivity/wiki/
 * evan@flkr.com
 *
 * A Monster made out of body segments that follow one another.
 *  - and googley eyes, of course.
- Hide quoted text -
 * 
 * Keys:
 *
 * Spacebar makes it "explode" outwards.
 * + or = makes it get crazier
 * - or _ makes it more sedate.
 *
 */


// these are objects that follow
// other Follower objects in interesting ways.
// see below for details.
Follower dude, eyeL, eyeR, eyeBallL, eyeBallR;

Follower[] followers;

float craziness = 10f;


void setup()
{
  size(512,512);
  ellipseMode(CENTER);
  colorMode(RGB, 1.0); 
  smooth();

  // the "dude" follows itself (the mouse, really)
  // this is the head
  dude = new Follower();

  // these will be googly eyes
  eyeL = new Follower(dude);
  eyeL.nearness = 20f;
  eyeL.farness = 50f;
  
  eyeR = new Follower(dude);
  eyeR.nearness = 20f;
  eyeR.farness = 50f;

  eyeBallL = new Follower(eyeL);
  eyeBallL.lag = 0.6;

  eyeBallR = new Follower(eyeR);
  eyeBallR.lag = 0.6;
  
  // body segments
  followers = new Follower[80];

  // first one follows the head
  followers[0] = new Follower(dude);

  for (int i=1; i<followers.length; i++)
  {
    followers[i] = new Follower(followers[i-1]);
    // start somewhere random for fun
    followers[i].xpos = random(0,width);
    followers[i].ypos = random(0, height);
  }
  // set the frame rate
  frameRate(30);

  noStroke(); 

}


void draw()
{
  //clear screen
  background(1f);

  //move the dude to the current mouse position
  dude.xpos = mouseX;
  dude.ypos = mouseY;

  // start shape
  beginShape(); 


  for (int i=0; i<followers.length; i++)
  {
    fill(0f, 0.8f-0.5f*(float)i/(float)followers.length); 

    // update body segment position 
    followers[i].update();

    // draw vertex at new position
    vertex(followers[i].xpos,followers[i].ypos);

    float r = 40f;

    // make width/height of segment equal to abs distance between segments
    // could be neat to do this indepenently for x,y
    if (i>0) r = sqrt( pow(followers[i-1].xpos-followers[i].xpos, 2) + pow(followers[i-1].ypos-followers[i].ypos, 2));

    // draw ellipse centered at current segment position
    ellipse(followers[i].xpos,followers[i].ypos,r,r);
  }


  endShape(CLOSE);

  // set color for first follower and update/draw it
  fill(0f,1f);  
  

  stroke(0f);
  //draw eyeballs
  fill (1f);
  eyeR.update();
  eyeR.xpos -= 6f;
  ellipse(eyeR.xpos,eyeR.ypos,40,40);
  eyeL.update();
  eyeL.xpos += 6f;
  ellipse(eyeL.xpos,eyeL.ypos,40,40);
  
  noStroke();
  // draw pupils
  fill (0.1f,0f, 0.1f);
  eyeBallR.update();
  ellipse(eyeBallR.xpos,eyeBallR.ypos,20,20);
  eyeBallL.update();
  ellipse(eyeBallL.xpos,eyeBallL.ypos,20,20);
}



void keyPressed()
{
  if (key == ' '){
    for (int i=1; i<followers.length; i++)
    {
      followers[i].xpos = random(0,width);
      followers[i].ypos = random(0, height);
      followers[i].update();
    }
  } 
  else if (key == '=' || key == '+')
  {
    craziness++;
    craziness = min(craziness, 50f);
    
    for (int i=1; i<followers.length; i++)
    {
      followers[i].nearness = craziness;
      followers[i].farness = 2.5f*craziness;
    }
  }
  else if (key == '-' || key == '_')
  {
    craziness--;
    craziness = max(craziness, 2f);
    
    for (int i=1; i<followers.length; i++)
    {
      followers[i].nearness = craziness;
      followers[i].farness = 2.5f*craziness;
    }
  }
    
}



// see if two followers are within a certain 
// pythagorean distance of one another

boolean near(Follower a, Follower b, float dist)
{
  boolean tooClose = false;

  if ( pow(a.xpos - b.xpos, 2) + pow(a.ypos - b.ypos, 2) < dist*dist) tooClose = true;

  return tooClose;
}



class Follower
{

  /* 
   * Follower objects follow other
   * Follower objects, with a slight lag.
   * At the very least, they follow themselves
   * (meaning you will need to manually move them.)
   * Their "update()" method both updates their 
   * positions and draws them to the screen.
   *
   */

  Follower leader;
  float xpos, ypos;
  // amound of lag between updating position
  float lag=0.2;
  
  // how close can this get to another before reversing?
  float nearness = 10f;
  
  // ah you'll figure it out.. see update()
  float farness = 25f;


  // Constructor makes it follow another
  // Follower, with a slight lag
  Follower(Follower f)
  {
    leader = f;
    xpos = leader.xpos;
    ypos = leader.ypos;
  }

  // basic constructor makes this follow itself
  // (it doesn't move)
  Follower()
  {
    leader = this;
    xpos = 0.0;
    ypos = 0.0;

  }


  // update position based on what this is following
  // and draw to the screen.
  void update()
  {
    // add some jitter if too near
    if (near(this, leader, nearness)) lag = -Math.abs(lag);
    else if (!near(this, leader, farness)) lag = Math.abs(lag);
     

    xpos += (leader.xpos-xpos)*lag-random(-nearness*0.1, nearness*0.1);
    ypos += (leader.ypos-ypos)*lag;   
  }
  // end clas Follower
}
