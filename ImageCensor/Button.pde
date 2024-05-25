public class Button {
  boolean mouseDragged = false;
  float x, y, w, h, padding, fontSize;
  String text;
  color c;
  
  public Button(float x, float y, float btnWidth, float btnHeight, float padding, String text, float fontSize, color c) {
    this.x = x;
    this.y = y;
    w = btnWidth;
    h = btnHeight;
    this.padding = padding;
    this.text = text;
    this.fontSize = fontSize;
    this.c = c;
  }
  
  /* creates a rectangle button.
   * darkens rectangle on mouse hover.
   * fills rectangle with black on mouse click
  */
  void draw(){
    strokeWeight(1);
    stroke(255);
    fill(c);
    rect(x, y, w, h);
    fill(55);
    textSize(fontSize);
    text(text, (x + ((w - textWidth(text)) / 2)), (y + (h - ((2 * padding) + (textAscent() - textDescent())))));
    if (onButton()) {
      //darken on hover
      fill(200);
      rect(x, y, w, h);
      fill(0);
      text(text, (x + ((w-textWidth(text)) / 2)), (y + (h - ((2 * padding) + (textAscent() - textDescent())))));
      //blacken when directly clicked
      if (mousePressed && !mouseDragged){
        println("The mouse is pressed and over the button");
        fill(0);
        rect(x, y, w, h);
      }
    }
  }
  
  void mouseDragged() {
    mouseDragged = true;
  }
  
  void mouseReleased() {
    mouseDragged = false;
  }
  
  private boolean onButton() {
    return (((mouseX > x) && (mouseX < x + w)) && ((mouseY > y) && (mouseY < y + h)));
  }
  
}
