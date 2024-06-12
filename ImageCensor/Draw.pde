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
    if (penDown) {
      if (key == 'a' || keyCode == UP) {
        penSize++;
      }
      if ((key == 'd' || keyCode == DOWN) && (penSize > 0)) {
        penSize--;
      }
    }
  }
  
  /* draws a black line under user's cursor if cursor is on the image */
  private void drawOnImage() {
    if (onImage() && penDown) {
      double scaleFactor = (Math.pow(zoomSize, zoomCount));
      
      pg.beginDraw();
      pg.pushMatrix();
      imgArea.beginDraw();
      imgArea.pushMatrix();
      
      /* move pg pos to img pos */
      pg.translate(-leftCenterW, -leftCenterH);
      imgArea.translate(-leftCenterW, -leftCenterH);

      /* what the user sees (when drawing) */
      imgArea.stroke(0);
      imgArea.strokeWeight(penSize);
      //imgArea.line(pmouseX, pmouseY, mouseX, mouseY); 
      imgArea.line(pmouseX, pmouseY, mouseX, mouseY); 
      
      /* graphic to be combined with reference image */
      pg.stroke(0);
      pg.strokeWeight(penSize/(float)scaleFactor);
      /* converting line on zoomed image to what it would be on normal zoom */
      pg.line((float)(leftCenterW + ((pmouseX - upLeftX) / scaleFactor)), (float)(leftCenterH + ((pmouseY - upLeftY) / scaleFactor)), (float)(leftCenterW + ((mouseX - upLeftX) / scaleFactor)), (float)(leftCenterH + ((mouseY - upLeftY) / scaleFactor)));

      imgArea.popMatrix();
      imgArea.endDraw();
      pg.popMatrix();
      pg.endDraw();
      
      img = imgArea.get((int)upLeftX-leftCenterW, (int)upLeftY-leftCenterH, img.width, img.height);
      
      /* combines graphic and image. set img as the combination */
      pg2.beginDraw();
      pg2.image(img2, 0, 0);
      pg2.image(pg, 0, 0);
      pg2.endDraw();
      
      img2 = pg2.get(0, 0, img2.width, img2.height);
      
    }
  }
}
