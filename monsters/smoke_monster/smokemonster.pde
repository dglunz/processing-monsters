//black monster on white background
//Cory Barton

import traer.physics.*;

ParticleSystem physics;
Particle last;

void setup()
{
  size( 300, 300 );	
  fill( 255, 64 );
  frameRate( 24 );
  physics = new ParticleSystem( 0.09, 0.01 );
  ellipseMode( CENTER );
  smooth();
  noCursor();
  //cursor( CROSS );
}

void draw()
{
  for ( int i = 0; i < 5; i++ )
  {
    //body particles
    Particle p = physics.makeParticle( 1.0f, mouseX, mouseY, 0 );
    p.setVelocity( random( -5, 5 ), random( -5, 5 ), 0 );
    
    //right eye
    Particle q = physics.makeParticle( -0.9f, mouseX, mouseY, 0 );
    q.setVelocity( random( -1, 1 ), random( -2, -5 ), 0 );
    
    //left eye
    Particle r = physics.makeParticle( -1.0f, mouseX, mouseY, 0 );
    r.setVelocity( random( -1, 1 ), random( -2, -5 ), 0 );
    
    //mouth
    Particle s = physics.makeParticle( 0.9f, mouseX, mouseY, 0 );
    s.setVelocity( random( -1, 1 ), random( -2, -5 ), 0 );
    
    if ( last != null )
      physics.makeSpring( p, last, 0.1f, 0.1f, 10 );
      //physics.makeSpring( r, last, 0.1f, 0.1f, 10 );
    last = p;
  }
  physics.tick();
  background( 255 );

  noStroke();
  for ( int i = 0; i < physics.numberOfParticles(); ++i )
  {
    Particle p = physics.getParticle( i );
    if (p.mass() == -1.0f) //left eye
    {
      fill( 255, 255/(p.age()+1) );
      ellipse( p.position().x()-15, p.position().y()-10, 10, 10 );  
    
    }
    else if (p.mass() == -0.9f) //right eye
    {
      fill( 255, 255/(p.age()+1) );
      ellipse( p.position().x()+15, p.position().y()-10, 10, 10 );
    
    }
    else if (p.mass() == 0.9f) //mouth
    { 
      fill( 255, 255/(p.age()+1) );
      ellipse( p.position().x(), p.position().y()+5, 20, 2 );      
    
    }
    else //body
    { 
      fill( 0, 255/(p.age()+1) );
      ellipse( p.position().x(), p.position().y(), 50, 30 );
    }
    
    if ( p.age() > 96 )
      p.kill();
  }
}

