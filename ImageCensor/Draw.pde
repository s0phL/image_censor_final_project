public class Draw {
  private PGraphics pg;
  private PImage drawingLayer;
  private int penWidth;
  
  public Draw(PImage img, int penWidth) {
    this.penWidth = penWidth;
    //this.img = img;
    pg = createGraphics(img.width, img.height);
  }
  
  //for future sophie: come up with a variable name for ((mouseX-(500-(img.width/2)))
  
  /*
  void setup() {
    pg = createGraphics(img.width, img.height);
  }
  */
  
  void mouseDragged() {
    if (onImage()) {
      strokeWeight(penWidth);
      line(pmouseX, pmouseY, mouseX, mouseY);
      
      pg.beginDraw();
      pg.strokeWeight(penWidth);
      pg.line(pmouseX, pmouseY, mouseX, mouseY);
      pg.endDraw();
      img = pg.get();
      //img.copy(drawingLayer, 500-(img.width/2), 250-(img.height/2), drawingLayer.width, drawingLayer.height, 500-(img.width/2), 250-(img.height/2), img.width, img.height);
      
    }
  }
  
  private boolean onImage() {
    //mouseIndexRelativeToImg
    return (((mouseX-(500-(img.width/2))) > 0) && ((mouseX-(500-(img.width/2))) < img.width) && ((mouseY-(250-(img.width/2))) > 0) && ((mouseY-(250-(img.width/2))) < img.height));
  }
}
