public class Draw {
  private boolean penDown = false;
  private PGraphics pg2;
  
  public Draw() {
    pg = createGraphics(img.width, img.height);
    pg2 = createGraphics(img.width, img.height);
  }
  
  void mousePressed() {
    if (mouseButton == LEFT) {
      drawOnImage();
    }
  }
  
  void mouseDragged() {
    if (mouseButton == LEFT) {
      drawOnImage();
    }
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
      println(scaleFactor);
      println(thingX, mouseX);
      
      /* what the user sees */
      strokeWeight(penSize);
      line(pmouseX, pmouseY, mouseX, mouseY);
      println(pmouseX, pmouseY, mouseX, mouseY);
      //line((float)(leftCenterW+(pmouseX-thingX) / scaleFactor), (float)(leftCenterH+(pmouseY-thingY) / scaleFactor), (float)(leftCenterW+(mouseX-thingX) / scaleFactor), (float)(leftCenterH+(mouseY-thingY) / scaleFactor));
      
      /* create a graphic to be combined with image */
      
      /*
      pg.beginDraw();
      //pg.pushMatrix();
      //pg.translate(-leftCenterW, -leftCenterH); //move pg pos to img pos
      pg.pushMatrix();
      pg.translate(-leftCenterW, -leftCenterH); //move pg pos to img pos
      //pg.scale(2);

      pg.strokeWeight(penSize);
      pg.line(pmouseX, pmouseY, mouseX, mouseY);

      //pg.popMatrix();
      pg.popMatrix();
      pg.endDraw();
      */
      
      
      pg.beginDraw();
      pg.pushMatrix();
      imgArea.beginDraw();
      imgArea.pushMatrix();
      imgArea.translate(-leftCenterW, -leftCenterH); //move pg pos to img pos
      pg.translate(-leftCenterW, -leftCenterH);
      //pg.scale(2);

      imgArea.strokeWeight(penSize);
      imgArea.line(pmouseX, pmouseY, mouseX, mouseY);
      pg.strokeWeight(penSize/(float)scaleFactor);
      pg.line((float)(leftCenterW+((pmouseX-thingX) / scaleFactor)), (float)(leftCenterH+((pmouseY-thingY) / scaleFactor)), (float)(leftCenterW+((mouseX-thingX) / scaleFactor)), (float)(leftCenterH+((mouseY-thingY) / scaleFactor)));
      println((float)(leftCenterW+((pmouseX-thingX) / scaleFactor)), (float)(leftCenterH+((pmouseY-thingY) / scaleFactor)), (float)(leftCenterW+((mouseX-thingX) / scaleFactor)), (float)(leftCenterH+((mouseY-thingY) / scaleFactor)));

      //pg.popMatrix();
      imgArea.popMatrix();
      imgArea.endDraw();
      pg.popMatrix();
      pg.endDraw();
      
      img = imgArea.get(0, 0, img.width, img.height);
      
      
      //resetImgQuality();
      //confineImg();
      
      
      // combines graphic and image. set img as the combination 
      
      pg2.beginDraw();
      pg2.image(img2, 0, 0);
      pg2.image(pg, 0, 0);
      pg2.endDraw();
      
      img2 = pg2.get(0, 0, img2.width, img2.height);
      
      /*
        imgArea.beginDraw();
        imgArea.background(240);
        imgArea.image(img, (float)thingX-leftCenterW, (float)thingY-leftCenterH);
        imgArea.endDraw();
      */
      
      //resetImgQuality();
      
    }
  }
  
  private boolean onImage() {
    return (((mouseX - leftCenterW) > 0) && ((mouseX - leftCenterW) < img.width) && ((mouseY - leftCenterH) > 0) && ((mouseY - leftCenterH) < img.height));
  }
}
