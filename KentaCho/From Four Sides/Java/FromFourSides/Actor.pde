class Actor {
  
  float xpos, ypos;
  
  Actor(float _x, float _y) {
    xpos = _x;
    ypos = _y;
  }
  
  void display() {
    rectMode(CORNER);
    noStroke();
    fill(#F0F000);
    rect(xpos+4, ypos, 4, 4); 
    rect(xpos+12, ypos, 4, 4);
    fill(#E5E500);
    rect(xpos, ypos+4, 4, 4);
    rect(xpos+16, ypos+4, 4, 4);
    fill(#E4D929);
    rect(xpos+4, ypos+4, 12, 4);
    fill(#DADA00);
    rect(xpos, ypos+8, 4, 4);
    rect(xpos+8, ypos+8, 4, 4);
    rect(xpos+16, ypos+8, 4, 4);
    fill(#DDCD22);
    rect(xpos+4, ypos+8, 4, 4);
    rect(xpos+12, ypos+8, 4, 4);
    fill(#CECE00);
    rect(xpos, ypos+12, 4, 4);
    rect(xpos+16, ypos+12, 4, 4);
    fill(#D4C21B);
    rect(xpos+4, ypos+12, 12, 4);
    fill(#C3C300);
    rect(xpos, ypos+16, 4, 4);
    rect(xpos+8, ypos+16, 4, 4);
    rect(xpos+16, ypos+16, 4, 4);
    fill(#CBB615);
    rect(xpos+4, ypos+16, 4, 4);
    rect(xpos+12, ypos+16, 4, 4);
    fill(#B7B700);
    rect(xpos, ypos+20, 4, 4);
    rect(xpos+8, ypos+20, 4, 4);
    rect(xpos+16, ypos+20, 4, 4);
    fill(#B6AB0E);
    rect(xpos+4, ypos+20, 4, 4);
    rect(xpos+12, ypos+20, 4, 4);    
    fill(#ACAC00);
    rect(xpos+4, ypos+24, 4, 4);
    rect(xpos+12, ypos+24, 4, 4);
  }
  
  void move(float px, float py) {
    xpos = xpos+px;
    ypos = ypos+py;
  }
}