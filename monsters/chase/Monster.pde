
class Monster {
  // important for monster -----------------------------------------------------
  Vector2d loc;                           // location of the monster
  Vector2d dir = new Vector2d(0, 0);      // the direction, the monster is heading
  Vector2d nextStep = new Vector2d(0, 0); // the next step to make
  Vector2d speed;       // the speed the monster can go in x and y direction
  // visual effects -------------------------------------------------------------
  int maxRndSpeed = 3;  // maximum speed
  float mSize = 25;     // size of the eye
  int maxTentacles = 7; // amount of legs
  Vector2d [] tentacles = new Vector2d[maxTentacles]; // position of the feet
  int updateTCount = 0; // feet update count
  Vector2d eatPoint;    // the point, the monster eats a line
  Vector2d textPos;     // position of the current text
  int textIndex = 0;    // which text is spoken
  int maxTexts = 6;     // size of the textarray
  int updateText = 0;   // when wil the text be updated
  int doTexts = 1;      // not all monsters should speak, so the screen isnt too full
  String [] rndText = { // this are the texts, the monsters say, when near the mouse
    "juhuu!", "yeah!", "finally!", "round and round!", "yes",
    "go go go!"};
  
  Monster(float x, float y) {
    this.loc   = new Vector2d(x, y);
    this.speed = new Vector2d(1 + random(maxRndSpeed), 1 + random(maxRndSpeed));
  }

  void nextStep() {
    // calculate the next step of the monster
    this.dir = new Vector2d(mouseX - this.loc.x, mouseY - this.loc.y);
    if (abs(this.dir.lengthVt()) < 12) {
      this.nextStep = diffVts(this.loc, rotateVtS(this.loc, new Vector2d(mouseX, mouseY), random(0.2)));
    } 
    else {
      this.dir.scaleVt(1);
      this.nextStep = multVts(this.dir, this.speed);
    }
  }

  void update() {
    // apply the next step to the monster
    this.loc.addVt(this.nextStep);
    this.draw();
  }

  void draw() {
    // the monster gets drawn, its a bit of a mess, but works well
    strokeWeight(1.1);
    if (abs(diffVts(this.loc, new Vector2d(mouseX, mouseY)).lengthVt()) > 15) {
      this.doTexts = int(random(4));
      Vector2d front  = addVts(scaleVtScal(this.dir,  30), this.loc);
      Vector2d back   = addVts(scaleVtScal(this.dir, -20),  this.loc);
      if (updateTCount <= 0) {
        for (int i = 0; i < maxTentacles; i++) {
          if (this.eatPoint == null) {
            tentacles[i] = rotateVtS(back, this.loc, 1.5 * (i- maxTentacles / 2) * random(1));
          } 
          else {
            tentacles[i] = rotateVtS(this.eatPoint, this.loc, 1.5 * (i- maxTentacles / 2) * random(0.5));
          }
          noFill();
          bezier(this.loc.x, this.loc.y, front.x, front.y, back.x, back.y, tentacles[i].x, tentacles[i].y);
          fill(0);
          ellipse(tentacles[i].x, tentacles[i].y, 4, 4);
        }
        updateTCount = int(speed.x * 2);
      }
      else {
        updateTCount -= 1;
        for (int i = 0; i < maxTentacles; i++) {
          noFill();
          bezier(this.loc.x, this.loc.y, front.x, front.y, back.x, back.y, tentacles[i].x, tentacles[i].y);
          fill(0);

          ellipse(tentacles[i].x, tentacles[i].y, 4, 4);
        }
      }
      stroke(0);
      fill(255);
      ellipse(this.loc.x, this.loc.y, mSize, mSize);
      fill(0);
      Vector2d pupille = addVts(this.loc, scaleVtScal(this.dir, mSize / 4));
      ellipse(pupille.x, pupille.y, mSize / 4, mSize / 4);
    } 
    else {
      if (this.doTexts == 1) {
        if (updateText <= 0) {
          this.textPos = new Vector2d(random(width / 2 - 250) + this.loc.x, random(height - 100) + 50);
          textIndex = int(random(maxTexts));
          text(rndText[textIndex], this.textPos.x, this.textPos.y);
          line(this.loc.x, this.loc.y, this.textPos.x, this.textPos.y);
          updateText = 100;
        } 
        else {
          if (this.textPos != null) {
            text(rndText[textIndex], this.textPos.x, this.textPos.y);
            line(this.loc.x, this.loc.y, this.textPos.x, this.textPos.y);
          }
          updateText -= 1;
        }
      }
      stroke(0);
      fill(255);
      ellipse(this.loc.x, this.loc.y, mSize, mSize);
      fill(0);
      Vector2d pupille = addVts(this.loc, scaleVtScal(this.dir, mSize / 4));
      ellipse(pupille.x, pupille.y, mSize / 4, mSize / 4);
    }
  }
}

