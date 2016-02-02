/* 
 * Javascript directives for preloading images
 * @pjs preload="actor.png, DartPointUp.png, DartPointDown.png, DartPointLeft.png, DartPointRight.png";
 */

boolean collision;
int state, tmpOrientation, nextDart;
float w, h;
boolean[] keys;
int[] orientations = new int[8];
int[] dartRowSize = new int[8];
int[] startPos = new int[8];
PImage PlayerImg, dartImgUp, dartImgDown, dartImgLeft, dartImgRight, 
  tmpImage;
Manager manager;
Player player;
ArrayList<Dart> Darts = new ArrayList<Dart>();
  
void setup() 
{
  size(480, 480);
  frameRate(60);
  Manager manager = new Manager();
  manager.setupEnv();
  manager.setupControls();
  manager.setupDarts();
  manager.setupPlayer();
}

void draw() 
{
  background(0);
  drawGrid(); 
  if(state == 0)
  {
    player.update();
    player.display(); 
    Dart currentDart = Darts.get(nextDart);
    collision = detectCollision(currentDart);
    if(collision == true)
    {
      state=1;     
      Darts.remove(currentDart);
      createNewDarts();
      nextDart = int(random(Darts.size()));  
    }
    currentDart.out = outOfBounds(currentDart);
    if(currentDart.out == true) 
    {
      Darts.remove(currentDart);
      createNewDarts();
      nextDart = int(random(Darts.size()));
    }
    else {
      currentDart.move();
      currentDart.display();
    }       
  }   
  else
  {
    
    if(player.exploding == true)
    {
      player.update();
      player.display();
    }
    else {
      fill(225);
      textSize(h/8);
      textAlign(CENTER);
      text("From Four Sides", w/2, h/2);   
      textSize(h/16);
      text("Touch to Start", w/2, h/2 + h/8);
      if(keyPressed) state=0;
    }
  }
}

void drawGrid() 
{
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
void updateOrientations() 
{
  for(int i=0; i<orientations.length-1; i++) {
    int tmp = orientations[i+1];
    orientations[i] = tmp;
    orientations[orientations.length-1] = int(random(5));
  }
}

boolean outOfBounds (Dart current) 
{
  if(0 > current.ypos || current.ypos > h || 0 > current.xpos || current.xpos > w) return true;
  else return false;  
}

void createNewDarts() 
{
  int newOrientation = int(random(1,5));
  int newDartRowSize = 24*int(random(1, 17));
  int newDiff = int(random(480-newDartRowSize));
  int newStartPos = newDiff-(newDiff%24);  
  if(newOrientation == 1)
  {
    tmpImage = dartImgDown;
    Darts.add(new Dart(tmpImage, newOrientation, newStartPos, 0.0, newDartRowSize, 24));
  }
  else if(newOrientation == 2)
  {
    tmpImage = dartImgLeft;
    Darts.add(new Dart(tmpImage, newOrientation, w, newStartPos, 24, newDartRowSize));
  }
  else if(newOrientation == 3)
  {
    tmpImage = dartImgUp;
    Darts.add(new Dart(tmpImage, newOrientation, newStartPos, h, newDartRowSize, 24));
  }
  else
  {
    tmpImage = dartImgRight;
    Darts.add(new Dart(tmpImage, newOrientation, 0.0, newStartPos, 24, newDartRowSize)); 
  }  
}

boolean detectCollision(Dart currentDart) 
{
  if(player.xpos>currentDart.xpos && player.xpos<currentDart.xpos+currentDart.w && player.ypos>currentDart.ypos && player.ypos<currentDart.ypos+currentDart.h)
  {
    player.isExploding(true);
    return true;
  }
  else return false;
}
