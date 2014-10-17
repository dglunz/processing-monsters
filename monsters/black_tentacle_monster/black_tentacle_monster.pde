Monster monster;
boolean saveOne = false;

void setup()
{
    size(600, 600);
    noStroke();
    smooth();
    monster = new Monster(14, 400);
    
}

void draw()
{
    smooth();
    background(255);
    translate(width/2, height/2);
    
    monster.draw();
    
    if (saveOne) {
        saveFrame("renders/blackmonster-#######.png");
        saveOne = false;
    }
}

void keyPressed()
{
    if (key == 's') {
        saveOne = true;
    }
}
