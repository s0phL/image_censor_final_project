public class Pixelate {
  /*
  int blockSize;
  
  public Pixelate(int blockSize) {
    this.blockSize = blockSize;
  }
  */
  int rAvg = 0;
  int gAvg = 0;
  int bAvg = 0;
    
  void pixelate(PImage img, int blockSize) {
    int extraXPixels = img.width % blockSize; // additional pixels to be added to end of each block if img dimentions not divisible by block dimentions
    // need to do extra pixels for height (if height doesn't fit into block size)
    for (int i = 0; i < img.pixels.length; i+=blockSize) {
      if (i+blockSize+extraXPixels == img.width-1) {
        color blockColor = avgRGB(img, blockSize+extraXPixels, i);
        setBlockColor(blockColor, img, blockSize+extraXPixels, i);
        i += img.width*blockSize;
      }
      else {
        color blockColor = avgRGB(img, blockSize+extraXPixels, i);
        setBlockColor(blockColor, img, blockSize+extraXPixels, i);
      }
    }
  }
  
  color avgRGB(PImage img, int blockSize, int startIndex) {
    int rSum = 0;
    int gSum = 0;
    int bSum = 0;
    for (int x = 0; x < blockSize; x++) {
      for (int y = 0; y < blockSize; y++) {
        int currentPos = startIndex+x + (y*img.width);
        rSum += red(img.pixels[currentPos]);
        gSum += green(img.pixels[currentPos]);
        bSum += blue(img.pixels[currentPos]);
      }
    }
    int blockArea = blockSize * blockSize;
    int rAvg = constrain((rSum / blockArea), 0, 255);
    int gAvg = constrain((gSum / blockArea), 0, 255);
    int bAvg = constrain((bSum / blockArea), 0, 255);
    return color(rAvg, gAvg, bAvg);
  }
  
  void setBlockColor(color blockColor, PImage img, int blockSize, int startIndex) {
    for (int x = 0; x < blockSize; x++) {
      for (int y = 0; y < blockSize; y++) {
        int currentPos = startIndex+x + (y*img.width);
        img.pixels[currentPos] = blockColor;
      }
    }
  }
}
