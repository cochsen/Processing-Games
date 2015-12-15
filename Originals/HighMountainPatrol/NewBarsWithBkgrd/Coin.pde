class Coin extends Pickup
{
  boolean expand;
  
  Coin(float _x, float _y)
  {
    super(_x, _y);
    expand = true;
    img = loadImage("coin.png");
  }
  
  void update(float _s, float _asc)
  {
    super.update(_s, _asc);
    if(pickupw>35*rw && expand == true)
    {
      expand = false;
      pickupw -= 1;
    }
    else if(pickupw<5*rw && expand == false)
    {
      expand = true;
      pickupw += 1;
    }
    else if(expand == true)
      pickupw += 1;
    else
      pickupw -= 1;  
  }
  
  void display()
  {
    stroke(200);
    noFill();
    rectMode(CORNER);
    imageMode(CENTER);   
    image(img, xpos+pickupw/2, ypos+pickuph/2, pickupw, pickuph);
    rect(xpos, ypos, pickupw, pickuph);
  }
}