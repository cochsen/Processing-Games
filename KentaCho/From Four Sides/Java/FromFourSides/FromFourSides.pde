int state, tmpOrientation;
float w, h;
int[] orientations = new int[8];
int[] numOfDarts = new int[8];
int[] startIndexes = new int[8];
PImage PlayerImg, dartImgUp, dartImgDown, dartImgLeft, dartImgRight, 
  tmpImage;
Player player;
/*
 * ArrayList todos:
 * generate random integers for orientations of n rows of darts x
 * generate random integers for number of darts in each row x
 * generate starting index for dart cluster x
 * method to destroy darts in ArrayList after passing screen x
 * method to recycle darts in each ArrayList
 * triggers for launch of row - timed or event-driven
 */
ArrayList<ArrayList<Dart>> rows = new ArrayList<ArrayList<Dart>>();
ArrayList<Dart> darts = new ArrayList<Dart>();

/*
ArrayList<Dart> 
  RowA = new ArrayList<Dart>(),
  RowB = new ArrayList<Dart>(),
  RowC = new ArrayList<Dart>(),
  RowD = new ArrayList<Dart>(),
  RowE = new ArrayList<Dart>(),
  RowF = new ArrayList<Dart>(),
  RowG = new ArrayList<Dart>(),
  RowH = new ArrayList<Dart>();
  */
  
void setup() {
  size(480, 480);
  w=width; h=height;
  background(0);
  state = 0;
  // orientation initial values
  for(int i=0; i<orientations.length; i++) {
    orientations[i] = int(random(5));  
  }
  for(int i=0; i<numOfDarts.length; i++) {
    numOfDarts[i] = int(random(17));
  }
  for(int i=0; i<startIndexes.length; i++) {
    startIndexes[i] = int(random(25-numOfDarts[i]));  
  }
  PlayerImg = loadImage("actor.png");
  dartImgUp = loadImage("DartPointUp.png");
  dartImgLeft = loadImage("DartPointLeft.png");
  dartImgDown = loadImage("DartPointDown.png");
  dartImgRight = loadImage("DartPointRight.png");
  player = new Player(PlayerImg, w/2, h/2);
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
    for(int j=0; j<orientations.length; j++) {
      if(tmpOrientation == 1)
        darts.add(new Dart(tmpImage, tmpOrientation, float(startIndexes[j])*24, 0.0));
      else if(tmpOrientation == 2)
        darts.add(new Dart(tmpImage, tmpOrientation, w, float(startIndexes[j])*24));
      else if(tmpOrientation == 3)
        darts.add(new Dart(tmpImage, tmpOrientation, float(startIndexes[j])*24, h));
      else
        darts.add(new Dart(tmpImage, tmpOrientation, 0.0, float(startIndexes[j]*24))); 
    }
    rows.add(darts);
  }
  
  /*
  for(int i=0; i<orientations.length; i++) {
    for(int j=0; j<  
  }
  for(int i=0; i<21; i++) {
    TopRowA.add(new Dart(dartImgDown, 1, float(i*24), 0.0));
    TopRowB.add(new Dart(dartImgDown, 1, float(i*24), 0.0));
    RightRowA.add(new Dart(dartImgRight, 2, w, float(i*24)));
    RightRowB.add(new Dart(dartImgRight, 2, w, float(i*24)));
    BottomRowA.add(new Dart(dartImgUp, 3, float(i*24), h));
    BottomRowA.add(new Dart(dartImgUp, 3, float(i*24), h));
    LeftRowA.add(new Dart(dartImgLeft, 4, 0.0, float(i*24)));  
    LeftRowB.add(new Dart(dartImgLeft, 4, 0.0, float(i*24)));     
  }
  */
}

void draw() {
  background(0);
  drawGrid();  
  player.display(); 
  if(keyPressed == true)
  {
    if(player.xpos>0) 
      if(key == 'a' || key == 'A') player.move(-8, 0);
    if(player.xpos<w-24)
      if(key == 'd' || key == 'D') player.move(8, 0);
    if(player.ypos>0)
      if(key == 'w' || key == 'W') player.move(0, -8);
    if(player.ypos<h-32)
      if(key == 's' || key == 'S') player.move(0, 8);    
  }
  for(int i=darts.size()-1; i>=0; i--) {
    Dart currentDart = darts.get(i);
    currentDart.out = outOfBounds(currentDart);
    if(currentDart.out == true) darts.remove(currentDart);
    else {
      currentDart.move();
      currentDart.display();
    }
  }
  if(frameCount%10 == 0) {
    updateOrientations();   
  }

}

void drawGrid() {
  stroke(80,0,80);
  strokeWeight(5);  
  for(int i=0; i<10; i++) line(0, h/10+i*h/10, w, h/10+i*h/10);
  for(int j=0; j<10; j++) line(w/10+j*w/10, h, w/10+j*w/10, 0);    
}

// generate random integers for orientations of n rows of darts
void updateOrientations() {
  for(int i=0; i<orientations.length-1; i++) {
    int tmp = orientations[i+1];
    orientations[i] = tmp;
    orientations[orientations.length-1] = int(random(5));
  }
}

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