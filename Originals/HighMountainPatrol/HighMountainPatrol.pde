boolean counterOn;
int state, heightCount, interval, intervalCounter, counter, score;
float w, h, barWidth, speedX, speedY, ascentSpeed, gravity, barHeight;
float lastHeight, heightSum, momentum;
Player player;
ArrayList<Bar> Bars = new ArrayList<Bar>();
ArrayList<Boulder> Boulders = new ArrayList<Boulder>();
PImage img;
PFont zerovelo, zeroveloSmall;

void settings()
{
  size(displayWidth,displayWidth,P2D);  
  w = h = displayWidth;
}

void setup()
{
  frameRate(60);
  background(#000028);
  score = 0;
  state = 0;
  barWidth=w/20;
  barHeight = h-h/6;
  speedX = 5;
  speedY = 0.002*w;
  gravity = 0.1;
  heightCount = 1;
  lastHeight = h-h/6;
  heightSum = 1;
  momentum = 1;
  interval = int(random(w/speedX, 4*w/speedX));
  img = loadImage("rover-pixelated.png");
  player = new Player(img, w/6, h-h/6);
  zerovelo = createFont("zerovelo.ttf", h/10);
  zeroveloSmall = createFont("zerovelo.ttf", h/24);
  textAlign(CENTER, CENTER);
  for(int i=0; i<22; i++) 
  {
    Bars.add(new Bar(i*w/20, barHeight, speedX));  
    barHeight = h-h/6;
  }
}

void draw()
{
  background(#000028);
  if(frameCount % 360 == 0)
    changeAscent(int(random(100)));
  for(int i=0; i<Bars.size(); i++)
  {
    if(Bars.get(i).xpos<0-2*barWidth)
    {
      barHeight = random(mouseY, h);
      Bars.add(new Bar(w, barHeight, speedX));
      Bars.remove(i);  
    }
    else
    {
      Bars.get(i).update(mouseX, mouseY, speedX, ascentSpeed);
      Bars.get(i).display();      
    }
  }  
  if(state == 1)
  {
    player.update();
    //println("Player xpos: " + player.xpos + ", Player ypos: " + player.ypos);
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
        //println("Boulder xpos: " + Boulders.get(i).xpos + " Boulder ypos: " + Boulders.get(i).ypos + " Boulder xend: " + Boulders.get(i).xend + " Boulder yend: " + Boulders.get(i).yend);
        Boulders.get(i).display();      
      }
      detectCollisions();
    }
    player.explode();
    intervalCounter++;
    //println("player.exploding: " + player.exploding + "counterOn: " + counterOn);
    println("Momentum: " + momentum);
    println("Speed: " + speedX);
  }
  else
  {
    fill(0,0,200);
    textFont(zerovelo);
    text("Prominent\nMountain", w/2, h/2);  
    if(mousePressed) 
      if(player.ypos<h)
        state = 1;
      else
        state = 0;
  }
  fill(200,0,0);
  textFont(zeroveloSmall);
  text(score, w/2, h/20);
}

void detectCollisions()
{
  for(int i=0; i<Boulders.size(); i++)
  {
    if((player.xpos>Boulders.get(i).xpos && player.xpos<Boulders.get(i).xend && player.ypos>Boulders.get(i).ypos && player.ypos-27<Boulders.get(i).yend) || player.ypos>h)
    {
      counterOn = true;
      //speedX = 0;
      break;
    }

    /*
    if(player.ypos>h)
    {
      counterOn = false;
      state = 0;
      counter = 0;
      Boulders.clear();  
      speedX = 5.0;
      speedY = 0.1;
      gravity = 0.1;
      heightCount = 1;
      lastHeight = h-h/6;
      heightSum = 1;
      momentum = 1;
      score = 0;
    }
    */
  }
}

void changeAscent(int change)
{
    if(change<76)
      ascentSpeed = random(0, 2.5);
    else
      ascentSpeed = random(0, 1);
}