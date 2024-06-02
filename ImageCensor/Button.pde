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
    textAlign(LEFT);
    strokeWeight(1);
    stroke(255);
    drawBtn(c, 55);
    
    if (onButton()) {
      /* darken on hover */
      drawBtn(200, 0);
      
      /* blackens when directly clicked. activates btn function */
      if (mousePressed && !mouseDragged){
        fill(0);
        rect(x, y, w, h);
        
        switch (function) {
          case "download" : 
            String path = System.getProperty("user.home") + "/" + input.getString("test") + "/" + "censored_bird.jpg";
            print(path);
            img.save(path);
            println(mousePressed);
            //img.save("censored_bird.jpg");
            break;
            
          case "pixelate" :
            selectionTool.mode = function;
            slide.hide = false;
            
            drawTool.penDown = false;
            hideExtraDrawBtns();
            break;
            
          case "blur" :
            selectionTool.mode = function;
            
            slide.hide = true;
            drawTool.penDown = false;
            hideExtraDrawBtns();
            break;
            
          case "draw" :
            drawTool.penDown = true;
            for (CircleOnBtn btn : penSizeBtns) {
              btn.hide = false;
            }
            
            selectionTool.mode = "none";
            slide.hide = true;
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
  
  private void drawBtn(color bgColor, color txtColor) {
    fill(bgColor);
    rect(x, y, w, h);
    fill(txtColor);
    textSize(fontSize);
    text(text, (x + ((w - textWidth(text)) / 2)), (y + (h - ((2 * padding) + (textAscent() - textDescent())))));
  }
    
  private boolean onButton() {
    return (((mouseX > x) && (mouseX < x + w)) && ((mouseY > y) && (mouseY < y + h)));
  }
  
  /* hides the buttons that allow you to change the pen's size which appear when user clicks the 'Draw' button */
  private void hideExtraDrawBtns() {
    for (CircleOnBtn btn : penSizeBtns) {
      btn.hide = true;
    }
  }
  
}
