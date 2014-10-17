import traer.physics.*;

ParticleSystem pS;
Particle[] particles;
boolean showLines;
int rad;
int edges=20;
void setup(){
  size(450,300);
  smooth(); 

  float strength=8.4;
  float damping=0.1;
  int offSetX=200;
  int offSetY=10;

  pS = new ParticleSystem( 6, 0.005 );
  particles = new Particle[edges];

  for (int i=0; i<edges; ++i)  {
    rad=30*(i%2+1);
    float x=cos(TWO_PI/particles.length*i)*rad+ offSetX;
    float y=sin(TWO_PI/particles.length*i)*rad+ offSetY;
    particles[i] = pS.makeParticle(1,x,y,0);
  }

  for(int i=0;i<particles.length-1;i++){
    for(int j=i+1;j<particles.length;j++){
      float d=dist(particles[i].position().x(),particles[i].position().y(),particles[j].position().x(),particles[j].position().y());
      pS.makeSpring(particles[i],particles[j],strength,damping,d);
    }
  }
  strokeWeight(2);
}  



void draw(){

  fill(0);
  noStroke();
  background(255);

  if (mousePressed)  {
    particles[0].moveTo( (mouseX), (mouseY),0 );
    particles[0].velocity().clear();
  } 
  pS.advanceTime(0.1);

  if(!showLines){
    beginShape(POLYGON);
    curveVertex(particles[0].position().x(),particles[0].position().y());
  }

  for(int i=0;i<edges;i++){
    if(!showLines) curveVertex(particles[i].position().x(),particles[i].position().y());
    if(particles[i].position().y()>height){
      particles[i].setVelocity( particles[i].velocity().x(), particles[i].velocity().y()*-1.0, 0 );
      particles[i]. moveTo(particles[i].position().x(),height,0);
    }
    if(particles[i].position().y()<0){
      particles[i].setVelocity( particles[i].velocity().x(), particles[i].velocity().y()*-1.0, 0 );
      particles[i]. moveTo(particles[i].position().x(),0,0);
    }
    if(particles[i].position().x()>width){
      particles[i].setVelocity( particles[i].velocity().x()*-1.0,particles[i].velocity().y() , 0 );
      particles[i]. moveTo(width,particles[i].position().y(),0);
    }
    if(particles[i].position().x()<0){
      particles[i].setVelocity( particles[i].velocity().x()*-1.0,particles[i].velocity().y() , 0 );
      particles[i]. moveTo(0,particles[i].position().y(),0);
    }
  }


  curveVertex(particles[0].position().x(),particles[0].position().y());
  curveVertex(particles[0].position().x(),particles[0].position().y());
  endShape();
  float x1 = (particles[0].position().x());
  float y1 = (particles[0].position().y());

  float x2 = (particles[2].position().x());
  float y2 = (particles[2].position().y());

  fill(255);
  ellipse(x1,y1, 10,10);
  ellipse(x2,y2, 10,10);

  stroke(0);
  line(x1-2,y1-2, x1+2,y1+2);
  line(x1+2,y1-2, x1-2,y1+2);

  line(x2-2,y2-2, x2+2,y2+2);
  line(x2+2,y2-2, x2-2,y2+2);


  fill(255);

  beginShape();
  for(int i=4; i<20; i+=4){
    float x = lerp(particles[i].position().x(), particles[(i+10)%2].position().x(), .4);
    float y = lerp(particles[i].position().y(), particles[(i+10)%2].position().y(), .4);
    curveVertex(x,y);
  }
  curveVertex(particles[6].position().x()+3, particles[6].position().y()+3);
  endShape(CLOSE);




}
void mouseReleased(){
  particles[0].setVelocity( (mouseX - pmouseX),(mouseY - pmouseY),0);
} 
