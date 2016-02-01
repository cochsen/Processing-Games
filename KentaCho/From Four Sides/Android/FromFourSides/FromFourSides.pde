boolean collision;
int state, tmpOrientation, nextDart;
int dartWidth, dartHeight, playerWidth, playerHeight, dartSpeed;
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
  size(displayWidth, displayWidth, P2D);
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
        ActiveDarts.add(Darts.get(0));
        nextDart = 0;
        /*
        if (nextDart < 7)
          nextDart++; 
        else
          nextDart = 0;
        */
      }
      currentDart.out = outOfBounds(currentDart);
      if(currentDart.out == true) 
      {
        ActiveDarts.remove(currentDart);
        Darts.remove(nextDart);
        createNewDarts();
        /*
        if (nextDart < 7)
          nextDart++; 
        else
          nextDart = 0;
        */
      }
      else {
        currentDart.move();
        currentDart.display();
      }      
    } 
  }   
  else
  {
    
    if(player.exploding == true)
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
    player.exploding(true);
    return true;
  }
  else return false;
}