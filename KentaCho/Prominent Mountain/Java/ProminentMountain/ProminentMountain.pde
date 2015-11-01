float w, h, barWidth, speed, barHeight;
Player player;
//Bar testBar;
ArrayList<Bar> Bars = new ArrayList<Bar>();

void setup()
{
  size(480, 480);
  frameRate(60);
  background(0);
  w=width; h=height;
  barWidth=w/20;
  barHeight = h-h/6;
  speed = 12.0;
  player = new Player(w/6, h-h/6);
  //testBar = new Bar(460, 60);
  for(int i=0; i<24; i++) 
  {
    Bars.add(new Bar(float(i*24), barHeight, speed));  
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
      Bars.add(new Bar(22*24, barHeight, speed));
      Bars.remove(i);  
    }
    else
    {
      Bars.get(i).update(mouseX, mouseY, speed);
      Bars.get(i).display();      
    }
  }
  player.display();
  //testBar.update(mouseY);
  //testBar.display();
}