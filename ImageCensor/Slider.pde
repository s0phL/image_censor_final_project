/* creates a vertical slider */
public class Slider {
  private boolean hide = true;
  private int x, y, w, h, min, max;
  private int indicatorPos;
  
  public Slider(int x, int y, int sliderWidth, int sliderHeight, int min, int max) {
    this.x = x;
    this.y = y;
    w = sliderWidth;
    h = sliderHeight;
    this.min = min;
    this.max = max;
    indicatorPos = y + 2; //start position
  }
  
  /* gets value associated with the value indicator position */
  int getValue() {
    return (int) map(indicatorPos, y, (y + h), min, max);
  }

  /* creates a rectangle slider with min and max labels */
  void draw() {
    if (!hide) {
      fill(255);
      stroke(0);
      rect(x, y, w, h); //bg display
      textSize(10);
      text(min, (x + 20), (y + 7));
      text(max, (x + 20), (y + h));
      
      if (!mousePressed || !onSlider()) {
        fill(0);
        rect(x, indicatorPos, w, (h / 100)); //value indicator
      }
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
      indicatorPos = constrain(mouseY, y, (y + h - 2));
      rect(x, indicatorPos, w, (h / 100));
    }
  }
  
  private boolean onSlider() {
    return (((mouseX > x) && (mouseX < x + w)) && ((mouseY > y) && (mouseY < y + h)));
  }
  
}
