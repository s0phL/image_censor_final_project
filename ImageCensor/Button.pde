public class Button {
  private boolean mouseDragged = false;
  private float x, y, w, h, padding, fontSize;
  private String text, function;
  private color c;
  
  public Button(float x, float y, float btnWidth, float btnHeight, float padding, String text, float fontSize, color c, String function) {
    this.x = x;
    this.y = y;
    w = btnWidth;
    h = btnHeight;
    this.padding = padding;
    this.text = text;
    this.fontSize = fontSize;
    this.c = c;
    this.function = function;
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
    textAlign(LEFT);
    textSize(fontSize);
    text(text, (x + ((w - textWidth(text)) / 2)), (y + (h - ((2 * padding) + (textAscent() - textDescent())))));
    if (onButton()) {
      //darken on hover
      fill(200);
      rect(x, y, w, h);
      fill(0);
      text(text, (x + ((w - textWidth(text)) / 2)), (y + (h - ((2 * padding) + (textAscent() - textDescent())))));
      
      // blackens when directly clicked. activates btn function
      if (mousePressed && !mouseDragged){
        fill(0);
        rect(x, y, w, h);
        
        onRestore = false;
        
        switch (function) {
          case "download" : 
            img.save("censored_bird.jpg");
            break;
          case "pixelate" :
          case "blur" :
            selectionTool = new Selection(function);
            drawTool.penDown = false;
            onDraw = false;
            break;
          case "draw" :
            drawTool.penDown = true;
            selectionTool = new Selection("none");
            onDraw = true;
            break;
        } 
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
