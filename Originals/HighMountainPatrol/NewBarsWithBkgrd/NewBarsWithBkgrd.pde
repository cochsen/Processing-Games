float w, h, ow, oh;
float barWidth, barHeight, speedX, ascentSpeed;
Bar[] Bars;
BkObj[] BkObjs;

void settings()
{
  size(displayWidth,displayWidth,P2D);  
  w = h = displayWidth;
  ow = oh = 480;
}

void setup()
{
  frameRate(60);
  background(#000028);
  speedX = 1*w/ow;
  ascentSpeed = 0;
  barWidth=w/20;
  barHeight = h-h/6;
  Bars = new Bar[22];
  barHeight = h-h/6;
  for(int i=0; i<22; i++) 
  {
    Bars[i] = new Bar(i*barWidth, barHeight, speedX);  
  }
  BkObjs = new BkObj[6];
  for(int i=0; i<6; i++)
  {
    BkObjs[i] = new BkObj(int(random(3)), i*200*w/ow + random(200), h);  
  }
}

void draw()
{
  background(#000028);
  for(int i=0; i<BkObjs.length; i++)
  {
    BkObjs[i].update(speedX, ascentSpeed);
    BkObjs[i].display();
  }  
  // Bars
  for(int i=0; i<Bars.length; i++)
  {
    if(Bars[i].xpos<0-2*barWidth)
    {
      barHeight = random(mouseY, h);
      Bars[i].xpos = w;
    }
    Bars[i].update(mouseX, mouseY, speedX, ascentSpeed);
    Bars[i].display(); 
  }    
}

void changeAscent(int change)
{
    if(change<76)
      ascentSpeed = h/oh*random(0, 5);
    else
      ascentSpeed = -h/oh*random(0, 2.5);
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