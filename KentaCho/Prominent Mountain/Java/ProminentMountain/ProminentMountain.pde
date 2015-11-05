/*  States
 *  0 - Title screen state, touch activates state 1
 *  1 - Game state, collision activates state 0
 */

int state, heightCount, interval, intervalCounter;
float w, h, barWidth, speedX, speedY, gravity, barHeight;
float lastHeight, heightSum, momentum;
Player player;
ArrayList<Bar> Bars = new ArrayList<Bar>();
ArrayList<Boulder> Boulders = new ArrayList<Boulder>();
PImage img;
PFont zerovelo;

void setup()
{
  size(480, 480);
  frameRate(60);
  background(0);
  w=width; h=height;
  state = 0;
  barWidth=w/20;
  barHeight = h-h/6;
  speedX = 12.0;
  speedY = 0.1;
  gravity = 0.1;
  heightCount = 1;
  lastHeight = h-h/6;
  heightSum = 1;
  momentum = 1;
  interval = int(random(w/speedX, 4*w/speedX));
  img = loadImage("temp-moon-rover.png");
  player = new Player(img, w/6, h-h/6);
  zerovelo = createFont("zerovelo.ttf", 32);
  textFont(zerovelo);
  textAlign(CENTER, CENTER);
  for(int i=0; i<24; i++) 
  {
    Bars.add(new Bar(float(i*24), barHeight, speedX));  
    barHeight = h-h/6;
  }
}

void draw()
{
  background(0);
  if(state == 1)
    {
    for(int i=0; i<Bars.size(); i++)
    {
      if(Bars.get(i).xpos<0-2*barWidth)
      {
        barHeight = random(mouseY, h);
        Bars.add(new Bar(21*24, barHeight, speedX));
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
    rectMode(CORNER);
    fill(200);
    if(intervalCounter>=interval)
    {
      Boulders.add(new Boulder(w, random(-10, 3*h/4)));
      interval = int(random(w/speedX, 4*w/speedX));
      intervalCounter = 0;
    }
    for(int i=0; i<Boulders.size(); i++)
    {
      if(Boulders.get(i).xend<0-2*barWidth)
      {
        Boulders.remove(i);  
      }
      else 
      {
        Boulders.get(i).update();      
        Boulders.get(i).display();      
      }
      detectCollisions();
    }
    intervalCounter++;
  }
  else
  {
    text("Prominent\nMountain", w/2, h/2);  
    if(mousePressed) state = 1;
  }
}

void detectCollisions()
{
  for(int i=0; i<Boulders.size(); i++)
  {
    if(player.xpos>Boulders.get(i).xpos && player.xpos<Boulders.get(i).xend && player.ypos>Boulders.get(i).ypos && player.ypos<Boulders.get(i).yend)
    {
      player.explode();
      //speedX = 0;
      text("Game Over", w/2, h/2);
    }
  }
}