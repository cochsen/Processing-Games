class Pickup
{
  int type, value;
  float xpos, ypos, pickupw, pickuph, xend, yend;
  float speed, ascent;
  
  Pickup(int type, float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
    if(type == 0)
    {
      pickupw = w/20;
      pickuph = w/20;
    }
    if(type == 1)
    {
      pickupw = w/40;
      pickuph = w/20;
    }
    xend = xpos + pickupw;
    yend = ypos + pickuph;
  }
  
  void update(float _s, float _asc)
  {
    speed = _s;
    ascent = _asc;
    xpos = xpos - speed;
    xend = xpos + pickupw;  
    //ypos = ypos + ascent;
    //yend = ypos + pickuph;
    /*
    rectMode(CORNER);
    stroke(0,0,255);
    rect(xpos, ypos, xend, yend);
    */
  }
  
  void display()
  {
    stroke(200);
    fill(200);
    rectMode(CORNER);
    rect(xpos, ypos, pickupw, pickuph);
  }
}