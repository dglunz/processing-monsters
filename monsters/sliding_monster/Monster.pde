class Monster{
  float footY;
  float right, left;
  float tr, tl;
  float vl, vr;
  float friction;
  float w, h;
  float tx;
  float attraction;
  float minDist;
  float sole;
  Eyeball[] eyes;

  public Monster( float w, float h, float y, float sole, int numEyes ){
    footY = y;
    left = 0;
    right = w;
    this.w = w;
    this.h = h;
    this.sole = sole;
    tr = tl = 0;
    vl = vr = 0;
    friction = 0.65;
    attraction = 0.1;
    minDist = 5;
    eyes = new Eyeball[numEyes];
    for( int i=0; i!=numEyes; i++ ){
      eyes[i] = new Eyeball( i*w/numEyes + w/(numEyes*2), random( h/4, h/2), random(12,24) );
    }
  }

  public void update( float target ){
    if( target < left+w/2 ){
      tl = target;
      tr = target+w;
      vl += (tl-left)*attraction;
      if( abs(tl-left) < minDist )
        vr += (tr-right)*attraction;
    } 
    else if ( target > right-w/2  ){
      tr = target;
      tl = target-w;
      vr += (tr-right)*attraction;
      if( abs(tr-right) < minDist )
        vl += (tl-left)*attraction;
    }
    right += vr;
    left += vl;
    vr *= friction;
    vl *= friction;
  }

  public void draw(){

    fill(0);
    strokeWeight(1);
    beginShape();
    curveVertex( left+currentWidth()/2, footY+sole );
    curveVertex( left+currentWidth()/2, footY+sole );
    curveVertex( left, footY );
    curveVertex( (right+left)/2 - w/4, footY-currentHeight()*0.8 );

    curveVertex( (right+left)/2 + w/4, footY-currentHeight()*0.8 );
    curveVertex( right, footY );
    curveVertex( right-currentWidth()/2, footY+sole );
    curveVertex( right-currentWidth()/2, footY+sole );
    endShape();

    //eyeballs
    fill(255);

    for( int i=0; i!=eyes.length; i++ ){
      strokeWeight(4);
      line( left+eyes[i].x, footY-currentHeight()+eyes[i].y, left+currentWidth()/2, footY-currentHeight()/2 );
    }
    for( int i=0; i!=eyes.length; i++ ){
      strokeWeight(3);
      ellipse( left+eyes[i].x, footY-currentHeight()+eyes[i].y, eyes[i].radius, eyes[i].radius ); 
    }
  }

  private float currentHeight(){
    return min( ( w/(right-left) )*h, h*2 );
  }

  private float currentWidth(){
    return right-left;
  }
}

