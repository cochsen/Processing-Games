class Boulder
{
  int slices;
  float xpos, ypos, boulderw, boulderh, xend, yend, tl, tr, bl, br, sliceSize;
  color c1, c2;
  PImage img;
  
  Boulder(float _x, float _y, float _w, float _h, float _tl, float _tr, float _bl, float _br)
  {
    xpos = _x;
    ypos = _y;
    boulderw = _w;
    boulderh = _h;
    tl = _tl;
    tr = _tr;
    bl = _bl;
    br = _br;
    xend = xpos + w;
    yend = ypos + h;
    sliceSize = w/20;
    slices = int(w/sliceSize);
    c1 = color(int(random(0, 100)));
    c2 = color(int(random(100, 200)));
    img = loadImage("rock.png");
  }
  
  void update(float _asc)
  {
    xpos = xpos - speedX; 
    xend = xpos + boulderw;
    ypos = ypos + _asc;
    yend = yend + _asc;
  }
  
  void display()
  {
    imageMode(CORNER);
    image(img, xpos, ypos, boulderw, boulderh);
  }
  
  void reposition()
  {
    xpos = w;
    ypos = random(-10, 3*h/4);
    boulderw = random(width/20, 12*width/20);
    boulderh = random(width/20, 12*width/20);
    xend = xpos + boulderw;
    yend = ypos + boulderh;
    tl = random(50);
    tr = random(50);
    bl = random(50);
    br = random(50);
    c1 = color(int(random(0, 100)));
    c2 = color(int(random(100, 200)));
    sliceSize = w/20;
  }
}