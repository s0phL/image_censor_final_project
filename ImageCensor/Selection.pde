public class Selection {
  private int xStart, yStart, rectWidth, rectHeight; //selection box outlines
  private String mode;
  
  //initialize to 0 so rectangle selection box doesn't appear
  public Selection(String mode) {
    xStart = 0;
    yStart = 0;
    rectWidth = 0;
    rectHeight = 0;
    this.mode = mode;
  }
  
  /* shows a rectangle based off mouse initial and last position when mouse is pressed */
  void draw() {
  stroke(255);
  strokeWeight(2);
  noFill();
  if (mousePressed && (mode != "none")) {
    rect(xStart, yStart, rectWidth, rectHeight);
    }
  }

  void mousePressed() {
    xStart = mouseX;
    yStart = mouseY;
  }
  
  void mouseDragged() {
    rectWidth = mouseX - xStart;
    rectHeight = mouseY - yStart;
  }
  
  /* pixelize/restore image based off what's inside the rectangle selection 
   * if user selects from top-left to bottom-right, top-right to bottom-left, or bottom-left to top-right --> pixelizes
   * if user selects from bottom-right to top-left --> restores
  */
  void mouseReleased() {
    if (mode != "none") {
      
      println("");
      println("=========");
      
      println(xStart, yStart, rectWidth, rectHeight);
      if (rectWidth > 0 && rectHeight > 0) { //top-left to bottom-right, start point is start pixel
        editImage((xStart - leftCenterW), (yStart - leftCenterH));
      }
      else if (rectWidth < 0 && rectHeight > 0) { //top-right to bottom-left
        editImage((mouseX - leftCenterW), (yStart - leftCenterH));
      }
      else if (rectWidth > 0 && rectHeight < 0) { //bottom-left to top-right
        editImage((xStart - leftCenterW), (mouseY - leftCenterH));
      }
      else { //bottom-right to top-left, end point is start pixel
        //pixel = new Pixelate(img, (mouseX-(500-(img.width/2))), (mouseY-(250-(img.height/2))), abs(rectWidth), abs(rectHeight));
        editImage((mouseX - leftCenterW), (mouseY - leftCenterH));
      }
      
      img.updatePixels();
      
      /* make selection rectangle disappear after mouse release */
      xStart = 0;
      yStart = 0;
      rectWidth = 0;
      rectHeight = 0;
    }
  }
  
  /* edits image based off mode and given start coords */
  private void editImage(int x, int y) {
    switch (mode) {
      case "pixelate" : 
        Pixelate pixel = new Pixelate(img, x, y, abs(rectWidth), abs(rectHeight));
        pixel.pixelate(slide.getValue());
        break;
      case "restore" :
        Restore pixel2 = new Restore(imgCopy, img, x, y, abs(rectWidth), abs(rectHeight));
        pixel2.restore();
        break;
    }
  }
    
}
