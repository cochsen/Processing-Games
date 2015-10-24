int state;
float w, h;
Actor actor;

void setup() {
  size(480, 480);
  w=width; h=height;
  background(0);
  state = 0;
  actor = new Actor(w/2, h/2);
}

void draw() {
  background(0);
  drawGrid();
  actor.display();
  if(keyPressed == true)
  {
    if(actor.xpos>0) 
      if(key == 'a' || key == 'A') actor.move(-10, 0);
    if(actor.xpos<w-20)
      if(key == 'd' || key == 'D') actor.move(10, 0);
    if(actor.ypos>0)
      if(key == 'w' || key == 'W') actor.move(0, -10);
    if(actor.ypos<h-32)
      if(key == 's' || key == 'S') actor.move(0, 10);    
  }
}

void drawGrid() {
  stroke(80,0,80);
  strokeWeight(5);  
  for(int i=0; i<10; i++) line(0, h/10+i*h/10, w, h/10+i*h/10);
  for(int j=0; j<10; j++) line(w/10+j*w/10, h, w/10+j*w/10, 0);    
}