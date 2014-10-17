import traer.physics.*;

ParticleSystem physics;

Particle left_eye;
Particle left_eye_anchor;
Spring left_eye_dangle;

Particle right_eye;
Particle right_eye_anchor;
Spring right_eye_dangle;

Particle mouth;
Particle mouth_anchor;
Spring mouth_dangle;

void setup()
{
  size( 400, 400 );
  smooth();
  fill( 0 );
  frameRate( 24 );
  ellipseMode( CENTER );
        
  physics = new ParticleSystem( 5.0, 0.05 );
        
  left_eye = physics.makeParticle( 1.0, width*.35, height*.20, 0 );
  left_eye_anchor = physics.makeParticle( 1.0, width*.35, height*.20, 0 );
  left_eye_anchor.makeFixed(); 
  left_eye_dangle = physics.makeSpring( left_eye, left_eye_anchor, 1.0, 0.1, 100 );
  
  right_eye = physics.makeParticle( 1.0, width*.65, height*.20, 0 );
  right_eye_anchor = physics.makeParticle( 1.0, width*.65, height*.20, 0 );
  right_eye_anchor.makeFixed(); 
  right_eye_dangle = physics.makeSpring( right_eye, right_eye_anchor, 1.0, 0.1, 100 );
  
  mouth = physics.makeParticle( 1.0, width*.50, height*.25, 0 );
  mouth_anchor = physics.makeParticle( 1.0, width*.50, height*.25, 0 );
  mouth_anchor.makeFixed(); 
  mouth_dangle = physics.makeSpring( mouth, mouth_anchor, 1.0, 0.1, 140 );

  physics.makeAttraction(left_eye, mouth, 10000, 10.0);
  physics.makeAttraction(right_eye, mouth, 10000, 10.0);
}

void draw()
{
  if ( !mousePressed )
    physics.advanceTime( 1.0 );
  else
  {
    mouth.moveTo( mouseX, mouseY, 0 );
    mouth.setVelocity( (mouseX - pmouseX), (mouseY - pmouseY), 0 );  // this is so you can throw it...
  }
    
  background( 255 );
  
  // Head
  fill( 0 );
  ellipse( 200, 200, 200, 200);
  
  // Left Eye
  fill( 255 );
  ellipse( left_eye.position().x(), left_eye.position().y(), 20, 20 );
  fill( 0 );
  ellipse( left_eye.position().x(), left_eye.position().y(), 15, 15 );
  fill( 255 );
  ellipse( left_eye.position().x(), left_eye.position().y() + 4, 15, 10 );
  
  // Right Eye
  fill( 255 );
  ellipse( right_eye.position().x(), right_eye.position().y(), 20, 20 );
  fill( 0 );
  ellipse( right_eye.position().x(), right_eye.position().y(), 15, 15 );
  fill( 255 );
  ellipse( right_eye.position().x(), right_eye.position().y() + 4, 15, 10 );
  
  // Mouth
  fill ( 255 );
  arc( mouth.position().x(), mouth.position().y(), 50, 50, PI, 0);
}


