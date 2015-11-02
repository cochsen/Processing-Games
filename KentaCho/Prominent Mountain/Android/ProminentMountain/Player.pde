class Player
{

  float xpos, ypos;
  
  Player(float _x, float _y)
  {
    xpos = _x;
    ypos = _y;
  }
  
  void update() 
  {
    if(frameCount%((barWidth/speedX)) == 0)
    {
      if(ypos<lastHeight)
      {
        heightSum += lastHeight-ypos;
        momentum = heightSum/heightCount;  
        heightCount++;
        lastHeight = ypos;
      }
      else if(ypos>lastHeight)
      {
        heightSum = 1;
        heightCount = 1;
        lastHeight = ypos;
        momentum = 1;
      }
    }    
    println("momentum: " + momentum + ", count: " + heightCount);
  }
  
  void display()
  {
    rectMode(CENTER);
    fill(127);
    rect(xpos, ypos, w/12, w/12);
  }
  
}