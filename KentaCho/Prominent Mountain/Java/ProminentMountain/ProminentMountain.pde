float w, h, barWidth;
Player player;
//Bar testBar;
ArrayList<Bar> Bars = new ArrayList<Bar>();

void setup()
{
  size(480, 480);
  background(0);
  w=width; h=height;
  barWidth=w/20;
  player = new Player(w/6, h/2);
  //testBar = new Bar(460, 60);
  for(int i=0; i<72; i++) 
    Bars.add(new Bar(float(i*24), random(0, h)));  
}

void draw()
{
  background(0);
  for(int i=0; i<Bars.size(); i++)
  {
    if(Bars.get(i).xpos<0-barWidth)
    {
      Bars.add(new Bar(71*24, random(0, h)));
      Bars.remove(i);  
    }
    else
    {
      Bars.get(i).update(mouseY);
      Bars.get(i).display();      
    }
  }
  player.update(w/6, mouseY);
  player.display();
  //testBar.update(mouseY);
  //testBar.display();
}