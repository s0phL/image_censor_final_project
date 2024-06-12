public class Selection {
  private int selectXStart, selectYStart, rectWidth, rectHeight; //selection box outlines
  private String mode;
  
  private double scaleFactor;
  
  //initialize to 0 so rectangle selection box doesn't appear
  public Selection(String mode) {
    selectXStart = 0;
    selectYStart = 0;
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
      rect(selectXStart, selectYStart, rectWidth, rectHeight);
    }
  }

  void mousePressed() {
    selectXStart = mouseX;
    selectYStart = mouseY;
  }
  
  void mouseDragged() {
    rectWidth = mouseX - selectXStart;
    rectHeight = mouseY - selectYStart;
    
    if ((mode != "none") && onImage()) {
      saveImageState();
    }
  }
  
  /* pixelize/restore image based off what's inside the rectangle selection 
   * if user selects from top-left to bottom-right, top-right to bottom-left, or bottom-left to top-right --> pixelizes
   * if user selects from bottom-right to top-left --> restores
  */
  void mouseReleased() {
    if (mode != "none") {
      
      scaleFactor = (Math.pow(zoomSize, zoomCount));
      
      int xStart2, yStart2, mouseX2, mouseY2;
      /* convert zoomed selections into the coordinates user would have if they selected on default zoom size 
       * so easier for blur and pixelate to process
       * if zoom is on default zoom (scale factor == 1), no need to translate coordinates
      */
      if (scaleFactor == 1) {
        xStart2 = selectXStart - leftCenterW;
        yStart2 = selectYStart - leftCenterH;
        mouseX2 = mouseX - leftCenterW;
        mouseY2 = mouseY - leftCenterH;
      }
      else {
        xStart2 = (int)((selectXStart - upLeftX) / scaleFactor);
        yStart2 = (int)((selectYStart - upLeftY) / scaleFactor);
        
        mouseX2 = (int)((mouseX - upLeftX) / scaleFactor);
        mouseY2 = (int)((mouseY - upLeftY) / scaleFactor); 
      }
      
      if (rectWidth > 0 && rectHeight > 0) { //top-left to bottom-right, start point is start pixel
        editImage((xStart2), (yStart2));
      }
      else if (rectWidth < 0 && rectHeight > 0) { //top-right to bottom-left
        editImage((mouseX2), (yStart2));
      }
      else if (rectWidth > 0 && rectHeight < 0) { //bottom-left to top-right
        editImage((xStart2), (mouseY2));
      }
      else { //bottom-right to top-left, end point is start pixel
        Restore pixel = new Restore(imgCopy, img2, (mouseX2), (mouseY2), abs((int)(rectWidth/scaleFactor)), abs((int)(rectHeight/scaleFactor)));
        pixel.restore();
      }
      
      img2.updatePixels();
      
      /* make selection rectangle disappear after mouse release */
      xStart = 0;
      yStart = 0;
      rectWidth = 0;
      rectHeight = 0;
      
      /* apply censor edits */
      resetImageQuality();
      confineImg();
    }
  }
  
  /* edits image based off mode and given start coords ((0,0) is the first pixel) */
  private void editImage(int x, int y) {
    switch (mode) {
      case "pixelate" : 
        Pixelate pixel = new Pixelate(img2, x, y, abs((int)(rectWidth/scaleFactor)), abs((int)(rectHeight/scaleFactor)));
        pixel.pixelate(slide.getValue());
        break;
      case "blur" :
        Blur pixel2 = new Blur(img2, x, y, abs((int)(rectWidth/scaleFactor)), abs((int)(rectHeight/scaleFactor)));
        pixel2.blur();
        break;
    }
  }
    
}
