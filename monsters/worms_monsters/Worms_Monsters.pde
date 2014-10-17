Monster [] monster;

void setup()
{ size (500,300);
  frameRate(25);

  smooth();
  
  monster = new Monster [50];
  for (int i=0, colorOfMonster = (monster.length)*2; i<monster.length; i++)
  {
    monster[i]= new Monster ();
    monster[i].monsterColor = colorOfMonster;
    colorOfMonster -=2;
    
  }
  
}

void draw ()
{  
  background (255);
  fill (0);
  rect (0,height-50,width,50);

   for (int i=0; i<monster.length; i++)
  {
      monster[i].drawMonster (abs(monster[i].positionX-mouseX)/10,int(random (0,40)));
  }
  
  
}

class Monster
{
   int positionX = int (random (0,width));
   int positionY = height-50;
   int monsterHeight = int (random (1,5));
   int monsterWidth = int (random (30,50));
   int deformation = 20;
   int monsterColor;
   
   void drawMonster (float variableHeight,int closeEyes)
   {
     
     if (variableHeight > 4)
     {
     fill (0);
      beginShape();
      vertex(positionX-monsterWidth/2, positionY);
      bezierVertex(positionX-monsterWidth/2+deformation, positionY, positionX - deformation, positionY-(monsterHeight*variableHeight), positionX, positionY-(monsterHeight*variableHeight));
      bezierVertex(positionX+deformation, positionY-(monsterHeight*variableHeight), positionX+monsterWidth/2-deformation, positionY, positionX+monsterWidth/2, positionY);
      endShape();
     }
        if (variableHeight > 11 && closeEyes > 0)
     {
      fill (255);
      noStroke();
      ellipse (positionX-3,positionY-(monsterHeight*variableHeight)+10,6,6);
      fill (0);
      pushMatrix ();
      translate (positionX-3,positionY-(monsterHeight*variableHeight)+10);
      rotate (atan2(mouseY-(positionY-(monsterHeight*variableHeight)+10),mouseX-positionX-3));
      ellipse (1,0,2,2);
      popMatrix();
      fill (255);
      ellipse (positionX+3,positionY-(monsterHeight*variableHeight)+10,6,6);
      fill (0);
      pushMatrix ();
      translate (positionX+3,positionY-(monsterHeight*variableHeight)+10);
      rotate (atan2(mouseY-(positionY-(monsterHeight*variableHeight)+10),mouseX-positionX+3));
      ellipse (1,0,2,2);
      popMatrix();
     }
   }

 
 }

