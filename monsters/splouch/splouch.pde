int nTentacles = 15;
Tentacle[] tentacles;

int stw = 1000;
int sth = 500;

void setup()
{
  size(1000, 500);
  tentacles = new Tentacle[nTentacles];
  for(int i = 0; i < nTentacles; i++)
  {
    tentacles[i] = new Tentacle(stw / 2, sth / 2, (mouseX - stw / 2) / 100, (mouseY - sth / 2) / 100, 35.0 + random(15.0)); 
  }
}

void draw()
{
  background(255);
  for(int i = 0; i < nTentacles; i++) tentacles[i].update();
}

void mousePressed()
{
  for(int i = 0; i < nTentacles; i++) tentacles[i].hop = !tentacles[i].hop;
}
class Tentacle
{
  
  public float x;
  public float y;
  public float vx;
  public float vy;
  private TentaclePoint[] pts;
  public float life;
  public boolean dir = true;
  public boolean hop = true;

  
  Tentacle(float x, float y, float vx, float vy, float life)
  {
    init(x, y, vx, vy, life);
  }
  
  private void init(float x, float y, float vx, float vy, float life)
  {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.life = life;
    pts = new TentaclePoint[0];
    dir = true;
  }
  
  public void update()
  {
    if (dir) pts = (TentaclePoint[])append(pts, new TentaclePoint(x, y, 0, 0));
    else pts = (TentaclePoint[])shorten(pts);
    
    move();
    int nPts = pts.length;
    for(int i = nPts - 1; i >=0 ; i--)
    {
      float r = (float)i / nPts;
      strokeWeight(pow((1 - r) * 10, 2) * (100 - abs(life)) / 100);
      //strokeWeight(1);
      pts[i].move(mouseX, mouseY, r, hop);
      line(pts[min(i + 1, nPts - 1)].x, pts[min(i + 1, nPts - 1)].y, pts[i].x, pts[i].y);
    }
    
    life -= 0.5;
    if (life <= 0 && dir) dir = false;
    else if (!dir && pts.length <= 1) init(pts[0].x, pts[0].y, pts[0].vx, pts[0].vy, 35.0 + random(15.0));
  }
  
  private void move()
  {
    vx += random(-2.0, 2.0) + (mouseX - stw/2.0) / 2000.0;
    vy += random(-2.0, 2.0) + (mouseY - sth/2.0) / 2000.0;
    vx *= 0.95;
    vy *= 0.95;
    x += vx;
    y += vy;
  }
  
}
class TentaclePoint
{
  
  public float x;
  public float y;
  public float vx;
  public float vy;
  
  
  TentaclePoint(float x, float y, float vx, float vy)
  {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
  }
  
  public void move(float tx, float ty, float r, boolean hop)
  {
    vx += (hop ? r : 1 - r) * (tx - x) / 1500;
    vy += (hop ? r : 1 - r) * (ty - y) / 1500;
    vx *= 0.95;
    vy *= 0.95;
    x += vx;
    y += vy;
  }
}
