class Manager
{
  
  void setupEnvironment()
  {
    background(#000028);
    speedX = speedXdelta = 1*rw;
    speedY = 1*rh;
    gravity = 0.2*rh;
    ascentSpeed = 0;
  }
  
  void setupBars()
  {
    barWidth=w/20;
    barHeight = h-h/6;
    Bars = new Bar[22];
    for(int i=0; i<22; i++) 
    {
      Bars[i] = new Bar(i*barWidth, barHeight, speedX);  
    }    
  }
  
  void setupBackgroundObjects()
  {
    BkObjs = new BkObj[7];
    for(int i=0; i<4; i++)
    {
      BkObjs[i] = new BkObj(int(random(3)), i*200*rw + random(200), h);  
    }
    for(int i=4; i<7; i++)
    {
      BkObjs[i] = new BkObj(int(random(3, 6)), i*200*rw + random(200), h);  
    }      
  }
  
  void setupPlayer()
  {
    player = new Player(w/6, h-h/6);
  }
  
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
  
  public class colorSets
  {
    color[] set1 = {};
    color[] set2 = {};
    color[] set3 = {};
  }
   
}