float w, h, ow, oh, rw, rh;
float barWidth, barHeight, speedX, speedXdelta, speedY, gravity, ascentSpeed;
Player player;
Bar[] Bars;
BkObj[] BkObjs;
Manager manager;


void settings()
{
  size(displayWidth,displayWidth,P2D);  
  w = h = displayWidth;
  ow = oh = 480;
  rw = w/480;
  rh = h/480;
}

void setup()
{
  frameRate(60);
  manager = new Manager();  
  manager.setupEnvironment();
  manager.setupBackgroundObjects();
  manager.setupBars();
  manager.setupPlayer();
}

void draw()
{
  if(frameCount % 360 == 0)
    manager.changeAscent(int(random(100)));
  if(frameCount % 30 == 0)
    if(abs(speedX - speedXdelta) > 1.0)
    {
      speedXdelta = speedX;
      realign();
    }
  manager.manageBackgrounds();
  manager.manageBars();
  player.update();
  player.display();
}

void realign()
{
  Bars[0].xpos = round(Bars[0].xpos);
  for(int i=1; i<22; i++) 
  {
    if(Bars[i].xpos>Bars[0].xpos)
      Bars[i].xpos = Bars[0].xpos + i*barWidth;
    else
      Bars[i].xpos = Bars[0].xpos - (22-i)*barWidth;
  }
} 

// test
void keyPressed()
{
  if(key == 'a')
  {
    speedX += 0.2;  
    println("Speed x: " + speedX);
  }
  if(key == 's')
  {
    speedX -= 0.2;
    println("Speed x: " + speedX);
  }
  if(key == 'r')
    realign();
}