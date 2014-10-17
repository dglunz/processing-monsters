int MIN_SIZE = 10;
int INC_DEC = 2;

Eye center;

ArrayList parts = new ArrayList();

void setup() {
  size(400, 400);

  background(255);
  smooth();

  center = new Eye();
}

void draw() {
  background(255);

  center.place(mouseX, mouseY);

  if(frameCount % 5 == 0) {
    tick();
  }

  for(int i = parts.size()-1; i >= 0; i--) {
    Eye e = (Eye)parts.get(i);

    if(e.x == center.x && e.y == center.y && !mousePressed) {
      parts.remove(i);
      center.size += INC_DEC;
    } 
    else {
      e.tick();
      e.draw();
    }
  }

  center.tick();
  center.draw();
}

void tick() {
  if(mousePressed) {
    // split up
    if(center.size > MIN_SIZE) {
      center.size -= INC_DEC;

      Eye child = new Eye(center.x, center.y, MIN_SIZE);
      child.move((int) random(0, width), (int) random(0, height));
      parts.add(child);
    }
  } 
  else {
    for(int i = parts.size()-1; i >= 0; i--) {
      Eye e = (Eye)parts.get(i);
      e.move(center.x, center.y);
    }
  }
}



