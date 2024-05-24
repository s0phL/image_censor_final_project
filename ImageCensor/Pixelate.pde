public class Pixelate {

  PImage img;
  
  int counter =0;
  
  public Pixelate(PImage img) {
    this.img = img;
  }
    
   void pixelate(int blockSize) {
    int extraXPixels = img.width % blockSize; // additional pixels to be added to end of each block if img dimentions not divisible by block dimentions
    int extraYPixels = img.height % blockSize;
    
    int yBlockSize = blockSize;
    //int yBlockSize = blockSize + extraYPixels;
    
    // need to do extra pixels for height (if height doesn't fit into block size)
    for (int i = 0; i < img.pixels.length; i+=blockSize) {
     //for (int i = 0; i < 136116; i+=blockSize) {
       //for (int i = 135432; i < img.pixels.length; i+=blockSize) {
         //for (int i = 136116; i < img.pixels.length; i+=blockSize) {
       
       if ((i/img.width)+blockSize+extraYPixels == img.height) {
          println("adashds");
          yBlockSize += extraYPixels;
          extraYPixels = -1;
        }
        
      if ((i+blockSize+extraXPixels) % img.width == 0) { //if reached end of img width
      
      
        color blockColor = avgRGB(blockSize+extraXPixels, yBlockSize, i);
        setBlockColor(blockColor, blockSize+extraXPixels, yBlockSize, i);
        
      
        
        i += extraXPixels + img.width*(yBlockSize-1);
        
        
      }
      else {
        color blockColor = avgRGB(blockSize, yBlockSize, i);
        setBlockColor(blockColor, blockSize, yBlockSize, i);
      }
    }
  }
  
  private color avgRGB(int xBlockSize, int yBlockSize, int startIndex) {
    print(counter + "//");
    int rSum = 0;
    int gSum = 0;
    int bSum = 0;
    for (int y = 0; y < yBlockSize; y++) {
      for (int x = 0; x < xBlockSize; x++) {
        int currentPos = startIndex+x + (y*img.width);
        print(currentPos + ", ");
        rSum += red(img.pixels[currentPos]);
        gSum += green(img.pixels[currentPos]);
        bSum += blue(img.pixels[currentPos]);
      }
      println("");
    }
    counter++;
    int blockArea = xBlockSize * yBlockSize;
    int rAvg = constrain((rSum / blockArea), 0, 255);
    int gAvg = constrain((gSum / blockArea), 0, 255);
    int bAvg = constrain((bSum / blockArea), 0, 255);
    return color(rAvg, gAvg, bAvg);
  }
  
  private void setBlockColor(color blockColor, int xBlockSize, int yBlockSize, int startIndex) {
    for (int x = 0; x < xBlockSize; x++) {
      for (int y = 0; y < yBlockSize; y++) {
        int currentPos = startIndex+x + (y*img.width);
        img.pixels[currentPos] = blockColor;
      }
    }
  }
}
