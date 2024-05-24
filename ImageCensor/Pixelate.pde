public class Pixelate {
  PImage img;
  int startPixel, endPixel, cropWidth, cropHeight;
  
  public Pixelate(PImage img, int xCoor, int yCoor, int cropWidth, int cropHeight) {
    this.img = img;
    startPixel = xCoor + (yCoor * cropWidth);;
    endPixel = cropWidth * cropHeight;
    this.cropWidth = cropWidth;
    this.cropHeight = cropHeight;
  }
  
  /* pixelates the image based off block size.
   * the larger the block size, the more pixelized.
  */
  void pixelate(int blockSize) {
    // additional pixels to be added to end of each block if img dimentions not evenly divisible by block dimentions
    int extraXPixels = cropWidth % blockSize;
    int extraYPixels = cropHeight % blockSize;
  
    int yBlockSize = blockSize;
 
    for (int i = startPixel; i < endPixel; i += blockSize) {
     
      if ((i / cropWidth) + blockSize + extraYPixels == cropHeight) { //if reach final block row before img end. i/cropWidth == curr row
          yBlockSize += extraYPixels;
          extraYPixels = -1; //to prevent future use
       }
      
      if ((i + blockSize + extraXPixels) % cropWidth == 0) { //if reached end of img width
        color blockColor = avgRGB((blockSize + extraXPixels), yBlockSize, i);
        setBlockColor(blockColor, (blockSize + extraXPixels), yBlockSize, i);
 
        i += extraXPixels + cropWidth * (yBlockSize - 1); //get to next block row
      }
      else {
        color blockColor = avgRGB(blockSize, yBlockSize, i);
        setBlockColor(blockColor, blockSize, yBlockSize, i);
      }
    }
  }
  
  /* returns average RGB of the given block section */
  private color avgRGB(int xBlockSize, int yBlockSize, int startIndex) {
    int rSum = 0;
    int gSum = 0;
    int bSum = 0;
     for (int y = 0; y < yBlockSize; y++) {
       for (int x = 0; x < xBlockSize; x++) {
        int currentPos = startIndex + x + (y * cropWidth);
        rSum += red(img.pixels[currentPos]);
        gSum += green(img.pixels[currentPos]);
        bSum += blue(img.pixels[currentPos]);
      }
    }
    int blockArea = xBlockSize * yBlockSize;
    int rAvg = constrain((rSum / blockArea), 0, 255);
    int gAvg = constrain((gSum / blockArea), 0, 255);
    int bAvg = constrain((bSum / blockArea), 0, 255);
    return color(rAvg, gAvg, bAvg);
  }
  
  /* iterates through each pixel in given block section and sets them to a color */
  private void setBlockColor(color blockColor, int xBlockSize, int yBlockSize, int startIndex) {
    for (int y = 0; y < yBlockSize; y++) {
      for (int x = 0; x < xBlockSize; x++) {
        int currentPos = startIndex + x + (y * cropWidth);
        img.pixels[currentPos] = blockColor;
      }
    }
  }
}
