boolean counterOn;
int state, counter, score, heightCount, interval, intervalCounter;
float w, h, barWidth, speedX, speedY, gravity, barHeight;
float lastHeight, heightSum, momentum;
Player player;
ArrayList<Bar> Bars = new ArrayList<Bar>();
ArrayList<Boulder> Boulders = new ArrayList<Boulder>();
PImage img;
PFont zerovelo1, zerovelo2;

void setup()
{
  size(displayWidth, displayWidth, P2D);
  frameRate(60);
  background(#000028);
  w = width; h = height;
  score = 0; state = 0;
  barWidth = w/20; barHeight = h-h/6;
  speedX = w/40; speedY = w/4800;
  gravity = w/4800;
  heightCount = 1;
  lastHeight = h-h/6;
  heightSum = 1;
  momentum = 1;
  interval = int(random(w/speedX, 4*w/speedX));
  img = loadImage("rover-pixelated.png");
  player = new Player(img, w/6, h-h/6);
  zerovelo1 = createFont("zerovelo.ttf", h/10);
  zerovelo2 = createFont("zerovelo.ttf", h/24);
  textAlign(CENTER, CENTER);
  for(int i=0; i<20; i++) 
  {
    Bars.add(new Bar(float(i)*w/20, barHeight, speedX));  
    barHeight = h-h/6;
  }
}

void draw()
{
  background(#000028);
  for(int i=0; i<Bars.size(); i++)
  {
    if(Bars.get(i).xpos<0-2*barWidth)
    {
      barHeight = random(mouseY, h);
      Bars.add(new Bar(19*w/20, barHeight, speedX));
      Bars.remove(i);  
    }
    else
    {
      Bars.get(i).update(mouseX, mouseY, speedX);
      Bars.get(i).display();      
    }
  }
  if(state == 1)
  {
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
        println("Boulder removed");
      }
      else 
      {
        Boulders.get(i).update();      
        Boulders.get(i).display();      
      }
      detectCollisions();
    }
    player.explode();
    intervalCounter++;
    println("Interval: " + interval + ", Interval counter: " + intervalCounter);
    println("Boulders size: " + Boulders.size());    
  }
  else
  {
    fill(0,0,200);
    textFont(zerovelo1);
    text("Prominent\nMountain", w/2, h/2);
    if(mousePressed) state=1;
  }
  fill(200,0,0);
  textFont(zerovelo1);
  text(score, w/2, h/20);
}

void detectCollisions()
{
  for(int i=0; i<Boulders.size(); i++)
  {
    if(player.xpos>Boulders.get(i).xpos && player.xpos<Boulders.get(i).xend && player.ypos>Boulders.get(i).ypos && player.ypos<Boulders.get(i).yend)
    {
      counterOn = true;
      break;
    }
  }
}