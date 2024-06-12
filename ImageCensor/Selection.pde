public class Selection {
  private int xStart, yStart, rectWidth, rectHeight; //selection box outlines
  //private int xStart2, yStart2, rectWidth2, rectHeight2;
  private String mode;
  
  private double scaleFactor;
  
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
      
      scaleFactor = (Math.pow(zoomSize, zoomCount));
      
      
      int xStart2, yStart2, mouseX2, mouseY2;
      
      if (scaleFactor == 1) {
        xStart2 = xStart - leftCenterW;
        yStart2 = yStart - leftCenterH;
        mouseX2 = mouseX - leftCenterW;
        mouseY2 = mouseY - leftCenterH;
      }
      else {
        xStart2 = (int)((xStart-thingX) / scaleFactor);
        yStart2 = (int)((yStart-thingY) / scaleFactor);
        
        mouseX2 = (int)((mouseX-thingX) / scaleFactor);
        mouseY2 = (int)((mouseY-thingY) / scaleFactor); 
      }
      
      println(xStart, thingX, yStart, thingY);
      println(xStart2, yStart2);
      println(scaleFactor);
      println(rectWidth/scaleFactor, rectHeight/scaleFactor);
      
      
      
      println(xStart, yStart, rectWidth, rectHeight);
      if (rectWidth > 0 && rectHeight > 0) { //top-left to bottom-right, start point is start pixel
        //editImage((xStart - leftCenterW), (yStart - leftCenterH));
        //editImage((xStart2 + leftCenterW), (yStart2 + leftCenterH));
        editImage((xStart2), (yStart2));
      }
      else if (rectWidth < 0 && rectHeight > 0) { //top-right to bottom-left
        editImage((mouseX2), (yStart2));
      }
      else if (rectWidth > 0 && rectHeight < 0) { //bottom-left to top-right
        editImage((xStart2), (mouseY2));
      }
      else { //bottom-right to top-left, end point is start pixel
        //pixel = new Pixelate(img, (mouseX-(500-(img.width/2))), (mouseY-(250-(img.height/2))), abs(rectWidth), abs(rectHeight));
        Restore pixel = new Restore(imgCopy, img2, (mouseX2), (mouseY2), abs((int)(rectWidth/scaleFactor)), abs((int)(rectHeight/scaleFactor)));
        pixel.restore();
      }
      
      img2.updatePixels();
      img2.save("img2.png");
      
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
        Pixelate pixel = new Pixelate(img2, x, y, abs((int)(rectWidth/scaleFactor)), abs((int)(rectHeight/scaleFactor)));
        pixel.pixelate(slide.getValue());
        break;
      case "blur" :
        Blur pixel2 = new Blur(img, x, y, abs(rectWidth), abs(rectHeight));
        pixel2.blur();
        break;
    }
  }
    
}
