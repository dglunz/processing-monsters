import processing.opengl.*;

/*

Urchin Pile Monster
January, 2009
blprnt@blprnt.com

This sketch was made as a contribution to Lukas Vojir's Processing Monsters collection: http://rmx.cz/monsters/ 

*/
//### 1. First, import the necessary classes. In this case, a whole pile of Toxi's excellent utilities (http://code.google.com/p/toxiclibs/)
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.geom.util.*;
import toxi.physics2d.constraints.*;
import toxi.physics.*;
import toxi.physics.constraints.*;
import toxi.physics2d.*;
//Plus the ever-handy ArrayList
import java.util.ArrayList;

//### 2. Declare global properties. These are available from anywhere in the sketch.

//Urchins
ArrayList urchins;                          //This ArrayList will store a list of all of the urchins.
ArrayList stuckUrchins; 
int urchinNum = 90;                          //Number of total urchins
Urchin lastStick;
int stickCount = 0;

//Images
PImage mote;
PImage mote2;
PImage mote3;
PImage eye;

//Physics
Vec2D gravity = new Vec2D(0,0.7);
Vec2D egravity = new Vec2D(0,0.7);
Vec2D wallFriction = new Vec2D(0.65,0.65);

VerletPhysics2D engine;
VerletParticle2D mouse;

//### 3. Standard Processing methods
void setup() {
  //Configure the sketch
  size(500,500, OPENGL);
  hint(ENABLE_OPENGL_4X_SMOOTH); 
  background(255);
  fill(0);
  noStroke();
  //smooth();
  frameRate(50);
  
  mote = loadImage("mote.png");
  mote2 = loadImage("mote2.png");
  mote3 = loadImage("mote3.png");
  eye = loadImage("eye.png");
  
  //Create the particle engine
  initEngine();
  
  mouse = new VerletParticle2D(mouseX, mouseY);
  
  //Make the ArrayList
  urchins = new ArrayList();
  stuckUrchins = new ArrayList();
  //Create a whole bunch of Urchins and put them into the ArrayList
  for (int i = 0; i < urchinNum; i++) {
    Urchin t = new Urchin();
    t.pos.y = 60;
    t.pos.x = random(500);
    t.pos.y = random(570,590);
    t.vel.x = random(-15,15);
    t.vel.y = random(-5);
    t.rad = random(4,15);
    t.id = i;
    t.init();
    
    urchins.add(i,t);
  };
};


//Initialize the Verlet physics engine, which controls the urchins while they are stuck to the mouse
void initEngine() {
  engine = new VerletPhysics2D();
  engine.gravity = egravity;
  engine.friction = 0.5;
  engine.worldBounds = new Rectangle(0,0,500,500);
};

//Function to unstick all of the urchins from the mouse.
void unStickAll() {
  for (int i = 0; i < stuckUrchins.size(); i++) {
    Urchin u = (Urchin) stuckUrchins.get(i);
    u.stuck = false;   
  };
  
  initEngine();
  stuckUrchins.clear();
};

//Function to stick an urchin to the mouse;
void stickIt(Urchin u) {
  if (stickCount > 50) {
    //Only stick if it's been 1 second since the last clear
    u.stuck = true;
    u.vel.clear();
    engine.addParticle(u.pos);
    VerletParticle2D target;
    //Choose to stick either to the mouse or to one of the other stuck urchins
    if (stuckUrchins.size() > 0 && random(100) > 10) {
      Urchin urch = (Urchin) stuckUrchins.get( floor(random(stuckUrchins.size())));
      target = urch.pos; 
    }
    else {
      target = mouse;
    };
    //Set the stick target for drawing web lines
    u.stickTarget = target;
    //Add the urchin to the Verlet engine and build the spring
    engine.addSpring( new VerletConstrainedSpring2D( target, u.pos, random(10,30), 1, 100) );
    stuckUrchins.add(stuckUrchins.size(), u);
  };
  
};

void draw() {
  stickCount ++;
  background(255);
  engine.update();
  
  //Create the mouse Vec2D for mouse interaction
  mouse.x = mouseX;
  mouse.y = mouseY;
  
  for (int i = 0; i < urchinNum; i++) {
    Urchin t = (Urchin) urchins.get(i);
    t.update();
  };
  
  for (int i = 0; i < urchinNum; i++) {
    Urchin t = (Urchin) urchins.get(i);
    t.draw();
  };
  
};

void mousePressed() {
  unStickAll();
  stickCount = 0;
};
