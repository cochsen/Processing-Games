/* Refactor
 * 1 ArrayList of Dart objects
 * Dart objects will have 2D dimensions of whole row/col
 * Image will be repeating Dart.length/image.length times
 * Dart obj will be removed from ArrayList after leaving screen and new obj will be created
 */

int state, tmpOrientation;
float w, h;
boolean[] keys;
int[] orientations = new int[8];
int[] dartRowSize = new int[8];
int[] startPos = new int[8];
PImage PlayerImg, dartImgUp, dartImgDown, dartImgLeft, dartImgRight, 
  tmpImage;
Player player;
/*
 * ArrayList todos:
 * triggers for launch of row - timed or event-driven
 */
// ArrayList of darts - single row/col
ArrayList<Dart> Darts = new ArrayList<Dart>();
  
void setup() {
  size(480, 480);
  // slow down game for testing
  frameRate(30);
  w=width; h=height;
  background(0);
  state = 0;
  keys = new boolean[4];  // mapping: [d,a,s,w]
  for(int i=0; i<keys.length; i++) keys[i] = false;  
  // orientation initial values (determines starting side and direction of movement)
  for(int i=0; i<orientations.length; i++) {
    orientations[i] = int(random(5));  
  }
  // initial number of darts for first 8 rows/cols
  for(int i=0; i<dartRowSize.length; i++) {
    dartRowSize[i] = 24*int(random(1, 17));
  }
  // some index to start the row/col that will fit all the darts on the screen
  for(int i=0; i<startPos.length; i++) {
    startPos[i] = int(random(480-dartRowSize[i]));  
  }
  // load .png images
  PlayerImg = loadImage("actor.png");
  dartImgUp = loadImage("DartPointUp.png");
  dartImgLeft = loadImage("DartPointLeft.png");
  dartImgDown = loadImage("DartPointDown.png");
  dartImgRight = loadImage("DartPointRight.png");
  // initialize player in the middle of the board
  player = new Player(PlayerImg, w/2, h/2);
  // add 8 ArrayLists of darts to ArrayList rows
  // select image based on orientation
  for(int i=0; i<orientations.length; i++) {
    switch(orientations[i]) {
      case 1:
        tmpImage = dartImgDown;
        tmpOrientation = 1;
        break;
      case 2:
        tmpImage = dartImgLeft;
        tmpOrientation = 2;
        break;
      case 3:
        tmpImage = dartImgUp;
        tmpOrientation = 3;
        break;
      case 4:
        tmpImage = dartImgRight;
        tmpOrientation = 4;
        break;
      default:
        break;
    }
    // create dart with image and positions based on orientation
    for(int j=0; j<orientations.length; j++) {
      if(tmpOrientation == 1)
        Darts.add(new Dart(tmpImage, tmpOrientation, startPos[j], 0.0, dartRowSize[j], 24));
      else if(tmpOrientation == 2)
        Darts.add(new Dart(tmpImage, tmpOrientation, w, startPos[j], 24, dartRowSize[j]));
      else if(tmpOrientation == 3)
        Darts.add(new Dart(tmpImage, tmpOrientation, startPos[j], h, dartRowSize[j], 24));
      else
        Darts.add(new Dart(tmpImage, tmpOrientation, 0.0, startPos[j], 24, dartRowSize[j])); 
    }
  }
  for(int i=0; i<Darts.size(); i++) println(i + ":" + "xpos:" + Darts.get(i).xpos + " " + Darts.get(i).ypos);
}

void draw() {
  background(0);
  drawGrid();  
  player.update();
  player.display(); 
  for(int i=Darts.size()-1; i>=0; i--) {
    Dart currentDart = Darts.get(i);
    currentDart.out = outOfBounds(currentDart);
    if(currentDart.out == true) 
    {
      Darts.remove(currentDart);
      updateOrientations(); 
    }
    else {
      currentDart.move();
      currentDart.display();
    }      
  }     
}

void drawGrid() {
  stroke(80,0,80);
  strokeWeight(5);  
  for(int i=0; i<10; i++) line(0, h/10+i*h/10, w, h/10+i*h/10);
  for(int j=0; j<10; j++) line(w/10+j*w/10, h, w/10+j*w/10, 0);    
}

void keyPressed() 
{
    if(key == 'a' || key == 'A') keys[1] = true;
    if(key == 'd' || key == 'D') keys[0] = true;
    if(key == 'w' || key == 'W') keys[2] = true;
    if(key == 's' || key == 'S') keys[3] = true;      
}

void keyReleased()
{
  if(key == 'a' || key == 'A') keys[1] = false;
  if(key == 'd' || key == 'D') keys[0] = false;
  if(key == 'w' || key == 'W') keys[2] = false;
  if(key == 's' || key == 'S') keys[3] = false;
}

// generate random integers for orientations of n rows of darts
void updateOrientations() {
  for(int i=0; i<orientations.length-1; i++) {
    int tmp = orientations[i+1];
    orientations[i] = tmp;
    orientations[orientations.length-1] = int(random(5));
  }
}

/*
// generate random integers for number of darts in each row
void updateDartNums() {
  for(int i=0; i<numOfDarts.length-1; i++) {
    int tmp = numOfDarts[i+1];
    numOfDarts[i] = tmp;
    numOfDarts[numOfDarts.length-1] = int(random(17));
  }
}

void updateStartIndexes() {
  for(int i=0; i<startIndexes.length-1; i++) {
    int tmp = startIndexes[i+1];
    startIndexes[i] = tmp;
    startIndexes[startIndexes.length-1] = int(random(25-numOfDarts[i]));
  }
}
*/

boolean outOfBounds (Dart current) {
  if(0 > current.ypos || current.ypos > h || 0 > current.xpos || current.xpos > w) return true;
  else return false;  
}

void createDartArray() {
  
}

void destroyDartArray() {
    
}

/*

You need to keep track of the key presses and releases yourself if you want ot chek on multiple keys. 

This is a simple example for the two specific keys. You can extend on this to have any number you want...

Code:
boolean[] keys;

void setup()
{
  size(200, 200);
  framerate(5);
  keys=new boolean[2];
  keys[0]=false;
  keys[1]=false;
}
void draw() 
{
  if( keys[0]) 
  {  
    print("1");
  }
  if( keys[1]) 
  {
    print("2");
  }
}

void keyPressed()
{
  if(key=='a')
    keys[0]=true;
  if(key=='s')
    keys[1]=true;
}

void keyReleased()
{
  if(key=='a')
    keys[0]=false;
  if(key=='s')
    keys[1]=false;
} 

*/