int xStart, yStart = 10;
int min = 0;
int max = 10;
void setup() {
}

void draw() {
  background(255);
  fill(255);
  rect(10, 10, 50, 10);
  fill(0);
  textAlign(LEFT);
  text(min, 10, 10+20);
  textAlign(RIGHT);
  text(max, 10+50, 10+20);
  //fill(255);
  if (!mousePressed || !onButton()) {
    rect(xStart, 10, 2, 10);
  }
}

void mouseDragged() {
  if (onButton()) {
    fill(0);
    rect(constrain(mouseX, 10, 10+50-2), 10, 2, 10); //extra minus 2 due to rectWidth
  }
}

void mouseReleased() {
  if (onButton()) {
  xStart = constrain(mouseX, 10, 10+50);
  println(map( xStart, 10, 10+50, min, max));
  }
}
  
private boolean onButton() {
    return (((mouseX > 10) && (mouseX < 10 + 50)) && ((mouseY > 10) && (mouseY < 10 + 10)));
  }
