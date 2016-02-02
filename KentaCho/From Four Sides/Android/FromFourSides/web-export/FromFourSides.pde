/* 
 * Javascript directives for preloading images
 * @pjs preload="actor.png, DartPointUp.png, DartPointDown.png, DartPointLeft.png, DartPointRight.png";
 */ 
 
boolean collision;
int state, tmpOrientation, nextDart, counter;
int dartWidth, dartHeight, playerWidth, playerHeight, dartSpeed, dartSpeedScaled;
float w, h, rw, rh;
int[] orientations = new int[8];
int[] dartRowSize = new int[8];
int[] startPos = new int[8];
PImage PlayerImg, dartImgUp, dartImgDown, dartImgLeft, dartImgRight, 
  tmpImage, title;
Manager manager;
Player player;
ArrayList<Dart> Darts = new ArrayList<Dart>();
ArrayList<Dart> ActiveDarts = new ArrayList<Dart>();
  
void setup() 
{
  size(480, 480, P2D);
  //size(displayWidth, displayWidth, P2D);
  frameRate(60);
  Manager manager = new Manager();
  manager.setupEnv();
  manager.setupDarts();
  manager.setupPlayer();
}

void draw() 
{
  background(0);
  drawGrid(); 
  if (frameCount % 15 == 0) 
  {
    if (nextDart < 7)
      nextDart++; 
    else
      nextDart = 0;    
    ActiveDarts.add(Darts.get(nextDart));
    
  }  
  if (frameCount % 120 == 0) {
    counter++;  
  }
  if((counter > dartSpeed) && (dartSpeed < 16))
  {
    dartSpeed++;  
    dartSpeedScaled = int(dartSpeed*rw);
    println("dartSpeedScaled = " + dartSpeedScaled);
  }
  if(state == 0)
  {
    player.update();
    player.display();
    for (int i=0; i<ActiveDarts.size(); i++) {
      Dart currentDart = ActiveDarts.get(i);
      collision = detectCollision(currentDart);
      if(collision == true)
      {
        state=1;    
        Darts.remove(nextDart);
        createNewDarts();
        ActiveDarts.clear();
        if (nextDart > 0)
          ActiveDarts.add(Darts.get(nextDart-1));
        else
          ActiveDarts.add(Darts.get(7));
        nextDart = 0;
        counter = 0;
        dartSpeed = 5;
        dartSpeedScaled = int(dartSpeed*rw);
      }
      currentDart.out = outOfBounds(currentDart);
      if(currentDart.out == true) 
      {
        ActiveDarts.remove(currentDart);
        Darts.remove(nextDart);
        createNewDarts();
      }
      else {
        currentDart.move();
        currentDart.display();
      }      
    } 
  }   
  else
  {
    
    if(player.isExploding == true)
    {
      player.display();
    }
    else {
      image(title,0, h/4, title.width*rw, title.height*rh);
      if(mousePressed) 
      {
        state=0;
        println("Darts size: " + Darts.size());
      }
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
    Darts.add(new Dart(tmpImage, newOrientation, newStartPos, 0.0, newDartRowSize, dartWidth));
  }
  else if(newOrientation == 2)
  {
    tmpImage = dartImgLeft;
    Darts.add(new Dart(tmpImage, newOrientation, w, newStartPos, dartWidth, newDartRowSize));
  }
  else if(newOrientation == 3)
  {
    tmpImage = dartImgUp;
    Darts.add(new Dart(tmpImage, newOrientation, newStartPos, h, newDartRowSize, dartWidth));
  }
  else
  {
    tmpImage = dartImgRight;
    Darts.add(new Dart(tmpImage, newOrientation, 0.0, newStartPos, dartWidth, newDartRowSize)); 
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
      nImg = round(w/dartWidth);
    }
    else 
    {
      nImg = round(h/dartWidth);
    }
  }
  
  void display() 
  {
    imageMode(CORNER);
    if(orientation == 1 || orientation == 3)
    {
      for(int i=0; i<nImg; i++) 
      {
        image(img, xpos+i*dartWidth, ypos, dartWidth, dartWidth);         
      }  
      /* uncomment to display collision boundary
      stroke(225);
      noFill();
      rectMode(CORNER);
      rect(xpos, ypos, w, h); 
      */

    }
    else 
    {
      for(int i=0; i<nImg; i++)
      {
        image(img, xpos, ypos+i*dartWidth, dartWidth, dartWidth);  
      }
      /* uncomment to display collision boundary
      stroke(225);
      noFill();      a
      rectMode(CORNER);
      rect(xpos, ypos, w, h); 
      */
    }
    
  }
  
  void move() 
  {
    switch(orientation) {
      case 1:
        ypos += dartSpeedScaled;
        break;
      case 2: 
        xpos -= dartSpeedScaled;
        break;
      case 3: 
        ypos -= dartSpeedScaled;
        break;
      case 4:
        xpos += dartSpeedScaled;
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
    rw=w/480; rh=h/480;
    dartWidth = int(24*rw);
    dartHeight = int(24*rh);
    playerWidth = int(20*rw);
    playerHeight = int(28*rh);
    dartSpeed = 5;
    dartSpeedScaled = int(dartSpeed*rw);
    background(0);
    state = 1;
    counter = 0;
    collision=false;
    title = loadImage("title.png");
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
      dartRowSize[i] = dartWidth*int(random(1, 17));
    }
    // some index to start the row/col that will fit all the darts on the screen
    for(int i=0; i<startPos.length; i++) 
    {
      int diff = int(random(width-dartRowSize[i]));
      startPos[i] = diff-(diff%dartWidth);  
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
        Darts.add(new Dart(tmpImage, orientations[i], startPos[i], 0.0, dartRowSize[i], dartWidth));
      }
      else if(orientations[i] == 2)
      {
        tmpImage = dartImgLeft;
        Darts.add(new Dart(tmpImage, orientations[i], w, startPos[i], dartWidth, dartRowSize[i]));
      }
      else if(orientations[i] == 3)
      {
        tmpImage = dartImgUp;
        Darts.add(new Dart(tmpImage, orientations[i], startPos[i], h, dartRowSize[i], dartWidth));
      }
      else
      {
        tmpImage = dartImgRight;
        Darts.add(new Dart(tmpImage, orientations[i], 0.0, startPos[i], dartWidth, dartRowSize[i])); 
      }
    }
    // pick first dart to appear at random
    nextDart = 0;
    ActiveDarts.add(Darts.get(nextDart));
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
  float xpos, ypos, targetX, targetY, dx, dy, easing;  
  float[][] pxdir, pydir, pSizes, pScaling;
  PImage img;
  
  Player(PImage _img, float _x, float _y) 
  {
    img = _img;
    xpos = _x;
    ypos = _y;
    targetX = dx = xpos;
    targetY = dy = ypos;
    easing = 0.1*rw;
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
      image(img, xpos, ypos, img.width*rw, img.height*rh);      
    }
    else
      explode(xpos, ypos);
  }
    
  void update() 
  {
    targetX = mouseX;
    dx = targetX - xpos;
    xpos += dx * easing;
    
    targetY = mouseY;
    dy = targetY - ypos;
    ypos += dy * easing;
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
          fill(c);
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

