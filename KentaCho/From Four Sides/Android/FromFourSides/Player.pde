class Player 
{
  boolean exploding;
  int counter, cellSize, columns, rows;
  float xpos, ypos, targetX, targetY, dx, dy, easing;  
  float[][] pxdir, pydir, pSizes, pScaling;
  PImage img;
  
  Player(PImage _img, float _x, float _y) 
  {
    img = _img;
    xpos = _x;
    ypos = _y;
    targetX = dx = xpos;
    targetY = dy = ypos;
    easing = 0.1*rw;
    exploding = false;
    counter = 0;
    cellSize = 4;
    columns = img.width / cellSize;
    rows = img.height / cellSize;
    pxdir = new float[columns][rows];
    pydir = new float[columns][rows];
    pSizes = new float[columns][rows];
    pScaling = new float[columns][rows];
    for(int i=0; i<columns; i++)
    {
      for(int j=0; j<rows; j++)
      {
        pxdir[i][j] = random(-10,10);
        pydir[i][j] = random(-10,10);
        pSizes[i][j] = cellSize;
        pScaling[i][j] = random(1);
      }
    }    
  }
  
  void display() 
  {
    if(exploding == false)
    {
      imageMode(CORNER);
      image(img, xpos, ypos, img.width*rw, img.height*rh);      
    }
    else
      explode(xpos, ypos);
  }
    
  void update() 
  {
    targetX = mouseX;
    dx = targetX - xpos;
    xpos += dx * easing;
    
    targetY = mouseY;
    dy = targetY - ypos;
    ypos += dy * easing;
  }  
  
  void move(float px, float py) 
  {
    xpos = xpos+px;
    ypos = ypos+py;
  }
  
  void exploding(boolean _exploding)
  {
    exploding = _exploding;
  }
  
  void trail() {
    // To do: graphical effect - trail behind player
  }
  
  void explode(float xpos, float ypos)
  {
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
            pSizes[i][j] = pSizes[i][j] + 1*pScaling[i][j];
          else
            pSizes[i][j] = pSizes[i][j] - 0.5*pScaling[i][j];
          pushMatrix();
          translate(x+pxdir[i][j], y+pydir[i][j]);
          fill(c, 204);
          noStroke();
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
      exploding = false;
      counter = 0;
      player.xpos=w/2;
      player.ypos=h/2;
      for(int i=0; i<columns; i++)
      {
        for(int j=0; j<rows; j++)
        {
          pxdir[i][j] = random(-10,10);
          pydir[i][j] = random(-10,10);
          pSizes[i][j] = cellSize;
        }
      } 
    }
  }    
}