class Dart {
  
  PImage img;
  float xpos, ypos;
  int orientation;
  boolean out;
  
  Dart(PImage _img, int _orientation, float _x, float _y) {
    img = _img;
    orientation = _orientation;
    xpos = _x;
    ypos = _y;
    out = false;
  }
  
  void display() {
    imageMode(CORNER);
    image(img, xpos, ypos);
  }
  
  void move() {
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