public class Draw {
  private int currImgIndex;
  private int penWidth;
  
  public Draw() {
  }
  
  //for future sophie: come up with a variable name for ((mouseX-(500-(img.width/2)))
  
  void mouseDragged() {
    if (onImage()) {
      currImgIndex = ((mouseX-(500-(img.width/2))) + ((mouseY-(500-(img.width/2))) * img.width));
      img.pixels[currImgIndex] = 255;
      img.updatePixels();
      drawBlock(penWidth);
    }
  }
  
  void pixelate(int blockSize) {
    // additional pixels to be added to end of each block if img dimentions not evenly divisible by block dimentions
    int extraXPixels = cropWidth % blockSize;
    int extraYPixels = cropHeight % blockSize;
  
    int yBlockSize = blockSize;
    
    int indexPassed = 0;
    for (int i = startPixel; i < endPixel; i += blockSize) {
      
      if ((i / img.width) + blockSize + extraYPixels == endHeight) { //if reach final block chunck before end of selected area. i/img.width == curr row
          yBlockSize += extraYPixels;
          extraYPixels = -1; //to prevent future use
      }
      
      if ((indexPassed + blockSize + extraXPixels) % cropWidth == 0) { //if reached end of selected area width
        color blockColor = avgRGB((blockSize + extraXPixels), yBlockSize, i);
        setBlockColor(blockColor, (blockSize + extraXPixels), yBlockSize, i);
        
        i += (((yBlockSize - 1) * img.width) + extraXPixels + (img.width - cropWidth)); //get to next block row
        indexPassed += ((yBlockSize - 1) * cropWidth) + extraXPixels;
      }
      else {
        color blockColor = avgRGB(blockSize, yBlockSize, i);
        setBlockColor(blockColor, blockSize, yBlockSize, i);
      }
      indexPassed += blockSize;
    }
  }
  
  /* converts adjacent pixels upto blockSize to black */
  private void drawBlock(int blockSize) {
    cropWidth % blockSize;
    int extraYPixels = cropHeight % blockSize;
    
    for (int i = currImageIndex; i < blockSize; i++) {
      if (currImageIndex + i > img.width)
  }
  
  private boolean onImage() {
    //mouseIndexRelativeToImg
    return (((mouseX-(500-(img.width/2))) > 0) && ((mouseX-(500-(img.width/2))) < img.width) && ((mouseY-(500-(img.width/2))) > 0) && ((mouseY-(500-(img.width/2))) < img.height));
  }
}
