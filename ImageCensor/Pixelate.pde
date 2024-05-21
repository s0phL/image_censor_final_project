public class Pixelate {
  /*
  int blockSize;
  
  public Pixelate(int blockSize) {
    this.blockSize = blockSize;
  }
  */
    
  void pixelate(PImage img, int blockSize) {
    int rAvg;
    int gAvg;
    int bAvg;
    int extraXPixels = img.width % blockSize; // additional pixels to be added to end of each block if img dimentions not divisible by block dimentions
    for (int i = 0; i < img.pixels[].length; i+=blockSize) {
      if (i+blockSize+extraXPixels = img.width-1) {
        avgRGB(img, blockSize+extraPixels, i);
      }
      else {
        for (int j = 0; j < blockSize; j++) {
          rAvg += img.pixels[i+j];
        }
      }
    }
  }
  
  void avgRGB(PImage img, int blockSize, int initialX) {
    for (int j = 0; j < blockSize; j++) {
      for (int k = 0; k < blockSize; k++) {
        int currentPos = initialX+j + (k*img.width);
        rAvg += img.pixels[currentPos];
    }
  }
      
  }
}
