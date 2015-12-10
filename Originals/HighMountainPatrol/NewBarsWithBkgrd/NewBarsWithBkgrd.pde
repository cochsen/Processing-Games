float w, h, ow, oh, rw, rh;
float barWidth, barHeight, speedX, speedXdelta, ascentSpeed;
Manager manager;
Bar[] Bars;
BkObj[] BkObjs;

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
  background(#000028);
  speedX = speedXdelta = 1*w/ow;
  ascentSpeed = 0;
  barWidth=w/20;
  barHeight = h-h/6;
  Bars = new Bar[22];
  barHeight = h-h/6;
  manager = new Manager();
  for(int i=0; i<22; i++) 
  {
    Bars[i] = new Bar(i*barWidth, barHeight, speedX);  
  }
  BkObjs = new BkObj[7];
  for(int i=0; i<4; i++)
  {
    BkObjs[i] = new BkObj(int(random(3)), i*200*w/ow + random(200), h);  
  }
  for(int i=4; i<7; i++)
  {
    BkObjs[i] = new BkObj(int(random(3, 6)), i*200*w/ow + random(200), h);  
  }  
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