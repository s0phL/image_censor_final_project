public class Selection {
  int xStart, yStart, rectWidth, rectHeight; //selection box outlines
  
  //initialize to 0 so rectangle selection box doesn't appear
  public Selection() {
    xStart = 0;
    yStart = 0;
    rectWidth = 0;
    rectHeight = 0;
    
  }
  
  /* shows a rectangle based off mouse initial and last position when mouse is pressed */
  void draw() {
  background(0);
  image(img, 500-(img.width/2), 250-(img.height/2)); // place image at center of screen again
  stroke(255);
  strokeWeight(2);
  noFill();
  if (mousePressed) {
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
    //background(0);
    
    println("");
    println("=========");
    
    //Pixelate pixel;
    println(xStart, yStart, rectWidth, rectHeight);
    if (rectWidth > 0 && rectHeight > 0) { //top-left to bottom-right, start point is start pixel
      Pixelate pixel = new Pixelate(img, (xStart-(500-(img.width/2))), (yStart-(250-(img.height/2))), rectWidth, rectHeight);
      pixel.pixelate(8);
    }
    else if (rectWidth < 0 && rectHeight > 0) { //top-right to bottom-left
      Pixelate pixel = new Pixelate(img, (mouseX-(500-(img.width/2))), (yStart-(250-(img.height/2))), abs(rectWidth), rectHeight);
      pixel.pixelate(8);
    }
    else if (rectWidth > 0 && rectHeight < 0) { //bottom-left to top-right
      Pixelate pixel = new Pixelate(img, (xStart-(500-(img.width/2))), (mouseY-(250-(img.height/2))), rectWidth, abs(rectHeight));
      pixel.pixelate(8);
    }
    else { //bottom-right to top-left, end point is start pixel
      //pixel = new Pixelate(img, (mouseX-(500-(img.width/2))), (mouseY-(250-(img.height/2))), abs(rectWidth), abs(rectHeight));
      Restore pixel = new Restore(imgCopy, img, (mouseX-(500-(img.width/2))), (mouseY-(250-(img.height/2))), abs(rectWidth), abs(rectHeight));
      pixel.restore();
    }
    
    //pixel.pixelate(8);
    
    img.updatePixels();
    
    /* make selection rectangle disappear after mouse release */
    xStart = 0;
    yStart = 0;
    rectWidth = 0;
    rectHeight = 0;
    
  }
    
}
