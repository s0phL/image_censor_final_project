public class Pixelate {
  private PImage img;
  private int startPixel, endPixel, cropWidth, cropHeight, endHeight; //startPixel = starting index of selected area, endPixel = ending index of selected area, endHeight = last row index of selected area in relation to whole image
  
  public Pixelate(PImage img, int x, int y, int cropWidth, int cropHeight) {
    this.img = img;
    if (y < 0) { //if leftmost coord above image
      y = 0;
    }
    if (cropWidth == 0) { //if vertical line, no pixelization
      startPixel = img.pixels.length;
    }
    else if (x > img.width) { //if leftmost coord off image (right), no pixelization
      startPixel = img.pixels.length;
    }
    else if (x < 0) { //if leftmost coord off image (left):
      cropWidth += x;
      x = 0;
      if (cropWidth > 0) { //if some of the selection box is on the image, pixelize image selection
        startPixel = constrain((y * img.width), 0, img.pixels.length-1);
      }
      else { //if no selection box on image, no pixelization
        startPixel = img.pixels.length;
      }
    }
    else { //if leftmost coord on image, pixelization
      println((y * img.width) + x);
      startPixel = constrain(((y * img.width) + x), 0, img.pixels.length-1);
    }
    println(cropWidth, cropHeight);
    endPixel = constrain(startPixel + ((cropHeight - 1) * img.width) + (cropWidth - 1), 0, (img.pixels.length - 1));
    this.cropWidth = constrain((cropWidth + x), x, img.width) - x;
    this.cropHeight = constrain((cropHeight + y), y, img.height) - y;
    endHeight = this.cropHeight + y;
    
    println(x, y);
    println("startPixel: " + startPixel + "/ endPixel: " + endPixel + "/ cropWidth: " + cropWidth + "/ cropHeight: " + cropHeight + "/ x: " + x + "/ y: " + startPixel/img.width + "/ endHeight: " + endHeight + "/ x+cropWidth: " + (x+cropWidth));
    println("startPixel: " + startPixel + "/ endPixel: " + endPixel + "/ cropWidth: " + this.cropWidth + "/ cropHeight: " + this.cropHeight + "/ endHeight: " + endHeight + ":");
  }
  
  /* pixelates the image based off block size (finds and sets average RGB for each block).
   * the larger the block size, the more pixelized.
  */
  void pixelate(int blockSize) {
    if (blockSize > cropWidth) {
       blockSize = cropWidth;
    }
    /* additional pixels to be added to end of each block if img dimentions not evenly divisible by block dimentions */
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
  
  /* returns average RGB of the given block section */
  private color avgRGB(int xBlockSize, int yBlockSize, int startIndex) {
    int rSum = 0;
    int gSum = 0;
    int bSum = 0;
     for (int y = 0; y < yBlockSize; y++) {
       for (int x = 0; x < xBlockSize; x++) {
        int currentPos = startIndex + x + (y * img.width);
        try {
        rSum += red(img.pixels[currentPos]);
        gSum += green(img.pixels[currentPos]);
        bSum += blue(img.pixels[currentPos]);
        }
        catch (ArrayIndexOutOfBoundsException e) {
          break;
        }
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
        int currentPos = startIndex + x + (y * img.width);
        try {
        img.pixels[currentPos] = blockColor;
        }
        catch (ArrayIndexOutOfBoundsException e) {
          break;
        }
      }
    }
  }
}
