public class Draw {
  private boolean penDown = false;
  private PGraphics pg2;
  
  public Draw() {
    pg2 = createGraphics(img.width, img.height);
  }
  
  void mousePressed() {
    drawOnImage();
  }
  
  void mouseDragged() {
    drawOnImage();
  }
  
  /*
  void mouseReleased() {
          
      // combines graphic and image. set img as the combination 
      pg2.beginDraw();
      pg2.image(img2, 0, 0);
      pg2.image(imgArea, 0, 0);
      pg2.endDraw();
      
      img2 = pg2.get(0, 0, img.width, img.height);
      
      //resetImgQuality();
      
  }*/
  
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
      //println(scaleFactor);
      //println(thingX, mouseX);
      //println((float)(leftCenterW+((pmouseX-thingX) / scaleFactor)), (float)(leftCenterH+((pmouseY-thingY) / scaleFactor)), (float)(leftCenterW+((mouseX-thingX) / scaleFactor)), (float)(leftCenterH+((mouseY-thingY) / scaleFactor)));
      
      pg.beginDraw();
      pg.pushMatrix();
      imgArea.beginDraw();
      imgArea.pushMatrix();
      
      /* move pg pos to img pos */
      //pg.translate(-leftCenterW, -leftCenterH);
      pg.translate(-leftCenterW+(float)(thingX-leftCenterW), -leftCenterH+(float)(thingY-leftCenterH));
      imgArea.translate(-leftCenterW+(float)(thingX-leftCenterW), -leftCenterH+(float)(thingY-leftCenterH));

      /* what the user sees (when drawing) */
      imgArea.stroke(0);
      imgArea.strokeWeight(penSize);
      imgArea.line(pmouseX, pmouseY, mouseX, mouseY); 
      
      /* graphic to be combined with image */
      imgArea.stroke(0);
      pg.strokeWeight(penSize/(float)scaleFactor);
      pg.line((float)(leftCenterW+((pmouseX-thingX) / scaleFactor)), (float)(leftCenterH+((pmouseY-thingY) / scaleFactor)), (float)(leftCenterW+((mouseX-thingX) / scaleFactor)), (float)(leftCenterH+((mouseY-thingY) / scaleFactor)));

      imgArea.popMatrix();
      imgArea.endDraw();
      pg.popMatrix();
      pg.endDraw();
      
      
      img = imgArea.get(0, 0, img.width, img.height);
      
      /* combines graphic and image. set img as the combination */
      pg2.beginDraw();
      pg2.image(img2, 0, 0);
      pg2.image(pg, 0, 0);
      pg2.endDraw();
      
      img2 = pg2.get(0, 0, img2.width, img2.height);
      

      
       //resetImgQuality();
      //confineImg();
      
    }
  }
}
