class Bar
{
 
  float xpos, ypos, barWidth, barHalfWidth, barHeight, mousePos;
  
  Bar(float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
    barWidth = w/20;
    barHalfWidth = barWidth/2;
    barHeight = 0;
    mousePos = w/6;
  }
  
  void update(float _y)
  {
    xpos = xpos -= 5;
    if(xpos>mousePos-barHalfWidth && xpos<mousePos+barHalfWidth)
    {
      ypos = _y;
    }
  }
  
  void display()
  {
    rectMode(CORNER);
    fill(225);   
    rect(xpos-barHalfWidth, ypos, barWidth, h-ypos);
  }
}