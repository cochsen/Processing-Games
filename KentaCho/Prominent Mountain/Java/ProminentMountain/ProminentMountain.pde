int heightCount;
float w, h, barWidth, speedX, speedY, gravity, barHeight;
float lastHeight, heightSum, momentum;
Player player;
ArrayList<Bar> Bars = new ArrayList<Bar>();

void setup()
{
  size(480, 480);
  frameRate(60);
  background(0);
  w=width; h=height;
  barWidth=w/20;
  barHeight = h-h/6;
  speedX = 12.0;
  speedY = 0.1;
  gravity = 0.1;
  heightCount = 1;
  lastHeight = h-h/6;
  heightSum = 1;
  momentum = 1;
  player = new Player(w/6, h-h/6);
  for(int i=0; i<24; i++) 
  {
    Bars.add(new Bar(float(i*24), barHeight, speedX));  
    barHeight = h-h/6;
  }
}

void draw()
{
  background(0);
  for(int i=0; i<Bars.size(); i++)
  {
    if(Bars.get(i).xpos<0-2*barWidth)
    {
      barHeight = random(mouseY, h);
      Bars.add(new Bar(22*24, barHeight, speedX));
      Bars.remove(i);  
    }
    else
    {
      Bars.get(i).update(mouseX, mouseY, speedX);
      Bars.get(i).display();      
    }
  }
  player.update();
  player.display();
}