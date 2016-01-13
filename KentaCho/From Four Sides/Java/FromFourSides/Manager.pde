class Manager
{
  void setupEnv()
  {
    w=width; h=height;
    background(0);
    state = 0;
    collision=false;
  }
  
  void setupControls()
  {
    keys = new boolean[4];  // mapping: [d,a,s,w]
    for(int i=0; i<keys.length; i++) keys[i] = false;  
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
      dartRowSize[i] = 24*int(random(1, 17));
    }
    // some index to start the row/col that will fit all the darts on the screen
    for(int i=0; i<startPos.length; i++) 
    {
      int diff = int(random(480-dartRowSize[i]));
      startPos[i] = diff-(diff%24);  
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
        Darts.add(new Dart(tmpImage, orientations[i], startPos[i], 0.0, dartRowSize[i], 24));
      }
      else if(orientations[i] == 2)
      {
        tmpImage = dartImgLeft;
        Darts.add(new Dart(tmpImage, orientations[i], w, startPos[i], 24, dartRowSize[i]));
      }
      else if(orientations[i] == 3)
      {
        tmpImage = dartImgUp;
        Darts.add(new Dart(tmpImage, orientations[i], startPos[i], h, dartRowSize[i], 24));
      }
      else
      {
        tmpImage = dartImgRight;
        Darts.add(new Dart(tmpImage, orientations[i], 0.0, startPos[i], 24, dartRowSize[i])); 
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