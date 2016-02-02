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
class Dart 
{
  
  PImage img;
  float xpos, ypos, w, h;
  int orientation, nImg;
  boolean out;
  
  Dart(PImage _img, int _orientation, float _x, float _y, float _w, float _h) 
  {
    img = _img;
    orientation = _orientation;
    xpos = _x;
    ypos = _y;
    w = _w;
    h = _h;
    out = false;
    if(orientation == 1 || orientation == 3)
    {
      nImg = int(w/img.width);
    }
    else 
    {
      nImg = int(h/img.height);
    }
  }
  
  void display() 
  {
    imageMode(CORNER);
    if(orientation == 1 || orientation == 3)
    {
      for(int i=0; i<nImg; i++) 
      {
        image(img, xpos+i*24, ypos);  
      }  
    }
    else 
    {
      for(int i=0; i<nImg; i++)
      {
        image(img, xpos, ypos+i*24);  
      }
    }
    
  }
  
  void move() 
  {
    switch(orientation) {
      case 1:
        ypos += 5;
        break;
      case 2: 
        xpos -= 5;
        break;
      case 3: 
        ypos -= 5;
        break;
      case 4:
        xpos += 5;
        break;
      default:
        break;
    }
  }

}
class Manager
{
  void setupEnv()
  {
    w=width; h=height;
    background(0);
    state = 0;
    collision=false;
  }
  
  void setupControls()
  {
    keys = new boolean[4];  // mapping: [d,a,s,w]
    for(int i=0; i<keys.length; i++) keys[i] = false;  
  }
  
  void setupDarts()
  {
    // orientation initial values (determines starting side and direction of movement)
    for(int i=0; i<orientations.length; i++) 
    {
      orientations[i] = int(random(1,5));  
    }
    // initial number of darts for first 8 rows/cols
    for(int i=0; i<dartRowSize.length; i++) 
    {
      dartRowSize[i] = 24*int(random(1, 17));
    }
    // some index to start the row/col that will fit all the darts on the screen
    for(int i=0; i<startPos.length; i++) 
    {
      int diff = int(random(480-dartRowSize[i]));
      startPos[i] = diff-(diff%24);  
    }
    dartImgUp = loadImage("DartPointUp.png");
    dartImgLeft = loadImage("DartPointLeft.png");
    dartImgDown = loadImage("DartPointDown.png");
    dartImgRight = loadImage("DartPointRight.png");
    // add 8 ArrayLists of darts to ArrayList rows
    // select image based on orientation
    for(int i=0; i<orientations.length; i++) 
    {
      // create dart with image and positions based on orientation
      if(orientations[i] == 1)
      {
        tmpImage = dartImgDown;
        Darts.add(new Dart(tmpImage, orientations[i], startPos[i], 0.0, dartRowSize[i], 24));
      }
      else if(orientations[i] == 2)
      {
        tmpImage = dartImgLeft;
        Darts.add(new Dart(tmpImage, orientations[i], w, startPos[i], 24, dartRowSize[i]));
      }
      else if(orientations[i] == 3)
      {
        tmpImage = dartImgUp;
        Darts.add(new Dart(tmpImage, orientations[i], startPos[i], h, dartRowSize[i], 24));
      }
      else
      {
        tmpImage = dartImgRight;
        Darts.add(new Dart(tmpImage, orientations[i], 0.0, startPos[i], 24, dartRowSize[i])); 
      }
    }
    // pick first dart to appear at random
    nextDart = int(random(Darts.size()));
  }
  
  void setupPlayer()
  {
    PlayerImg = loadImage("actor.png");
    // initialize player in the middle of the board
    player = new Player(PlayerImg, w/2, h/2);    
  }
}
class Player 
{
  boolean exploding;
  int counter, cellSize, columns, rows;
  float xpos, ypos, speed, diagSpeed;  
  float[][] pxdir, pydir, pSizes, pScaling;
  PImage img;
  
  Player(PImage _img, float _x, float _y) 
  {
    img = _img;
    xpos = _x;
    ypos = _y;
    speed = 8;
    diagSpeed = sqrt(speed/2); 
    exploding = false;
    counter = 0;
    cellSize = 4;
    columns = img.width / cellSize;
    rows = img.height / cellSize;
    pxdir = new float[columns][rows];
    pydir = new float[columns][rows];
    pSizes = new float[columns][rows];
    pScaling = new float[columns][rows];
    for(int i=0; i<columns; i++)
    {
      for(int j=0; j<rows; j++)
      {
        pxdir[i][j] = random(-10,10);
        pydir[i][j] = random(-10,10);
        pSizes[i][j] = cellSize;
        pScaling[i][j] = random(1);
      }
    }    
  }
  
  void display() 
  {
    if(exploding == false)
    {
      imageMode(CORNER);
      image(img, xpos, ypos);      
    }
    else
      explode(xpos, ypos);
  }
    
  void update() 
  {
    if(exploding == false) {
      if(keys[0] == true) 
        if(player.xpos<w-24) player.move(8,0);
      if(keys[1] == true) 
        if(player.xpos>0) player.move(-8,0);
      if(keys[3] == true) 
        if(player.ypos<h-32) player.move(0,8);
      if(keys[2] == true) 
        if(player.ypos>0) player.move(0,-8);
      if(keys[1] == true && keys[3] == true) 
        if(player.xpos>0 && player.ypos<h-32) player.move(-diagSpeed,diagSpeed);
      if(keys[1] == true && keys[2] == true)
        if(player.xpos>0 && player.ypos>0) player.move(-diagSpeed,-diagSpeed);  
      if(keys[0] == true && keys[3] == true)
        if(player.xpos<w-24 && player.ypos<h-32) player.move(diagSpeed,diagSpeed);  
      if(keys[0] == true && keys[2] == true) 
        if(player.xpos<w-24 && player.ypos>0) player.move(diagSpeed,-diagSpeed);       
    }
  }  
  
  void move(float px, float py) 
  {
    xpos = xpos+px;
    ypos = ypos+py;
  }
  
  void isExploding(boolean _exploding)
  {
    exploding = _exploding;
  }
  
  void trail() {
    // To do: graphical effect - trail behind player
  }
  
  void explode(float xpos, float ypos)
  {
    if(counter<frameRate/2)
    {
      for(int i=0; i<columns; i++)
      {
        for(int j=0; j<rows; j++)
        {
          float x = i*cellSize+cellSize/2;
          float y = j*cellSize+cellSize/2;
          float loc = x+y*img.width;
          color c = img.pixels[int(loc)];
          if(counter<frameRate/4)
            pSizes[i][j] = pSizes[i][j] + 1*pScaling[i][j];
          else
            pSizes[i][j] = pSizes[i][j] - 0.5*pScaling[i][j];
          pushMatrix();
          translate(x+pxdir[i][j], y+pydir[i][j]);
          fill(c, 204);
          noStroke();
          rectMode(CENTER);
          rect(xpos-img.width/2, ypos-img.height/2, pSizes[i][j], pSizes[i][j]);
          popMatrix();
          pxdir[i][j] = pxdir[i][j] + 0.1*pxdir[i][j];
          pydir[i][j] = pydir[i][j] + 0.1*pydir[i][j];        
        }
      }
      counter++;
    }
    else
    {
      exploding = false;
      counter = 0;
      player.xpos=w/2;
      player.ypos=h/2;
      for(int i=0; i<columns; i++)
      {
        for(int j=0; j<rows; j++)
        {
          pxdir[i][j] = random(-10,10);
          pydir[i][j] = random(-10,10);
          pSizes[i][j] = cellSize;
        }
      }    
    }
  }    
}

