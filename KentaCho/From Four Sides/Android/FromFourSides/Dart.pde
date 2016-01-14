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
      nImg = int(w/img.width);
    }
    else 
    {
      nImg = int(h/img.height);
    }
  }
  
  void display() 
  {
    imageMode(CORNER);
    if(orientation == 1 || orientation == 3)
    {
      for(int i=0; i<nImg; i++) 
      {
        image(img, xpos+i*24, ypos);  
      }  
    }
    else 
    {
      for(int i=0; i<nImg; i++)
      {
        image(img, xpos, ypos+i*24);  
      }
    }
    
  }
  
  void move() 
  {
    switch(orientation) {
      case 1:
        ypos += 5;
        break;
      case 2: 
        xpos -= 5;
        break;
      case 3: 
        ypos -= 5;
        break;
      case 4:
        xpos += 5;
        break;
      default:
        break;
    }
  }

}