class Mtn
{
  int type;
  float xpos, ypos, xend;
  float increment = 3*h/58;
  float segmentWidth = w/58;
  
  Mtn(int type, float xpos, float ypos)
  {
    this.type = type;
    this.xpos = xpos;
    this.ypos = ypos;
    switch(type)
    {
      case 0:
        xend = 28*segmentWidth;
        break;
      case 1:
        xend = 40*segmentWidth;
        break;
      case 2:
        xend = 42*segmentWidth;
        break;
    }
  }
  
  void update(float speed, float ascent)
  {
    xpos -= speed*0.01;
    ypos += ascent*0.01;
  }
  
  void display()
  {
    switch(type)
    {
      case 0:
        drawMountainA(xpos, ypos);
        break;
      case 1:
        drawMountainB(xpos, ypos);
        break;
      case 2:
        drawMountainC(xpos, ypos);
        break;
    }
  }
  
  void drawMountainA(float x, float y)
  {
    stroke(#001400);
    fill(#001400);
    for(int i=0; i<29; i++)
    {
      if(i<=14)
        rect(x+i*segmentWidth, y, segmentWidth, -i*increment);
      else
        rect(x+i*segmentWidth, y, segmentWidth, -(14*increment - (i-14)*increment));
    }
    stroke(#3F1900);
    fill(#3F1900);
    for(int i=1; i<27; i++)
    {
      if(i<=13)
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -i*increment);
      else
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -(13*increment - (i-13)*increment));
    }  
  }
  
  void drawMountainB(float x, float y)
  {
    stroke(#001400);
    fill(#001400);
    for(int i=0; i<41; i++)
    {
      if(i<=14)
        rect(x+i*segmentWidth, y, segmentWidth, -i*increment);
      else if(14<i && i<=24)
      {
        rect(x+i*segmentWidth, y, segmentWidth, -14*increment);      
      }
      else
        rect(x+i*segmentWidth, y, segmentWidth, -(14*increment - (i-24)*increment));
    }
    stroke(#3F1900);
    fill(#3F1900);
    for(int i=1; i<39; i++)
    {
      if(i<=13)
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -i*increment);
      else if(13<i && i<=23)
      {
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -13*increment);
      }
      else
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -(13*increment - (i-23)*increment));
    }  
  }
  
  void drawMountainC(float x, float y)
  {
    // peak 1
    stroke(#001400);
    fill(#001400);
    for(int i=0; i<29; i++)
    {
      if(i<=14)
        rect(x+i*segmentWidth, y, segmentWidth, -i*increment);
      else
        rect(x+i*segmentWidth, y, segmentWidth, -(14*increment - (i-14)*increment));
    }
    stroke(#3F1900);
    fill(#3F1900);
    for(int i=1; i<27; i++)
    {
      if(i<=13)
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -i*increment);
      else
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -(13*increment - (i-13)*increment));
    }  
    
    // peak 2
    x = x + 14*segmentWidth;
    y = y + 3*increment;
    stroke(#001400);
    fill(#001400);
    for(int i=0; i<29; i++)
    {
      if(i<=14)
        rect(x+i*segmentWidth, y, segmentWidth, -i*increment);
      else
        rect(x+i*segmentWidth, y, segmentWidth, -(14*increment - (i-14)*increment));
    }
    stroke(#3F1900);
    fill(#3F1900);
    for(int i=1; i<27; i++)
    {
      if(i<=13)
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -i*increment);
      else
        rect(x+segmentWidth+i*segmentWidth, y, segmentWidth, -(13*increment - (i-13)*increment));
    }  
  }  
}