public class Draw {
  private boolean penDown = false;
  private PGraphics pg2;
  
  public Draw() {
    pg = createGraphics(img.width, img.height);
    pg2 = createGraphics(img.width, img.height);
  }
  
  void mousePressed() {
    drawOnImage();
  }
  
  void mouseDragged() {
    drawOnImage();
  }
  
  void keyPressed() {
    if (key == 'a' || keyCode == UP) {
      penSize++;
    }
    if ((key == 'd' || keyCode == DOWN) && (penSize > 0)) {
      penSize--;
    }
  }
  
  /* draws a black line under user's cursor if cursor is on the image */
  private void drawOnImage() {
    if (onImage() && penDown) {
      /* what the user sees */
      strokeWeight(penSize);
      line(pmouseX, pmouseY, mouseX, mouseY);
      
      /* create a graphic to be combined with image */
      pg.beginDraw();
      pg.pushMatrix();
      pg.translate(-leftCenterW, -leftCenterH); //move pg pos to img pos

      pg.strokeWeight(penSize);
      pg.line(pmouseX, pmouseY, mouseX, mouseY);

      pg.popMatrix();
      pg.endDraw();
      
      /* combines graphic and image. set img as the combination */
      pg2.beginDraw();
      pg2.image(img, 0, 0);
      pg2.image(pg, 0, 0);
      pg2.endDraw();
      
      img = pg2.get(0, 0, img.width, img.height);
    }
  }
}
