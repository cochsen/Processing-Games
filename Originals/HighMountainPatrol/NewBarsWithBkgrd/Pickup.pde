class Pickup
{
  int value;
  float xpos, ypos, pickupw, pickuph, coinw, xend, yend;
  float speed, ascent;
  PImage img;
  
  Pickup(float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
    pickupw = coinw = w/20;
    pickuph = w/20;
    xend = xpos + pickupw;
    yend = ypos + pickuph;
  }
  
  void update(float _s, float _asc)
  {
    speed = _s;
    ascent = _asc;
    xpos = xpos - speed;
    xend = xpos + pickupw;  
  }
  
  void display()
  {
    stroke(200);
    fill(200);
    rectMode(CORNER);
    image(img, xpos, ypos, coinw, pickuph);
  }
}