public class Restore {
  private PImage originalImg, editedImg;
  private int startPixel, endPixel, cropWidth; //startPixel = starting index of selected area, endPixel = ending index of selected area
  
  public Restore(PImage originalImg, PImage editedImg, int x, int y, int cropWidth, int cropHeight) {
    
    this.originalImg = originalImg;
    this.editedImg = editedImg;
    
    if (y < 0) { //if leftmost coord above image
      y = 0;
    }
    if (cropWidth == 0) { //if vertical line, no restore
      startPixel = editedImg.pixels.length;
    }
    else if (x > editedImg.width) { //if leftmost coord off image (right), no restore
      startPixel = editedImg.pixels.length;
    }
    else if (x < 0) { //if leftmost coord off image (left):
      cropWidth += x;
      x = 0;
      if (cropWidth > 0) { //if some of the selection box is on the image, restore image selection
        startPixel = constrain((y * editedImg.width), 0, editedImg.pixels.length-1);
      }
      else { //if no selection box on image, no pixelization
        startPixel = editedImg.pixels.length;
      }
    }
    else { //if leftmost coord on image, restore
      startPixel = constrain(((y * editedImg.width) + x), 0, editedImg.pixels.length-1);
    }
    
    endPixel = constrain(startPixel + ((cropHeight - 1) * editedImg.width) + (cropWidth - 1), 0, (editedImg.pixels.length - 1));
    this.cropWidth = constrain((cropWidth + x), x, editedImg.width) - x;
  }
  
  /* itereates through selected area.
   * changes edited img pixel's to match its original state
  */
  void restore() {
    int indexPassed = 0;
    for (int i = startPixel; i < endPixel; i++) {
      
      if ((indexPassed + 1) % cropWidth == 0) { //if reached end of selected area width
        i += (editedImg.width - cropWidth); //get to next block row
      }
      else {
        editedImg.pixels[i] = originalImg.pixels[i];
      }
      
      indexPassed ++;
    }
    
    eraseDrawings();
  }
}
