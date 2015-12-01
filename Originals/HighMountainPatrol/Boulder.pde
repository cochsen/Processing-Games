class Boulder
{
    
  float xpos, ypos, boulderW, boulderH, xend, yend;
  
  Boulder(float _xpos, float _ypos)
  {
    xpos = _xpos;
    ypos = _ypos;
    boulderW = 0.92*w;
    boulderH = 0.25*h;
    xend = xpos+boulderW;
    yend = ypos+boulderH;
  }
  
  void update(float _asc)
  {
    xpos = xpos - speedX; 
    xend = xpos+boulderW;
    ypos = ypos + _asc;
    yend = yend + _asc;
  }
  
  void display()
  {
    rectMode(CORNER);
    fill(200);
    rect(xpos, ypos, boulderW, boulderH);
  }
}