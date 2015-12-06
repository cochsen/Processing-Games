// types of pickups:
// gold coins, bars, nuggets
// gems: rubies, emaralds, diamonds
// 

class Pickup
{
  int type, score;
  float xpos, ypos, pickupW, pickupH, xend, yend;  
  PImage img;
  
  Pickup(PImage img, float xpos, float ypos)
  {
    this.img = img;
    this.xpos = xpos;
    this.ypos = ypos;
    this.pickupW = img.width;
    this.pickupH = img.height;
  }
  
  void update()
  {
    xpos += speedX;
  }
  
  void display()
  {
    imageMode(CORNER);
    image(img, xpos, ypos);
  }
  
  void acquire()
  {
    
  }
}