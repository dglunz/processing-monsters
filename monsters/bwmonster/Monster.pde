class Monster
{
  boolean isShooting;
  float x;
  float y;
  float nextX = random(width / 4, width * 3 / 4);

  float targetX;
  float targetY;
  float bulletX;
  float bulletY;
  float shotX;
  float shotY;
  int shotMaxCount;
  int shotCount;

  Monster()
  {
    isShooting = false;
    shotMaxCount = 6;
    x = width / 2;
    y = 50;
  }

  void render()
  { 
    if(abs(nextX - x) < 5)
    {
      nextX = random(width / 8, width * 7 / 8);
    }
    
    x += (nextX - x) / abs((nextX - x) / 1.4);
    
    // base
    noStroke();
    fill(0);
    ellipse(x, y, 100, 60);
    ellipse(x, y + 20, 100, 20);
    triangle(x - 30, y - 20, x - 30, y - 50, x - 25, y - 20);
    triangle(x + 30, y - 20, x + 30, y - 50, x + 25, y - 20); 

    // eye white
    fill(255);
    ellipse(x, y, 25, 25);

    // eye
    fill(0);
    float eyeX = map(mouseX, 0, width, -8, 8);
    float eyeY = map(abs(mouseX - width / 2) + width / 2, 0, width / 2, -16, -8);
    ellipse(x + eyeX, y - eyeY, 10, 10);

    // teeth
    fill(255);
    stroke(0);

    for(int i = (int)x - 40; i <= x + 40; i += 10)
    {
      triangle(i - 3, y + 20, i + 3, y + 20, i, y + 30);
    }

    if(isShooting)
    {
      float currX = map(shotCount, 0, shotMaxCount, shotX, targetX);
      float currY = map(shotCount, 0, shotMaxCount, shotY, targetY);

      stroke(0);
      float oldStrokeWeight = g.strokeWeight;
      strokeWeight(1.25);
      line(targetX, targetY, currX, currY);
      strokeWeight(oldStrokeWeight);

      shotCount++;
      if(shotCount >= shotMaxCount)
      {
        isShooting = false;
      }
    }
  }

  void shoot(int x, int y)
  {
    if(isShooting)
    {
      return;
    }

    isShooting = true;
    targetX = x;
    targetY = y;
    shotX = this.x;
    shotY = this.y + 30;
    shotCount = 0;
  }
}

