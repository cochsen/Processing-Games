class Dart {
  
  PImage img;
  float xpos, ypos;
  int orientation;
  
  Dart(PImage _img, int _orientation, float _x, float _y) {
    img = _img;
    orientation = _orientation;
    xpos = _x;
    ypos = _y;
  }
  
  void display() {
    imageMode(CORNER);
    image(img, xpos, ypos);
    /*
    pushMatrix();    
    translate(xpos+img.width/2, ypos+img.height/2);
    rotate(0);
    rotate(PI/2);
    translate(-xpos-img.width/2, -ypos-img.height/2);    
    image(img, xpos, ypos);
    popMatrix();    
    */
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
  
  void create() {
    
  }
  
  void destroy() {
    
  }
}