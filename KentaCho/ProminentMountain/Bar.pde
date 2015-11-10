class Bar
{
  float xpos, ypos, barWidth, barHalfWidth, barHeight, mousePosX, mousePosY, speed;
  
  Bar(float _x, float _y, float _s)
  {
    xpos = _x;
    ypos = _y;
    speed = _s;
    barWidth = w/20;
    barHalfWidth = barWidth/2;
    barHeight = 0;
    mousePosX = 0;
    mousePosY = w/6;
  }
  
  void update(float _x, float _y, float _s)
  {
    speed = _s;
    xpos = xpos -= speed;
    mousePosX = _x;
    if(xpos>mousePosX-barHalfWidth && xpos<mousePosX+barHalfWidth)
    {
      ypos = _y;
    }
    if(xpos>w/6-20 && xpos<w/6+20)
    {
      if(player.ypos<ypos)
      {
        player.ypos += speedY - 0.3*momentum;
        speedY += gravity;
        if(state == 1 && ypos-player.ypos>100)
          score+=int(0.1*(ypos-player.ypos));
      }
      else
      {
        player.ypos = ypos;         
        speedY = 1;
      }
    }
  }
  
  void display()
  {
    rectMode(CORNER);
    fill(#5CE200);   
    rect(xpos-barHalfWidth, ypos, barWidth, h-ypos);
  }
}