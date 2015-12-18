boolean collisionCounterOn;
int interval, intervalCounter;
float w, h, ow, oh, rw, rh;
float barWidth, barHeight, speedX, speedXdelta, speedY, gravity, ascentSpeed;
Player player;
Bar[] Bars;
BkObj[] BkObjs;
Coin[] Coins;
Gem[] Gems;
Manager manager;
ArrayList<Boulder> Boulders = new ArrayList<Boulder>();

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
  frameRate(30);
  manager = new Manager();  
  manager.setupEnvironment();
  manager.setupBackgroundObjects();
  manager.setupBars();
  manager.setupPlayer();
  manager.setupPickups();
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
  manager.manageBoulders();
  manager.managePickups();
  player.update();
  player.display();
  manager.detectPickups();

  //println("player x: " + player.xpos + ", player y: " + player.ypos);
  //for(int i=0; i<PickupObjs.length; i++)
    //println("pickup " + i + " x: " + PickupObjs[i].xpos + "y: " + PickupObjs[i].ypos);
  //println("speedX: " + speedX);  
  println("interval: " + interval + "   , intervalCounter: " + intervalCounter + "   , Num of boulders: " + Boulders.size());
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

void detectCollisions()
{
  for(int i=0; i<Boulders.size(); i++)
  {
    if((player.xpos>Boulders.get(i).xpos && player.xpos<Boulders.get(i).xend && player.ypos>Boulders.get(i).ypos && player.ypos-27<Boulders.get(i).yend) || player.ypos>h)
    {
      collisionCounterOn = true;
      //speedX = 0;
      break;
    }
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