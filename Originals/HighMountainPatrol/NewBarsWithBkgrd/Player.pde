class Player
{
  boolean snapshot, exploding;
  int cellSize, columns, rows, counter;
  float xpos, ypos, lastypos, xoffset, yoffset;
  float avg0, avg1;
  float barHeight, prevBarHeight;
  float[] trpos;
  float[][] pxdir, pydir, pSizes, pScaling;
  color c1, c2, c3;
  PImage img;
  
  Player(float x, float y)
  {
    xpos = x;
    ypos = lastypos = y;
    xoffset = 48*rw;
    yoffset = 30*rh;
    trpos = new float[4];
    for(int i=0; i<4; i++)
      trpos[i] = y;
    
    // explosion method attributes
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
    if(exploding == false)
    { 
      trpos[3] = trpos[2];
      trpos[2] = trpos[1];      
      trpos[1] = trpos[0]; 
      trpos[0] = ypos;           
    }
    avg0 = (trpos[0] + trpos[1] + trpos[2])/3;
    avg1 = (trpos[1] + trpos[2] + trpos[3])/3;
    // speed conditions
    // 1. cap speed at 30
    // 2. speed cannot be negative (speedX >0)
    // 3. going uphill slows you down
    // 4. going downhill or straight speeds you up
    if(prevBarHeight - barHeight > 3*yoffset)
      speedX -= 0.01*(prevBarHeight-barHeight);
    else if(prevBarHeight <= barHeight)
      speedX += 0.03 + 0.01*(barHeight-prevBarHeight);
    if(speedX < 0)
      speedX = 0;
    if(speedX > 30)
      speedX = 30;
    rectMode(CORNER);
    stroke(200);
    noFill();
    rect(xpos, ypos-yoffset, xoffset, yoffset);
  }
  
  void display()
  {
    pushMatrix();
    translate(xpos, ypos);
    if(ypos > lastypos)
      rotate(-2*PI/(ypos/lastypos));
    else
      rotate(-2*PI/(avg0/avg1));
    drawRover();
    popMatrix();
    if(snapshot == false)
      getImage();
  }
    
    void drawRover()
    {
      c1 = color(#7FB7BE);
      c2 = color(#DACC3E);
      c3 = color(#D3F3EE);
      stroke(c1);
      fill(c1);
      rectMode(CORNER);
      rect(rw*10, -yoffset+rw*6, rw*32, rw*14);
      rect(rw*0, -yoffset+rw*6, rw*10, rw*10);
      rect(rw*10, -yoffset+rw*0, rw*20, rw*6);
      rect(rw*10, -yoffset+rw*2, rw*22, rw*4);
      stroke(c3);
      fill(c3);
      rect(rw*18, -yoffset+rw*2, rw*10, rw*4);
      stroke(c2);
      fill(c2);
      ellipseMode(CORNER);
      ellipse(rw*4, -yoffset+rw*10, rw*20, rw*20);
      ellipse(rw*28, -yoffset+rw*10, rw*20, rw*20);    
    }    
    
    void getImage()
    {
      img = get(int(xpos), int(ypos-yoffset), int(xoffset), int(yoffset));  
      snapshot = true;
    }    
    
    void setBarHeight(float y)
    {
      barHeight = y;  
    }    
    
    void setPrevBarHeight(float y)
    {
      prevBarHeight = y;  
    }
}