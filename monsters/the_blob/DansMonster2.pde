// "The Blob" by Daniel Piker. Created for "Processing Monsters"
//
// For more see          OpenProcessing user 'Daniel Piker'
// or go to my website:  spacesymmetrystructure.wordpress.com
// or my Vimeo page:     http://vimeo.com/user798992

int squareWidth = 6;
int BrushSize  = 1;
int EraserSize = 4;
int gameWidth = 70;
int gameHeight = 70;
int gray = 0;
int[] keeptrack = new int[gameWidth*gameHeight];
int index = 0;
float avrg;
int left;
int right;
int above;
int below;

void setup() {
  colorMode(HSB, 1);
  size(gameWidth * squareWidth, gameHeight * squareWidth);
  background(0);
  noStroke();
}

void draw() {
  for (int i = 0; i < gameWidth; i++) {
    for (int j = 0; j < gameHeight; j++) {
      
      index = (index+1)%(gameWidth*gameHeight);
      gray = keeptrack[index];
      drawSquare(i, j, gray);  

   below = (index+1)%(gameWidth*gameHeight);
   above = abs(index-1)%(gameWidth*gameHeight);
   left  = abs(index-gameHeight)%(gameWidth*gameHeight);
   right = (index+gameHeight)%(gameWidth*gameHeight);
   avrg = (sqrt(((keeptrack[left]*keeptrack[left])+(keeptrack[above]*keeptrack[above])+(keeptrack[right]*keeptrack[right])+(keeptrack[below]*keeptrack[below]))*.25));
   keeptrack[index] = ((round((((1.5*keeptrack[index])+(avrg*1))/2.45)-0.4)))%100;  
    }}}
  void drawSquare(int x, int y, int grayness) { 
  fill(100,0,1-(round(grayness/32))%3);
  rect(x*squareWidth, y*squareWidth, squareWidth, squareWidth); 
}
void mouseDragged() { 
if (mouseButton == LEFT) {
  for (int i = 1-BrushSize; i < BrushSize; i++) {
    for (int j = 1-BrushSize; j < BrushSize; j++) {
      drawSquare(mouseX / squareWidth + i, mouseY / squareWidth + j, 50);
      keeptrack[getIndex (mouseX/squareWidth + i,mouseY/squareWidth + j)]         =  100; 
  }}}
else if (mouseButton == RIGHT) {
  for (int i = 1-EraserSize; i < EraserSize; i++) {
    for (int j = 1-EraserSize; j < EraserSize; j++) {
  drawSquare(mouseX / squareWidth + i, mouseY / squareWidth + j, 0);
      keeptrack[getIndex (mouseX/squareWidth + i,mouseY/squareWidth + j)]         =  0;             
      }}}}
  public int getIndex(int x, int y) {
    return abs(constrain(((x%gameWidth) * gameHeight + (y%gameHeight)),0,(gameWidth*gameHeight)));
}
