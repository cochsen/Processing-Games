int w, h;
El el;
Sq sq;

void setup()
{
  size(800, 400);  
  w = width; h = height;
  el = new El(w/4, 7*h/8, w/20, w/20);
  sq = new Sq(3*w/4, 7*h/8, w/20, w/20);
}

void draw()
{
  background(127);
  stroke(0);
  fill(0);
  rectMode(CORNER);
  rect(width/2, 0, width/2, height);
  
  el.drawEllipse();
  sq.drawSquare();
  
}

void mousePressed()
{
  if(mouseX<w/2)
  {
    el.moveEllipse(mouseX, mouseY);
    sq.moveSquare(mouseX, mouseY);
  }
}

void mouseDragged()
{
  if(mouseX<w/2)
  {
    el.moveEllipse(mouseX, mouseY);
    sq.moveSquare(mouseX, mouseY);
  }
}

class El
{
  float x, y, w, h;
  
  El(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void drawEllipse()
  {
    ellipseMode(CENTER);
    stroke(255,0,0,127);
    fill(255,0,0,127);
    ellipse(x, y, w, h);
  }
  
  void moveEllipse(float x, float y)
  {
    this.x = x;
    this.y = y;
  }  
}

class Sq
{
  float x, y, w, h;
  
  Sq(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void drawSquare()
  {
    rectMode(CENTER);
    stroke(0,0,255,200);
    fill(0,0,255,200);
    rect(x, y, w, h);
  }
  
  void moveSquare(float x, float y)
  {
    this.x = x+width/2;
    this.y = y;
  } 
  
}