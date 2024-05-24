public class Pixelate2 {

  PImage img;
  
  int counter =0;
  
  public Pixelate2(PImage img) {
    this.img = img;
  }
  //int rAvg = 0;
  //int gAvg = 0;
  //int bAvg = 0;
    
   void pixelate(int blockSize) {
    int extraXPixels = 7 % blockSize; // additional pixels to be added to end of each block if img dimentions not divisible by block dimentions
    int extraYPixels = 7 % blockSize;
    
    int yBlockSize = blockSize;
    //int yBlockSize = blockSize + extraYPixels;
    
    // need to do extra pixels for height (if height doesn't fit into block size)
    for (int i = 0; i < 49; i+=blockSize) {
     //for (int i = 0; i < 136116; i+=blockSize) {
       //for (int i = 135432; i < img.pixels.length; i+=blockSize) {
         //for (int i = 136116; i < img.pixels.length; i+=blockSize) {
       
       if ((i/7)+blockSize+extraYPixels == 7) {
          println("adashds");
          println(i);
          //println(yBlockSize);
          //println((i/7));
          //println(blockSize);
          yBlockSize += extraYPixels;
          println(yBlockSize);
          extraYPixels = -1;
        }
        
      if ((i+blockSize+extraXPixels) % 7==0) { //if reached end of img width
      
      
        color blockColor = avgRGB(blockSize+extraXPixels, yBlockSize, i);
        setBlockColor(blockColor, blockSize+extraXPixels, yBlockSize, i);
        
      
        print(i + " : " + extraXPixels + " : " + yBlockSize + " : ");
        i += extraXPixels + 7*(yBlockSize-1);
        print(i + "||" );
        
        
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
    //println(startIndex);
    //for (int x = 0; x < xBlockSize; x++) {
      //for (int y = 0; y < yBlockSize; y++) {
     for (int y = 0; y < yBlockSize; y++) {
       for (int x = 0; x < xBlockSize; x++) {
        int currentPos = startIndex+x + (y*7);
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
        int currentPos = startIndex+x + (y*7);
        img.pixels[currentPos] = blockColor;
      }
    }
  }
}
