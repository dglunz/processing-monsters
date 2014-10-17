                                                                     
                                                                     
                                                                     
                                             
//monster

import traer.physics.*;

Particle a, b, c;
Particle[] body;
Particle eyeL;
Particle eyeR;
ParticleSystem physics;

float x;
float y;



void setup() {
size(500, 500);
smooth();
ellipseMode(CENTER);
cursor(CROSS);


physics = new ParticleSystem( 0.0, 0.1);
a = physics.makeParticle();
a.makeFixed();
b = physics.makeParticle();
b.makeFixed();
c = physics.makeParticle();
c.makeFixed();

body = new Particle[20];
for ( int i = 0; i < 20; i ++){
  body[i] = physics.makeParticle(1.0, random(0, width), random(0, height), 0);
  
  physics.makeAttraction(a, body[i], 5550, 30);
}


eyeL = physics.makeParticle(1.0, random(0, width), random(0, height), 0);
eyeR = physics.makeParticle(1.0, random(0, width), random(0, height), 0);  
physics.makeAttraction(b, eyeL, 5550, 90);
physics.makeAttraction(c, eyeR, 5550, 50);
x = width/2;
y = width/2;
}


void draw() {
  if (mouseX > x-10 && mouseX < x+10)
  {
    x = random(50,width-50);
  }
  if (mouseY > y-10 && mouseY < y+10)
  {
    y = random(50,height-50);
  }
  a.moveTo (x, y, 0);
  b.moveTo (x+13, y, 0);
  c.moveTo (x-13, y, 0);
  handleCollisions( a );
  physics.tick(1.0);
  background(255);
  
  for (int i = 0; i < 20; i++)
  {
    Particle p = body[i];
    fill(0);
    noStroke();
    
    ellipse(p.position().x(), p.position().y(), 70, 70);
    handleCollisions( body[i] );
  }
 
    fill(255);
    noStroke();
    
    ellipse(eyeL.position().x(), eyeL.position().y(), 10, 10);
     ellipse(eyeR.position().x(), eyeR.position().y(), 10, 10);
     fill(0);
     ellipse(eyeL.position().x(), eyeL.position().y(), 3, 3);
    handleCollisions( eyeL );
 
    
    fill(0);
     ellipse(eyeR.position().x(), eyeR.position().y(), 3, 3);
     handleCollisions( eyeR );
    

}
  
  void handleCollisions( Particle p )
{
  if ( p.position().x() < 0 || p.position().x() > width )
    p.setVelocity( -0.8*p.velocity().x(), p.velocity().y(), 0 );
  if ( p.position().y() < 0 || p.position().y() > height )
    p.setVelocity( p.velocity().x(), -0.8*p.velocity().y(), 0 );
  p.moveTo( constrain( p.position().x(), 0, width ), constrain( p.position().y(), 0, height ), 0 ); 
}
