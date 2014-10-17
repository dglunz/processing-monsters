//Worms monster sketch
//Gabe Graham 4/1/09

//Worms move toward mouse unless a button is pressed, then they move away

//Array of worms
Worm[] worm;
int nWorms = 200; //number of worms

void setup() {
  size(800,600,P2D);
  noSmooth();
  frameRate(30);
  //initialize monters with random parameters
  worm = new Worm[nWorms];
  for(int i=0; i<nWorms; i++){
    worm[i] = new Worm(random(0.5,2),random(0.5,2),random(50,200),random(-.1,.1));
  }
}

void draw() {
  background(255);
  for(int i=0; i<nWorms; i++){
    worm[i].update();
    worm[i].draw();
  }
} 

class Worm {
  float xtarget; //x position of target
  float ytarget;
  float dtarget; //randomness for target
  float dmove; //randomness for movement
  float speed; //pixels per second 
  int diam=4; //diameter of head
  int nlinks=15; //number of links
  float[] x= new float[nlinks]; //x coordinates of worm
  float[] y= new float[nlinks];
  float dsteer; //steering offset in radians
  float angle;  //angle that worm is moving
  
  Worm(float _speed, float _dmove, float _dtarget, float _dsteer) {
    //randomize initial location 
    x[0]=random(0,width);
    y[0]=random(0,height); 
    for(int i=0; i<nlinks; i++){
      x[i]=x[0];
      y[i]=y[0];
     }
    speed=_speed;
    dmove=_dmove;
    dtarget=_dtarget;
    dsteer=_dsteer;
  }
  
  void update() {
    //find target, add some randomness
    xtarget=mouseX+random(-dtarget,dtarget);
    ytarget=mouseY+random(-dtarget,dtarget);   
    //move each body position up one
    for(int i=nlinks-1; i>0; i--){
      x[i]=x[i-1];
      y[i]=y[i-1];
    }
    
    //get angle to target
    angle=atan2((ytarget-y[0]),(xtarget-x[0]))+dsteer;
    if (mousePressed==true) angle=PI+angle; //reverse direction if mouse pressed
    
    //update position of head
    x[0]+=speed*cos(angle);
    y[0]+=speed*sin(angle);
      
    //keep within bounds
    if (x[0]>width) x[0]=width;
    if (x[0]<0) x[0]=0;
    if (y[0]>height) y[0]=height;
    if (y[0]<0) y[0]=0;     
  }
  
  //draw worm  
  void draw() { 
    fill(0);
    for(int i=0; i<nlinks; i++){
      ellipse(x[i],y[i],diam,diam);
    }
    
  }
}
