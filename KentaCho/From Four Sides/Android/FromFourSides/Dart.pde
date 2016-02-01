class Dart 
{
  
  PImage img;
  float xpos, ypos, w, h;
  int orientation, nImg;
  boolean out;
  
  Dart(PImage _img, int _orientation, float _x, float _y, float _w, float _h) 
  {
    img = _img;
    orientation = _orientation;
    xpos = _x;
    ypos = _y;
    w = _w;
    h = _h;
    out = false;
    if(orientation == 1 || orientation == 3)
    {
      nImg = round(w/dartWidth);
    }
    else 
    {
      nImg = round(h/dartWidth);
    }
  }
  
  void display() 
  {
    imageMode(CORNER);
    if(orientation == 1 || orientation == 3)
    {
      for(int i=0; i<nImg; i++) 
      {
        image(img, xpos+i*dartWidth, ypos, dartWidth, dartWidth);         
      }  
      /* uncomment to display collision boundary
      stroke(225);
      noFill();
      rectMode(CORNER);
      rect(xpos, ypos, w, h); 
      */

    }
    else 
    {
      for(int i=0; i<nImg; i++)
      {
        image(img, xpos, ypos+i*dartWidth, dartWidth, dartWidth);  
      }
      /* uncomment to display collision boundary
      stroke(225);
      noFill();      a
      rectMode(CORNER);
      rect(xpos, ypos, w, h); 
      */
    }
    
  }
  
  void move() 
  {
    switch(orientation) {
      case 1:
        ypos += dartSpeedScaled;
        break;
      case 2: 
        xpos -= dartSpeedScaled;
        break;
      case 3: 
        ypos -= dartSpeedScaled;
        break;
      case 4:
        xpos += dartSpeedScaled;
        break;
      default:
        break;
    }
  }

}