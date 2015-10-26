class Player {
  
  PImage img;
  float xpos, ypos;
  
  Player(PImage _img, float _x, float _y) {
    img = _img;
    xpos = _x;
    ypos = _y;
  }
  
  void display() {
    imageMode(CORNER);
    image(img, xpos, ypos);
  }
  
  void move(float px, float py) {
    xpos = xpos+px;
    ypos = ypos+py;
  }
  
  void trail() {
    
  }
}