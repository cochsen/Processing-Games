class Player
{

  float xpos, ypos;
  
  Player(float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
  }
  
  void update(float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
  }
  
  void display()
  {
    rectMode(CENTER);
    fill(127);
    rect(xpos, ypos, 40, 40);
  }
  
}