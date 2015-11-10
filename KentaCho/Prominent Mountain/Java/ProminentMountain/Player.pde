class Player
{
  boolean exploding;
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
    cellSize = 8;
    columns = img.width / cellSize;
    rows = img.height / cellSize;
    pxdir = new float[columns][rows];
    pydir = new float[columns][rows];
    pSizes = new float[columns][rows];
    pScaling = new float[columns][rows];      
    
    // initialization of arrays
    for(int i=0; i<columns; i++)
    {
      //println();
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
      if(ypos<lastHeight && momentum<20)
      {
        heightSum += lastHeight-ypos;
        momentum = 20;  
        heightCount++;
        lastHeight = ypos;
      }
      else if(ypos<lastHeight)
      {
        heightSum += lastHeight-ypos;
        momentum = 0.5*heightSum/heightCount;  
        heightCount++;
        lastHeight = ypos;          
      }
      else if(ypos == lastHeight || ypos>lastHeight)
      {
        heightSum = 1;
        heightCount = 1;
        lastHeight = ypos;
        momentum = 1;
        speedX+=0.1;
      }
    }    
    //println("momentum: " + momentum + ", count: " + heightCount);
  }
  
  void display()
  {
    if(state == 1 && counterOn == false)
    {
      rectMode(CORNER);
      if(lastHeight-ypos>h/20) // momentum>5
      {
        pushMatrix();
        translate(xpos-40, ypos-40);
        rotate(-PI/3.0);
        image(img, 0, 0, 40, 40);
        popMatrix();
      }
      else
        image(img, xpos-40, ypos-40, 40, 40);
    }
  }

  void explode()
  {
    if(counterOn && counter<frameRate/2)
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
            pSizes[i][j] = pSizes[i][j] + 3*pScaling[i][j];
          else
            pSizes[i][j] = pSizes[i][j] - 3*pScaling[i][j];
          pushMatrix();
          translate(x+pxdir[i][j], y+pydir[i][j]);
          fill(c, 204);
          rectMode(CENTER);
          rect(xpos-img.width/2, ypos-img.height/2, pSizes[i][j], pSizes[i][j]);
          popMatrix();
          //text("Game Over", w/2, h/2);
          pxdir[i][j] = pxdir[i][j] + 0.1*pxdir[i][j];
          pydir[i][j] = pydir[i][j] + 0.1*pydir[i][j];        
        }
      }
      counter++;
    }
    else if(counterOn)
    {
      counterOn = false;
      exploding = false;
      state = 0;
      counter = 0;
      cellSize = 4;
      for(int i=0; i<columns; i++)
      {
        //println();
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