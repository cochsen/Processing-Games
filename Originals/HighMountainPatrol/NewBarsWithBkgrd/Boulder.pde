class Boulder
{
  int slices;
  float xpos, ypos, w, h, xend, yend, tl, tr, bl, br, sliceSize;
  color c1, c2;
  
  Boulder(float _x, float _y, float _w, float _h, float _tl, float _tr, float _bl, float _br)
  {
    xpos = _x;
    ypos = _y;
    w = _w;
    h = _h;
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
  }
  
  void update(float _asc)
  {
    xpos = xpos - speedX; 
    xend = xpos + w;
    ypos = ypos + _asc;
    yend = yend + _asc;
  }
  
  void display()
  {
    stroke(c1);
    strokeWeight(4);
    fill(c2);
    rect(xpos, ypos, w, h, tl, tr, bl, br);  
    strokeWeight(1);
    stroke(0);
    noFill();
    rect(xpos, ypos, w, h);
  }
}