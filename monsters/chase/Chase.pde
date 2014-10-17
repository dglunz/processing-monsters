/**
 * made by lukas thum 12.7.2009
 * 
 * all the monsters want to get to the mouse, you can prevent them
 * to do so by draging lines in their way, but they are able to eat them.
 */

int maxMonsters = 10;
Monster [] monsters = new Monster[maxMonsters];
Vector2d [] steps = new Vector2d[maxMonsters];

int maxLines = 75;
int lineCount = 0;
LinkedList first = new LinkedList(null, 0, null);
Line2d currLine;
int maxEat = 50;

void setup() {
  size(800, 600, P2D);
  smooth();
  textFont(loadFont("Gabriola-48.vlw"), 32);
  // initialize the monsters, hahahahaha!!!
  for (int i = 0; i < maxMonsters; i++) {
    monsters[i] = new Monster(random(width), random(height));
  }
}

void addNewLine(Line2d line2d) {
  first.next = new LinkedList(currLine, maxEat, first.next);
  if (lineCount > maxLines) {
    LinkedList currNode = first;
    while (currNode.next.next != null) {
      currNode = currNode.next;
    }
    currNode.next = null;
  } 
  else {
    lineCount += 1;
  }
}

void mouseReleased() {
  addNewLine(currLine);
  currLine = null;
}

void draw() {
  background(255, 255, 255);
  if (mousePressed) {
    if (currLine == null)  {
      currLine = new Line2d(new Vector2d(mouseX, mouseY), new Vector2d(0, 0));
    }
    else {
      currLine.u = diffVts(new Vector2d(mouseX, mouseY), currLine.o);
      if (currLine.u.lengthVt() > 10) {
        addNewLine(currLine);
        currLine = new Line2d(new Vector2d(mouseX, mouseY), new Vector2d(0, 0));
      }
    }
  }
  checkCollisions();
  for (int j = 0; j < maxMonsters; j++) {
    monsters[j].update();
  }
}

void checkCollisions() {
  for (int j = 0; j < maxMonsters; j++) {
    monsters[j].nextStep();
    monsters[j].eatPoint = null;
  }
  try {
    LinkedList currNode = first;
    while (currNode.next != null) {
      for (int j = 0; j < maxMonsters; j++) {
        Line2d currStep = new Line2d(monsters[j].loc, multVtScal(monsters[j].nextStep, 10));
        Vector2d eatPoint = intersectionLn(currStep, currNode.next.line2d);
        if (eatPoint != null) {
          monsters[j].nextStep = new Vector2d(0, 0);
          currNode.next.eaten -= 1;
          monsters[j].eatPoint = eatPoint;
          if (currNode.next.eaten < 1) {
            currNode.next = currNode.next.next;
            lineCount -= 1;
          }

        }
      }
      drawLine(currNode.line2d);
      currNode = currNode.next;
    }
  } 
  catch (NullPointerException e) {
    println("no idea, seems my linked list has a bug...");
  }
}

void drawLine(Line2d line2d) {
  if (line2d != null) {
    stroke(0);
    strokeWeight(2);
    line(line2d.o.x, line2d.o.y, line2d.getPtU().x, line2d.getPtU().y);
  }
}

