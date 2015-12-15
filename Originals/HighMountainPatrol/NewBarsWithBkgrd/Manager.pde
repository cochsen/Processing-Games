class Manager
{
  
  int pickupcounter = 0;
  
  void setupEnvironment()
  {
    background(#000028);
    speedX = speedXdelta = 4*rw;
    speedY = 1*rh;
    gravity = 0.4*rh;
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
  
  void setupPickups()
  {
    Coins = new Coin[2];
    for(int i=0; i<Coins.length; i++)
      Coins[i] = new Coin(i*480*rw + random(480)*rw, random(h));
    Gems = new Gem[2];
    for(int i=0; i<Coins.length; i++)
      Gems[i] = new Gem(i*480*rw + random(480)*rw, random(h));
  }
  
  void managePickups()
  {
    for(int i=0; i<Coins.length; i++)
    {
      Coins[i].update(speedX, ascentSpeed);
      Gems[i].update(speedX, ascentSpeed);
      Coins[i].display();
      Gems[i].display();    
    }
  }
  
  void detectPickups()
  {
    for(int i=0; i<Coins.length; i++)
    {    
      if(player.xpos>Coins[i].xpos && player.xpos<Coins[i].xend && 
        ((player.ypos-player.yoffset>Coins[i].ypos && player.ypos-player.yoffset<Coins[i].yend) || (player.ypos>Coins[i].ypos && player.ypos<Coins[i].yend)))
      {
        speedX += 5*rw;  
        pickupcounter += 1;
        Coins[i].xpos = w + random(200);   
        Coins[i].ypos = random(h);
        println("Overlapped: " + pickupcounter);
      }
      if(player.xpos>Gems[i].xpos && player.xpos<Gems[i].xend && 
        ((player.ypos-player.yoffset>Gems[i].ypos && player.ypos-player.yoffset<Gems[i].yend) || (player.ypos>Gems[i].ypos && player.ypos<Gems[i].yend)))
      {
        speedX += 5*rw;  
        pickupcounter += 1;
        Gems[i].xpos = w + random(200);   
        Gems[i].ypos = random(h);
        println("Overlapped: " + pickupcounter);
      }      
    }       
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
      ascentSpeed = h/oh*random(0, 2.5);
    else
      ascentSpeed = -h/oh*random(0, 2.5);
  }  
  
  public class colorSets
  { // player1 (body), player2 (wheels), background1 (bars), background2 (background obj), background3 (background obj), background4 (sky), obstacle1 (rock), obstacle2 (tree)
    color[] set1 = {};
    color[] set2 = {color(#7fb7be), color(#dacc3e), color(#5CE200),  color(#bc2c1a), color(#7d1538), color(#000028)};
    color[] set3 = {};
  }
  
   /*
  void detectCollisions()
  {
    for(int i=0; i<Boulders.size(); i++)
    {
      if((player.xpos>Boulders.get(i).xpos && player.xpos<Boulders.get(i).xend && player.ypos>Boulders.get(i).ypos && player.ypos-27<Boulders.get(i).yend) || player.ypos>h)
      {
        counterOn = true;
        //speedX = 0;
        break;
      }
    }
  }
  
  void detectPickup()
  {
    for(int i=0; i<Pickups.size(); i++)
    {
      if((player.xpos>Pickups.get(i).xpos && player.xpos<Pickups.get(i).xend && player.ypos>Pickups.get(i).ypos && player.ypos-27<Pickups.get(i).yend) || player.ypos>h)
      {
          
      }
    }
  }   
  */
  
}