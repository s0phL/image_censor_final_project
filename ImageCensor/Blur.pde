public class Blur {
  private PImage img;
  private int startPixel, endPixel, cropWidth, cropHeight, endHeight; //startPixel = starting index of selected area, endPixel = ending index of selected area, endHeight = last row index of selected area in relation to whole image
  private float[][] kernel = {
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, .01, .01, .01, 0, 0},
    {0, .01, .05, .11, .05, .01, 0},
    {0, .01, .11, .25, .11, .01, 0},
    {0, .01, .05, .11, .05, .01, 0},
    {0, 0, .01, .01, .01, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}
  };

  /**Constructor takes the kernel that will be applied to the image
  *This implementation only allows 3x3 kernels
  */
  public Blur(PImage img, int x, int y, int cropWidth, int cropHeight) {
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
  }

  /**Apply the kernel to the source,
  *and saves the data to the destination.*/
  void blur() {
    int x = 0;
    for (int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = calcNewColor(img, x, i/img.width);
      x++;
      if (x == img.width) { //reset column index after row length equals image width
        x = 0;
      }
    }    
  }
  
  /**If part of the kernel is off of the image, return black, Otherwise
  *Calculate the convolution of r/g/b separately, and return that color\
  *if the calculation for any of the r,g,b values is outside the range
  *     0-255, then clamp it to that range (< 0 becomes 0, >255 becomes 255)
  */
  private color calcNewColor(PImage img, int x, int y) {
    int centerPixel = img.width * y + x;
    int upperRightPixel = centerPixel-img.width-1;
    int rTotal = 0;
    int gTotal = 0;
    int bTotal = 0;
    
    if (x <= 0 || x >= img.width-1) {
      return 0;
    }
    if (y <= 0 || y >= img.height-1) {
      return 0;
    }
    
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 7; j++) {
        //println(finalRedValue);
        rTotal += red(img.pixels[upperRightPixel+j]) * kernel[i][j];
        gTotal += green(img.pixels[upperRightPixel+j]) * kernel[i][j];
        bTotal += blue(img.pixels[upperRightPixel+j]) * kernel[i][j];
      }
      upperRightPixel += img.width;
    }
    
    rTotal = constrain(rTotal, 0, 255);
    gTotal = constrain(gTotal, 0, 255);
    bTotal = constrain(bTotal, 0, 255);
    return color(rTotal, gTotal, bTotal);
  }

}
