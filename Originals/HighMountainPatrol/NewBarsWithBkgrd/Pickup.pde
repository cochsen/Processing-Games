abstract class Pickup
{
  int value;
  float xpos, ypos, pickupw, pickuph, coinw, xend, yend;
  float speed, ascent;
  PImage img;
  
  Pickup(float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
    pickupw = coinw = w/22;
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
    ypos = ypos + ascent;
    yend = ypos + pickuph;
    if(xpos < -50*rw)  
    {
      xpos = w + random(480)*rw;   
      ypos = random(h) + ascent;
    }
  }
  
  void display()
  {
    stroke(200);
    fill(200);
    rectMode(CORNER);
    image(img, xpos, ypos, coinw, pickuph);
  }
}