public class Slider {
  
  int x, y, w, h, min, max;
  int indicatorX; //x position of value indicator
  
  public Slider(int x, int y, int sliderWidth, int sliderHeight, int min, int max) {
    this.x = x;
    this.y = y;
    w = sliderWidth;
    h = sliderHeight;
    this.min = min;
    this.max = max;
    indicatorX = x + 2;
  }
  
  /* gets value associated with the value indicator position */
  int getValue() {
    return (int) map(indicatorX, x, (x + w), min, max);
  }

  /* creates a rectangle slider with min and max labels */
  void draw() {
    fill(255);
    stroke(0);
    rect(x, y, w, h); //bg display
    textSize(10);
    textAlign(LEFT);
    text(min, x, (y + 20));
    textAlign(RIGHT);
    text(max, (x + w), (y + 20));
    
    if (!mousePressed || !onSlider()) {
      fill(0);
      rect(indicatorX, y, 2, 10); //value indicator
    }
  }
  
  void mousePressed() {
    moveValueIndicator();
  }

  void mouseDragged() {
    moveValueIndicator();
  }
  
  private void moveValueIndicator() {
    if (onSlider()) {
      fill(0);
      indicatorX = constrain(mouseX, x, (x + w - 2));
      rect(indicatorX, y, 2, 10);
    }
  }
  
  private boolean onSlider() {
    return (((mouseX > x) && (mouseX < x + w)) && ((mouseY > y) && (mouseY < y + h)));
  }
  
}
