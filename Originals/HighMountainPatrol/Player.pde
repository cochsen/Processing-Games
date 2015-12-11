class Player
{
  boolean snapshot, exploding;
  int cellSize;
  int columns, rows;
  float xpos, ypos, xoffset, yoffset;
  float[][] pxdir, pydir, pSizes, pScaling;
  color c1, c2, window;
  PImage img;
  
  Player(float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
    xoffset = 24 * w/ow;
    yoffset = 15 * h/oh;  
    
    // attributes associated with explosion method
    snapshot = false;
    exploding = false;
    counter = 0;
    cellSize = 8;
    columns = int(xoffset / cellSize);
    rows = int(yoffset / cellSize);
    pxdir = new float[columns][rows];
    pydir = new float[columns][rows];
    pSizes = new float[columns][rows];
    pScaling = new float[columns][rows];      
    
    // initialization of arrays for explosion
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
  
  void update() 
  {
    if(exploding == false) // && frameCount%5 == 0
    {
      if(ypos<lastHeight && momentum>=20)
      {
        heightSum += lastHeight-ypos;
        momentum = 20;  
        heightCount++;
        lastHeight = ypos;
        speedX -= 0.01*(w/ow); // *(lastHeight-ypos);
      }
      else if(ypos<lastHeight)
      {
        heightSum += lastHeight-ypos;
        // calculate momentum
        momentum += 0.5; // 0.5*heightSum/heightCount;  
        heightCount++;
        lastHeight = ypos;          
        speedX -= 0.01*(w/ow); // *(lastHeight-ypos);
      }
      else if((ypos == lastHeight) || (ypos>lastHeight))
      {
        heightSum = 1;
        heightCount = 1;
        lastHeight = ypos;
        momentum = 1;
        speedX += 0.01*w/ow;
      }
    }
  }
  
  void display()
  {
    if(state == 1 && counterOn == false)
    {
      rectMode(CORNER);
      if(lastHeight-ypos>h/20) // momentum>5
      {
        pushMatrix();
        translate(xpos, ypos);
        rotate(-PI/3.0);
        drawRover();
        //image(img, 0, 0, imagew, imageh);
        popMatrix();
      }
      else
        drawRover();
        if(snapshot == false)
          getImage();
        //image(img, xpos-w/ow*24, ypos-h/oh*15, 40, 27);
    }
  }

  void drawRover()
  {
    c1 = color(#7FB7BE);
    c2 = color(#DACC3E);
    window = color(#D3F3EE);
    stroke(c1);
    fill(c1);
    rectMode(CORNER);
    rect(xpos+rw*5, ypos-yoffset+rw*3, rw*16, rw*7);
    rect(xpos+rw*0, ypos-yoffset+rw*3, rw*5, rw*5);
    rect(xpos+rw*5, ypos-yoffset+rw*0, rw*10, rw*3);
    rect(xpos+rw*4, ypos-yoffset+rw*1, rw*11, rw*2);
    stroke(window);
    fill(window);
    rect(xpos+rw*9, ypos-yoffset+rw*1, rw*5, rw*2);
    stroke(c2);
    fill(c2);
    ellipseMode(CORNER);
    ellipse(xpos+rw*2, ypos-yoffset+rw*5, rw*10, rw*10);
    ellipse(xpos+rw*14, ypos-yoffset+rw*5, rw*10, rw*10);    
  }

  void getImage()
  {
    img = get(int(xpos), int(ypos-yoffset), int(xoffset), int(yoffset));  
    snapshot = true;
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
      Bars.clear();
      for(int i=0; i<22; i++) 
      {
        Bars.add(new Bar(i*w/20, barHeight, speedX));  
        barHeight = h-h/6;
      }      
      speedX = 10.0*w/ow;
      speedY = 0.1*h/oh;
      gravity = 0.1*h/oh;
      heightCount = 1;
      lastHeight = h-h/6;
      heightSum = 1;
      momentum = 1;
      score = 0;
    }  
  }
}