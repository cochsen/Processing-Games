int state;
float w, h;
PImage PlayerImg, dartImg;
Player player;
//Dart dart;
ArrayList<Dart> TopRow1 = new ArrayList<Dart>(),  
  TopRow2 = new ArrayList<Dart>(),
  RightRow1 = new ArrayList<Dart>(), 
  RightRow2 = new ArrayList<Dart>(),
  BottomRow1 = new ArrayList<Dart>(), 
  BottomRow2 = new ArrayList<Dart>(),
  LeftRow1 = new ArrayList<Dart>(), 
  LeftRow2 = new ArrayList<Dart>();
  

void setup() {
  size(480, 480);
  w=width; h=height;
  background(0);
  state = 0;
  PlayerImg = loadImage("actor.png");
  dartImg = loadImage("dart.png");
  player = new Player(PlayerImg, w/2, h/2);
  for(int i=0; i<21; i++) {
    LeftRow1.add(new Dart(dartImg, 4, 0.0, float(i*24)));  
  }
  println(LeftRow1);
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
  for(int i=LeftRow1.size()-1; i>=0; i--) {
    Dart currentDart = LeftRow1.get(i);
    currentDart.move();
    currentDart.display();
  }
}

void drawGrid() {
  stroke(80,0,80);
  strokeWeight(5);  
  for(int i=0; i<10; i++) line(0, h/10+i*h/10, w, h/10+i*h/10);
  for(int j=0; j<10; j++) line(w/10+j*w/10, h, w/10+j*w/10, 0);    
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