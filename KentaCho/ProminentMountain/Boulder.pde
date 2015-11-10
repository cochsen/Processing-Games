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
    xpos = xpos - speedX; 
    xend = xpos+boulderW;
  }
  
  void display()
  {
    rectMode(CORNER);
    fill(200);
    rect(xpos, ypos, boulderW, boulderH);
  }
}