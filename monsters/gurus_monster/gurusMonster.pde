 /**
A processing monster by 
<a href="http://www.local-guru.net/blog">Guru</a>
*/

void setup() {
  size(300,300);
  smooth();
  frameRate(25);
}


void draw() {
  background(0);
  fill(255);
  stroke(0);
  
  //ellipse( 150, 150, 150,150 );
  
  if ( mousePressed ) {
   beginShape();
   for ( int i = 0; i < 22; i ++ ) {
     curveVertex( 150 + sin( i * 2*PI / 20 ) * (75 + random(10)), 150 + cos( i * 2*PI / 20 ) * (75 + random(10)));
   } 
   endShape();
    
   line( 120, 125, 140, 135 );
   line( 160, 135, 180, 125 );
   
   fill(0);
   ellipse(150,170,40,20);
   fill(255);
   noStroke();
   beginShape();
   vertex(135,160);
   vertex(137,170);
   vertex(139,160);
   endShape();
   beginShape();
   vertex(165,160);
   vertex(163,170);
   vertex(161,160);
   endShape();
   beginShape();
   vertex(140,180);
   vertex(142,170);
   vertex(144,180);
   endShape();
   beginShape();
   vertex(160,180);
   vertex(158,170);
   vertex(156,180);
   endShape();
  
  } else {
   beginShape();
   for ( int i = 0; i < 22; i ++ ) {
     curveVertex( 150 + sin( i * 2*PI / 20 ) * 75, 150 + cos( i * 2*PI / 20 ) * 75 );
   } 
   endShape();
    
    line( 120, 130, 140, 130 );
    line( 160, 130, 180, 130 );
    line( 130, 170, 170, 170 );
  }
}
