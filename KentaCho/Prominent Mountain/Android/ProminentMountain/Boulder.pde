class Boulder
{
    
  float xpos, ypos, boulderW, boulderH, xend;
  
  Boulder(float _xpos, float _ypos)
  {
    xpos = _xpos;
    ypos = _ypos;
    boulderW = 11*w/12;
    boulderH = w/4;
    xend = xpos+w;
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