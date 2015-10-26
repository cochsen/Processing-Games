int state;
float w, h;
int[] orientations = new int[16];
int[] numOfDarts = new int[16];
int[] startIndexes = new int[16];
PImage PlayerImg, dartImg;
Player player;
/*
 * ArrayList todos:
 * generate random integers for orientations of n rows of darts x
 * generate random integers for number of darts in each row x
 * generate starting index for dart cluster
 * method to destroy darts in ArrayList after passing screen
 * method to recycle darts in each ArrayList
 * triggers for launch of row - timed or event-driven
 */
ArrayList<Dart> 
  TopRowA = new ArrayList<Dart>(),  
  TopRowB = new ArrayList<Dart>(),
  RightRowA = new ArrayList<Dart>(), 
  RightRowB = new ArrayList<Dart>(),
  BottomRowA = new ArrayList<Dart>(), 
  BottomRowB = new ArrayList<Dart>(),
  LeftRowA = new ArrayList<Dart>(), 
  LeftRowB = new ArrayList<Dart>();
  

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
  dartImg = loadImage("dart.png");
  player = new Player(PlayerImg, w/2, h/2);
  for(int i=0; i<21; i++) {
    LeftRowA.add(new Dart(dartImg, 4, 0.0, float(i*24)));  
  }
  println(LeftRowA);
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
  for(int i=LeftRowA.size()-1; i>=0; i--) {
    Dart currentDart = LeftRowA.get(i);
    currentDart.move();
    currentDart.display();
  }
  if(frameCount%10 == 0) {
    updateOrientations();    
    print(orientations[0]);
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