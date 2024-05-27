public class Slider {
  
  int x, y, w, h, min, max;
  int xStart; //starting position of value slider
  
  public Slider(int x, int y, int sliderWidth, int sliderHeight, int min, int max) {
    this.x = x;
    this.y = y;
    w = sliderWidth;
    h = sliderHeight;
    this.min = min;
    this.max = max;
    xStart = x+2;
  }
  /* gets value associated with the slider line's position */
  int getValue() {
    return (int) map(xStart, x, (x + w), min, max);
  }

  void draw() {
    fill(255);
    stroke(0);
    rect(x, y, w, h);
    fill(255);
    textSize(10);
    textAlign(LEFT);
    text(min, x, (y + 20));
    textAlign(RIGHT);
    text(max, (x + w), (y + 20));        
    if (!mousePressed || !onButton()) {
      fill(0);
      rect(xStart, y, 2, 10);
    }
  }

  void mouseDragged() {
    if (onButton()) {
      fill(0);
      xStart = constrain(mouseX, x, (x + w - 2));
      rect(xStart, y, 2, 10);
    }
  }
  
  private boolean onButton() {
    return (((mouseX > x) && (mouseX < x + w)) && ((mouseY > y) && (mouseY < y + h)));
  }
  
}
