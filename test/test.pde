int a, b, c, d;

void setup() {
  size(800, 600);
  a=0;
  b=0;
  c=0;
  d=0;
}


void draw() {
  background(0);
  stroke(255);
  strokeWeight(2);
  noFill();
  //rect(a, b, c, d);
}


void mousePressed() {
  a=mouseX;
  b=mouseY;
}


void mouseDragged() {
  c=mouseX-a;
  d=mouseY-b;
  rect(a, b, c, d);
}

void mouseReleased() {
  //background(0);
  println(a + ":" + b + ":" + c + ":" + d);
}
