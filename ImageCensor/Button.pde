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
            String download_path = System.getProperty("user.home") + "/downloads/censored_bird.jpg";
            img.save(download_path);
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
            
          case "fullCensor" :
            blackenImg();
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
  
  /* blackens entire image */
  private void blackenImg() {
    oldImg = img.get(0, 0, img.width, img.height); //save img before action in case want to undo
    usedUndo = false;
    delay(90); //to give time to save prev img before pgraphic covers it
    
    PGraphics tempPG = createGraphics(img.width, img.height);
    tempPG.beginDraw();
    tempPG.translate(-leftCenterW, -leftCenterH); //move pg pos to img pos

    tempPG.fill(0);
    tempPG.rect(leftCenterW, leftCenterH, img.width, img.height);

    tempPG.endDraw();
    
    img = tempPG.get(0, 0, img.width, img.height);
  }
  
}
