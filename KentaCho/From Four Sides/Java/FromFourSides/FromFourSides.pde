float w, h;
int state;

void setup() {
  size(480, 480);
  w=width; h=height;
  background(0);
  state = 0;
}

void draw() {
  background(0);
  drawGrid();
}

void drawGrid() {
  stroke(80,0,80);
  strokeWeight(5);  
  for(int i=0; i<10; i++) line(0, h/10+i*h/10, w, h/10+i*h/10);
  for(int j=0; j<10; j++) line(w/10+j*w/10, h, w/10+j*w/10, 0);    
}