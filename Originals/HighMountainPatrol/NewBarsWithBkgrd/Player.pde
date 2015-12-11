class Player
{
  boolean snapshot, exploding;
  int cellSize, columns, rows, counter;
  float xpos, ypos, xoffset, yoffset;
  float[][] pxdir, pydir, pSizes, pScaling;
  color c1, c2, c3;
  PImage img;
  
  Player(float mx, float my)
  {
    xpos = mx;
    ypos = my;
    xoffset = 24*rw;
    yoffset = 15*rh;
    
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

    }
  }
  
  void display()
  {
    drawRover();
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
      rect(xpos+rw*5, ypos-yoffset+rw*3, rw*16, rw*7);
      rect(xpos+rw*0, ypos-yoffset+rw*3, rw*5, rw*5);
      rect(xpos+rw*5, ypos-yoffset+rw*0, rw*10, rw*3);
      rect(xpos+rw*4, ypos-yoffset+rw*1, rw*11, rw*2);
      stroke(c3);
      fill(c3);
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
}