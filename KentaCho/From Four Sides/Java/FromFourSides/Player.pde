class Player 
{
  
  PImage img;
  float xpos, ypos;
  float speed, diagSpeed;  
  
  Player(PImage _img, float _x, float _y) 
  {
    img = _img;
    xpos = _x;
    ypos = _y;
    speed = 8;
    diagSpeed = sqrt(speed/2);    
  }
  
  void display() 
  {
    imageMode(CORNER);
    image(img, xpos, ypos);
  }
    
  void update() 
  {
    if(keys[0] == true) 
      if(player.xpos<w-24) player.move(8,0);
    if(keys[1] == true) 
      if(player.xpos>0) player.move(-8,0);
    if(keys[3] == true) 
      if(player.ypos<h-32) player.move(0,8);
    if(keys[2] == true) 
      if(player.ypos>0) player.move(0,-8);
    if(keys[1] == true && keys[3] == true) 
      if(player.xpos>0 && player.ypos<h-32) player.move(-diagSpeed,diagSpeed);
    if(keys[1] == true && keys[2] == true)
      if(player.xpos>0 && player.ypos>0) player.move(-diagSpeed,-diagSpeed);  
    if(keys[0] == true && keys[3] == true)
      if(player.xpos<w-24 && player.ypos<h-32) player.move(diagSpeed,diagSpeed);  
    if(keys[0] == true && keys[2] == true) 
      if(player.xpos<w-24 && player.ypos>0) player.move(diagSpeed,-diagSpeed);     
  }  
  
  void move(float px, float py) 
  {
    xpos = xpos+px;
    ypos = ypos+py;
  }
  
  void trail() {
    
  }
}