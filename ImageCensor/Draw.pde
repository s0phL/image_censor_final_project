public class Draw {
  private PGraphics pg, pg2;
  private PImage drawingLayer;
  private int penSize;
  
  public Draw(int penSize) {
    this.penSize = penSize;
    //this.img = img;
    pg = createGraphics(img.width, img.height);
    pg2 = createGraphics(img.width, img.height);
  }
  
  void mouseDragged() {
    if (onImage()) {
      strokeWeight(penSize);
      line(pmouseX, pmouseY, mouseX, mouseY);
      
      pg.beginDraw();
      pg.pushMatrix();
      pg.translate(-leftCenterW, -leftCenterH);

      pg.strokeWeight(penSize);
      pg.line(pmouseX, pmouseY, mouseX, mouseY);

      pg.popMatrix();
      pg.endDraw();
    }
  }

  void mouseReleased() {
    println(imgCopy.width, imgCopy.height);
    print(pg.width);

    pg2.beginDraw();
    pg2.image(img, 0, 0);
    pg2.image(pg, 0, 0);
    pg2.endDraw();
  
    img = pg2.get(0, 0, img.width, img.height);
  
    pg2.save("ahdsah.png");
  
    img.save("etsy.png");
}
  
  private boolean onImage() {
    //mouseIndexRelativeToImg
    return (((mouseX - leftCenterW) > 0) && ((mouseX-leftCenterW) < img.width) && ((mouseY - leftCenterH) > 0) && ((mouseY - leftCenterH) < img.height));
  }
}
