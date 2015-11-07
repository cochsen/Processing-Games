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
      //text("Game Over", w/2, h/2);
      break;
    }
  }
}
class Bar
{
  float xpos, ypos, barWidth, barHalfWidth, barHeight, mousePosX, mousePosY, speed;
  
  Bar(float _x, float _y, float _s)
  {
    xpos = _x;
    ypos = _y;
    speed = _s;
    barWidth = w/20;
    barHalfWidth = barWidth/2;
    barHeight = 0;
    mousePosX = 0;
    mousePosY = w/6;
  }
  
  void update(float _x, float _y, float _s)
  {
    speed = _s;
    xpos = xpos -= speed;
    mousePosX = _x;
    if(xpos>mousePosX-barHalfWidth && xpos<mousePosX+barHalfWidth)
    {
      ypos = _y;
    }
    if(xpos>w/6-20 && xpos<w/6+20)
    {
      if(player.ypos<ypos)
      {
        player.ypos += speedY - 0.3*momentum;
        speedY += gravity;
      }
      else
      {
        player.ypos = ypos;         
        speedY = 1;
      }
    }
  }
  
  void display()
  {
    rectMode(CORNER);
    fill(225);   
    rect(xpos-barHalfWidth, ypos, barWidth, h-ypos);
  }
}
class Boulder
{
    
  float xpos, ypos, boulderW, boulderH, xend, yend;
  
  Boulder(float _xpos, float _ypos)
  {
    xpos = _xpos;
    ypos = _ypos;
    boulderW = 440;
    boulderH = 120;
    xend = xpos+boulderW;
    yend = ypos+boulderH;
  }
  
  void update()
  {
    xpos -= speedX; 
    xend = xpos+boulderW;
  }
  
  void display()
  {
    rectMode(CORNER);
    fill(200);
    rect(xpos, ypos, boulderW, boulderH);
  }
}
class Player
{
  boolean exploding;
  int counter;
  int cellSize;
  int columns, rows;
  float xpos, ypos;
  float[][] pxdir, pydir, pSizes, pScaling;
  PImage img;
  
  Player(PImage _img, float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
    img = _img;
    
    // attributes associated with explosion method
    exploding = false;
    counter = 0;
    cellSize = 4;
    columns = img.width / cellSize;
    rows = img.height / cellSize;
    pxdir = new float[columns][rows];
    pydir = new float[columns][rows];
    pSizes = new float[columns][rows];
    pScaling = new float[columns][rows];      
    
    // initialization of arrays
    for(int i=0; i<columns; i++)
    {
      println();
      for(int j=0; j<rows; j++)
      {
        pxdir[i][j] = random(-10,10);
        pydir[i][j] = random(-10,10);
        pSizes[i][j] = cellSize;
        pScaling[i][j] = random(1);
      }
    }       
  }
  
  void update() 
  {
    if(exploding == false && frameCount%((barWidth/speedX)) == 0)
    {
      if(ypos<lastHeight)
      {
        heightSum += lastHeight-ypos;
        momentum = 0.5*heightSum/heightCount;  
        heightCount++;
        lastHeight = ypos;
      }
      else if(ypos>lastHeight)
      {
        heightSum = 1;
        heightCount = 1;
        lastHeight = ypos;
        momentum = 1;
      }
    }    
    println("momentum: " + momentum + ", count: " + heightCount);
  }
  
  void display()
  {
    if(exploding == false)
    {
      rectMode(CENTER);
      image(img, xpos, ypos, 40, 40);
    }
  }

  void explode()
  {
    exploding=true;
    if(counter<frameRate/2)
    {
      for(int i=0; i<columns; i++)
      {
        for(int j=0; j<rows; j++)
        {
          float x = i*cellSize+cellSize/2;
          float y = j*cellSize+cellSize/2;
          float loc = x+y*img.width;
          color c = img.pixels[int(loc)];
          if(counter<frameRate/4)
            pSizes[i][j] = pSizes[i][j] + 0.5*pScaling[i][j];
          else
            pSizes[i][j] = pSizes[i][j] - 0.5*pScaling[i][j];
          pushMatrix();
          translate(x+pxdir[i][j], y+pydir[i][j]);
          fill(c, 204);
          //noStroke();
          rectMode(CENTER);
          rect(xpos-img.width/2, ypos-img.height/2, pSizes[i][j], pSizes[i][j]);
          popMatrix();
          pxdir[i][j] = pxdir[i][j] + 0.1*pxdir[i][j];
          pydir[i][j] = pydir[i][j] + 0.1*pydir[i][j];        
        }
      }
      counter++;
    }
    else
    {
      state = 0;
      exploding = false;
      counter = 0;
      cellSize = 4;
      for(int i=0; i<columns; i++)
      {
        println();
        for(int j=0; j<rows; j++)
        {
          pxdir[i][j] = random(-10,10);
          pydir[i][j] = random(-10,10);
          pSizes[i][j] = cellSize;
        }
      }
      Boulders.clear();  
      speedX = 12.0;
      speedY = 0.1;
      gravity = 0.1;
      heightCount = 1;
      lastHeight = h-h/6;
      heightSum = 1;
      momentum = 1;
    }
  }    
}

