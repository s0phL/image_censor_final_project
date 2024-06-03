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
    //endHeight = this.cropHeight + y;
  }
  
  /* apply the kernel to img */
  void blur() {
    int indexPassed = 0;
    for (int i = startPixel; i < endPixel; i++) {
      
      if ((indexPassed + 1) % cropWidth == 0) { //if reached end of selected area width
        i += (img.width - cropWidth); //get to next block row
      }
      else {
        img.pixels[i] = calcNewColor(i);
      }
      
      indexPassed ++;
    }
  }
  
  /* iterates through kernel. calculates the convolution of r/g/b separately, and return that color
   * clamp calculation for any of the r,g,b values to 0-255
  */
  private color calcNewColor(int startIndex) {
    int rTotal = 0;
    int gTotal = 0;
    int bTotal = 0;
    
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 7; j++) {
        try {
          rTotal += red(img.pixels[startIndex+j]) * kernel[i][j];
          gTotal += green(img.pixels[startIndex+j]) * kernel[i][j];
          bTotal += blue(img.pixels[startIndex+j]) * kernel[i][j];
        }
        catch (ArrayIndexOutOfBoundsException e) {
          break;
        }
      }
      startIndex += img.width;
    }
    
    rTotal = constrain(rTotal, 0, 255);
    gTotal = constrain(gTotal, 0, 255);
    bTotal = constrain(bTotal, 0, 255);
    return color(rTotal, gTotal, bTotal);
  }

}
