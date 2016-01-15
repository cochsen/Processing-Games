class Manager
{
  void setupEnv()
  {
    w=width; h=height;
    rw=w/480; rh=h/480;
    dartWidth = int(24*rw);
    dartHeight = int(24*rh);
    playerWidth = int(20*rw);
    playerHeight = int(28*rh);
    dartSpeed = int(5*rw);
    background(0);
    state = 0;
    collision=false;
  }
  
  void setupDarts()
  {
    // orientation initial values (determines starting side and direction of movement)
    for(int i=0; i<orientations.length; i++) 
    {
      orientations[i] = int(random(1,5));  
    }
    // initial number of darts for first 8 rows/cols
    for(int i=0; i<dartRowSize.length; i++) 
    {
      dartRowSize[i] = dartWidth*int(random(1, 17));
    }
    // some index to start the row/col that will fit all the darts on the screen
    for(int i=0; i<startPos.length; i++) 
    {
      int diff = int(random(width-dartRowSize[i]));
      startPos[i] = diff-(diff%dartWidth);  
    }
    dartImgUp = loadImage("DartPointUp.png");
    dartImgLeft = loadImage("DartPointLeft.png");
    dartImgDown = loadImage("DartPointDown.png");
    dartImgRight = loadImage("DartPointRight.png");
    // add 8 ArrayLists of darts to ArrayList rows
    // select image based on orientation
    for(int i=0; i<orientations.length; i++) 
    {
      // create dart with image and positions based on orientation
      if(orientations[i] == 1)
      {
        tmpImage = dartImgDown;
        Darts.add(new Dart(tmpImage, orientations[i], startPos[i], 0.0, dartRowSize[i], dartWidth));
      }
      else if(orientations[i] == 2)
      {
        tmpImage = dartImgLeft;
        Darts.add(new Dart(tmpImage, orientations[i], w, startPos[i], dartWidth, dartRowSize[i]));
      }
      else if(orientations[i] == 3)
      {
        tmpImage = dartImgUp;
        Darts.add(new Dart(tmpImage, orientations[i], startPos[i], h, dartRowSize[i], dartWidth));
      }
      else
      {
        tmpImage = dartImgRight;
        Darts.add(new Dart(tmpImage, orientations[i], 0.0, startPos[i], dartWidth, dartRowSize[i])); 
      }
    }
    // pick first dart to appear at random
    nextDart = int(random(Darts.size()));
  }
  
  void setupPlayer()
  {
    PlayerImg = loadImage("actor.png");
    // initialize player in the middle of the board
    player = new Player(PlayerImg, w/2, h/2);    
  }

}