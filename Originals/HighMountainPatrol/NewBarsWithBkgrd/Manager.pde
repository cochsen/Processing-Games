class Manager
{
  void manageBackgrounds()
  {
    background(#000028);
    for(int i=0; i<BkObjs.length; i++)
    {
      if(BkObjs[i].xpos < 0-BkObjs[i].maxObjWidth)
      {
        BkObjs[i].xpos = w + random(50);
      }
    BkObjs[i].update(speedX, ascentSpeed);
    BkObjs[i].display();
    }  
  }
  
  void manageBars()
  {
    for(int i=0; i<Bars.length; i++)
    {
      if(Bars[i].xpos<0-2*barWidth)
      {
        barHeight = random(mouseY, h);
        Bars[i].xpos = w;
      }
      Bars[i].update(mouseX, mouseY, speedX, ascentSpeed);
      Bars[i].display(); 
    }     
  }
  
  void changeAscent(int change)
  {
    if(change<76)
      ascentSpeed = h/oh*random(0, 5);
    else
      ascentSpeed = -h/oh*random(0, 2.5);
  }  
   
}