public class LARVE {
  VEC3D KOPF, HINTERN, DIRECTION;
  int render_count,LARVE_SIZE,NAHRUNG,fluchtD,verpuppen;

  LARVE ( ){
    LARVE_SIZE = int( random(-1,8) );
    KOPF = new VEC3D(random(-50,width+50),random(-50,height+50),0);
    DIRECTION = new VEC3D(random(1),random(1),0);
    DIRECTION.NORMALIZE2D();
    render_count=int(random((LARVE_SIZE/2)*2));
    HINTERN = new VEC3D(DIRECTION.X*-1*LARVE_SIZE,DIRECTION.Y*-1*LARVE_SIZE,0);
    NAHRUNG = 0;
    fluchtD = 80;
  }

  LARVE (int tempSIZE,VEC3D temp){
    LARVE_SIZE = tempSIZE;
    KOPF = new VEC3D(temp);
    DIRECTION = new VEC3D(random(1),random(1),0);
    DIRECTION.NORMALIZE2D();
    render_count=int(random((LARVE_SIZE/2)*2));
    HINTERN = new VEC3D(DIRECTION.X*-1*LARVE_SIZE,DIRECTION.Y*-1*LARVE_SIZE,0);
    NAHRUNG = 0;
    fluchtD = 80;
  }

  public void CRAWL (ArrayList tempL) {
    if (LARVE_SIZE ==4){
      verpuppen++;
      if (verpuppen  > random(80,120) )       LARVE_SIZE ++ ;
    }
    if (LARVE_SIZE <= 0 && render_count > random(80,120) ) { 
      LARVE_SIZE ++ ;
    } 
    else if (LARVE_SIZE > 6) {
      render_count = (render_count > random(300,800) ) ? 0 : render_count;
      FIND_FOOD(tempL);
    } 
    else if (LARVE_SIZE > 0) {
      VEC3D tempVEC = new VEC3D(DIRECTION);
      int TL = LARVE_SIZE*4;
      if (render_count > LARVE_SIZE*7){
        HINTERN = new VEC3D(DIRECTION.X*-1*LARVE_SIZE/2,DIRECTION.Y*-1*LARVE_SIZE/2,0); 
        FIND_FOOD(tempL); 
        render_count = 0; 
      }
      else if (render_count > TL) {
        tempVEC.MULT_VEC(.2);
        KOPF.ADD_VEC(tempVEC);
        HINTERN.ADD_VEC(DIRECTION);
      }
      else {
        tempVEC.MULT_VEC(-1);
        KOPF.ADD_VEC(DIRECTION);
        HINTERN.ADD_VEC(tempVEC);
        tempVEC.MULT_VEC(-.2);
        HINTERN.ADD_VEC(tempVEC);
      }
      KOPF.X = (KOPF.X > width+TL) ? KOPF.X-width-TL : KOPF.X;
      KOPF.X = (KOPF.X < -TL) ? KOPF.X+width+TL : KOPF.X;
      KOPF.Y = (KOPF.Y > height+TL) ? KOPF.Y-height-TL : KOPF.Y;
      KOPF.Y =  (KOPF.Y < -TL) ? KOPF.Y+height+TL : KOPF.Y;
    }
    render_count++;
  }

  public void FIND_FOOD(ArrayList tempL){
    VEC3D tempVEC = new VEC3D(mouseX,mouseY,0);      
    boolean changed =  false;
    LARVE TL1; 
    if (LARVE_SIZE <= 0){
    }
    else if (LARVE_SIZE > 6) {
        tempVEC.FROM_TO(KOPF,tempVEC);
        tempVEC.NORMALIZE2D();
        tempVEC.MULT_VEC( fluchtD/dist(KOPF.X,KOPF.Y,mouseX,mouseY) );
        DIRECTION.ADD_VEC(tempVEC);
        DIRECTION.NORMALIZE2D();
    }
    else if (LARVE_SIZE < 4 ) {
      for (int i = 0; i < tempL.size() && !changed;i++) {
        TL1 = (LARVE) tempL.get(i);
        if(TL1 != this && TL1.LARVE_SIZE >= 4 && dist(TL1.KOPF.X,TL1.KOPF.Y,KOPF.X,KOPF.Y) < fluchtD ) {
          DIRECTION.FROM_TO(TL1.KOPF,KOPF);
          DIRECTION.ADD_VEC(new VEC3D(random(-1,1),random(-1,1),0));
          DIRECTION.NORMALIZE2D();
          changed = true;
        } 
      }
      if (!changed) {
        tempVEC.FROM_TO(KOPF,tempVEC);
        tempVEC.NORMALIZE2D();
        tempVEC.MULT_VEC( fluchtD/dist(KOPF.X,KOPF.Y,mouseX,mouseY) );
        DIRECTION.ADD_VEC(tempVEC);
        DIRECTION.NORMALIZE2D();
      }
    }
    else if (LARVE_SIZE == 4 ) {
      for (int i = 0; i < tempL.size() && !changed;i++) {
        TL1 = (LARVE) tempL.get(i);
        if(TL1 != this && TL1.LARVE_SIZE > 6 && dist(TL1.KOPF.X,TL1.KOPF.Y,KOPF.X,KOPF.Y) < fluchtD ) {
          DIRECTION.FROM_TO(TL1.KOPF,KOPF);
          DIRECTION.ADD_VEC(new VEC3D(random(-1,1),random(-1,1),0));
          DIRECTION.NORMALIZE2D();
          changed = true;
        } 
      }
    }
    else if (LARVE_SIZE > 4) {
      for (int i = 0; i < tempL.size() && !changed;i++) {
        TL1 = (LARVE) tempL.get(i);
        if(TL1.LARVE_SIZE > 0 && TL1.LARVE_SIZE < 4 && dist(TL1.KOPF.X,TL1.KOPF.Y,KOPF.X,KOPF.Y) < fluchtD*1.5 ) {
          DIRECTION.FROM_TO(KOPF,TL1.KOPF);
          DIRECTION.NORMALIZE2D();
          changed = true;
        } 
      }
    }
  }

  public void EAT(ArrayList tempL){
    VEC3D tempVEC = new VEC3D(mouseX,mouseY,0);
    LARVE TL1; 
    boolean changed = false;   
    if (LARVE_SIZE <= 0 || tempL.size() < 4 || LARVE_SIZE > 6 ){
    } 
    else if (LARVE_SIZE < 4 ) {
      if (dist(mouseX,mouseY,KOPF.X,KOPF.Y) <=15 ) NAHRUNG++;
    }
    else if (LARVE_SIZE > 4) {
      for (int i = 0; i < tempL.size() && !changed && tempL.size() >4;i++) {
        TL1 = (LARVE) tempL.get(i);
        if(TL1.LARVE_SIZE < 4 && TL1.LARVE_SIZE > 0 && dist(TL1.KOPF.X,TL1.KOPF.Y,KOPF.X+HINTERN.X,KOPF.Y+HINTERN.Y) <= 15) {
          NAHRUNG += TL1.LARVE_SIZE*4;
          tempL.remove(i);
          changed = true;
        } 
        if(TL1.LARVE_SIZE > 4 &&TL1.LARVE_SIZE<=6 && dist(TL1.KOPF.X,TL1.KOPF.Y,KOPF.X,KOPF.Y) != 0 && dist(TL1.KOPF.X,TL1.KOPF.Y,KOPF.X+HINTERN.X,KOPF.Y+HINTERN.Y) <= 15) {
          if (LARVE_SIZE > TL1.LARVE_SIZE) {
            tempL.remove(i);
          }
          else if (LARVE_SIZE == TL1.LARVE_SIZE && NAHRUNG > TL1.NAHRUNG) {
            tempL.remove(i);
          }
          else {
            tempL.remove(tempL.indexOf(this)); 
          }
          for (int i2 =0;i2 <= TL1.LARVE_SIZE*2 && tempL.size() < 80;i2++){
            tempL.add( new LARVE(0,KOPF) );
          }
          changed = true;
        }
      }
    }
    if (NAHRUNG > LARVE_SIZE*30) {
      LARVE_SIZE++;
      NAHRUNG = 0;
    }
  }

  public void RENDER() {
    if (LARVE_SIZE <= 0) {
      ellipse(KOPF.X,KOPF.Y,2,2);
    } 
    else if (LARVE_SIZE > 6) {
      pushMatrix();
      translate(KOPF.X,KOPF.Y);
      noStroke();
      fill(0);
      line(0,0,HINTERN.X,HINTERN.Y);
      ellipse(0,0,LARVE_SIZE*5.5,LARVE_SIZE*5 ); 
      fill(255);
      ellipse(0,0,LARVE_SIZE*6, LARVE_SIZE*5*(abs(.5-((render_count/300.00) ))+.1) ); 
      fill(0);
      ellipse(DIRECTION.X*3,DIRECTION.Y*3,LARVE_SIZE*2,LARVE_SIZE*2);
      popMatrix();
    } 
    else{
      VEC3D tempVEC = new VEC3D(DIRECTION);
      tempVEC.MULT_VEC(LARVE_SIZE*1.5);
      VEC3D tempVEC2 = new VEC3D(tempVEC);
      tempVEC2.PERP2D();
      float middle =  ( (sqrt(LARVE_SIZE)*.3)+((LARVE_SIZE)/HINTERN.DIST2D()) );
      middle = (middle > 1.2) ? 1.2 : middle;
      fill(0);
      noStroke();
      pushMatrix();
      translate(KOPF.X,KOPF.Y);
      beginShape();
      //KOPF
      curveVertex((tempVEC.X*2+tempVEC2.X/8),(tempVEC.Y*2+tempVEC2.Y/8)); 
      curveVertex( (tempVEC2.X+tempVEC.X),tempVEC2.Y+tempVEC.Y);
      //MITTE
      curveVertex( HINTERN.X/2+tempVEC2.X*(middle) , (HINTERN.Y/2+tempVEC2.Y*(middle) )  ); 
      //HINTERN
      curveVertex((HINTERN.X-tempVEC.X+tempVEC2.X),(HINTERN.Y-tempVEC.Y+tempVEC2.Y));
      curveVertex((HINTERN.X-tempVEC.X*2),(HINTERN.Y-tempVEC.Y*2));
      curveVertex((HINTERN.X-tempVEC.X-tempVEC2.X),(HINTERN.Y-tempVEC.Y-tempVEC2.Y));
      //MITTE
      curveVertex( HINTERN.X/2-tempVEC2.X*(middle) , (HINTERN.Y/2-tempVEC2.Y*(middle) )  ); 
      //KOPF    
      curveVertex( (-tempVEC2.X+tempVEC.X),-tempVEC2.Y+tempVEC.Y);
      curveVertex((tempVEC.X*2-tempVEC2.X/8),(tempVEC.Y*2-tempVEC2.Y/8)); 
      endShape(CLOSE);

      if (LARVE_SIZE > 3) {
        stroke(0);
        noFill();
        for (int i = 0; i < LARVE_SIZE*10;i++) {
          line(0,0,random(-LARVE_SIZE*3,LARVE_SIZE*3),random(-LARVE_SIZE*3,LARVE_SIZE*3));
          line(HINTERN.X,HINTERN.Y,HINTERN.X+random(-LARVE_SIZE*3,LARVE_SIZE*3),HINTERN.Y+random(-LARVE_SIZE*3,LARVE_SIZE*3));  
        } 
      }
      if (LARVE_SIZE > 4) {
        line(0,0,tempVEC.X*4+tempVEC2.X,tempVEC.Y*4+tempVEC2.Y);
                line(0,0,tempVEC.X*4-tempVEC2.X,tempVEC.Y*4-tempVEC2.Y);
      }
      if (LARVE_SIZE >= 2) {
        fill(255);
        stroke(60);
        ellipse(tempVEC.X,tempVEC.Y,LARVE_SIZE*3,LARVE_SIZE*3); 
        fill(0);
        noStroke();
        ellipse(tempVEC.X*1.5,tempVEC.Y*1.5,LARVE_SIZE,LARVE_SIZE);
      }
      popMatrix();
    }
  }

}

























