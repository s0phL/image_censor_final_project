public class Draw {
  private boolean penDown = false;
  private PGraphics pg, pg2;
  
  public Draw() {
    pg = createGraphics(img2.width, img2.height);
    pg2 = createGraphics(img2.width, img2.height);
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
      imgArea.line(pmouseX, pmouseY, mouseX, mouseY); 
      
      /* graphic to be combined with reference image */
      pg.stroke(0);
      pg.strokeWeight(penSize/(float)scaleFactor);
      /* converting line on zoomed image to what it would be on default zoom */
      pg.line((float)(leftCenterW + (defaultZoomPositionX(pmouseX))), (float)(leftCenterH + (defaultZoomPositionY(pmouseY))), (float)(leftCenterW + (defaultZoomPositionX(mouseX))), (float)(leftCenterH + (defaultZoomPositionY(mouseY))));
      
      //stroke(50);    
      //strokeWeight(penSize);
      //line((float)(leftCenterW + ((pmouseX - upLeftX) / scaleFactor)), (float)(leftCenterH + ((pmouseY - upLeftY) / scaleFactor)), (float)(leftCenterW + ((mouseX - upLeftX) / scaleFactor)), (float)(leftCenterH + ((mouseY - upLeftY) / scaleFactor)));
      //println(pmouseX, upLeftX, scaleFactor);
      //println((float)(leftCenterW + ((pmouseX - upLeftX) / scaleFactor)), (float)(leftCenterH + ((pmouseY - upLeftY) / scaleFactor)), (float)(leftCenterW + ((mouseX - upLeftX) / scaleFactor)), (float)(leftCenterH + ((mouseY - upLeftY) / scaleFactor)));

      imgArea.popMatrix();
      imgArea.endDraw();
      pg.popMatrix();
      pg.endDraw();
      
      //pg.save("pg.png");
      
      /* combines graphic and image. set img2 as the combination */
      pg2.beginDraw();
      pg2.image(img2, 0, 0);
      pg2.image(pg, 0, 0);
      pg2.endDraw();
      
      img2 = pg2.get(0, 0, img2.width, img2.height);
      
     }
  }
}
