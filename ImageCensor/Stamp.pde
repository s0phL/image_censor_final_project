public class Stamp {
  private boolean stampDown = false;
  private PGraphics pg2;
  private int w; //stamp width

  public Stamp() {
    pg2 = createGraphics(img.width, img.height);
    w = img.width/3;
  }
  
  void mousePressed() {
    if (stampDown) {
      float scaleFactor = (float)(Math.pow(zoomSize, zoomCount));
      
      pg.beginDraw();
      pg.pushMatrix();
      imgArea.beginDraw();
      imgArea.pushMatrix();
      
      /* move pg pos to img pos */
      pg.translate(-leftCenterW, -leftCenterH);
      imgArea.translate(-leftCenterW, -leftCenterH);
      
      int stampCenterX = mouseX-(w/2);
      int stampCenterY = mouseY-(w/6);
      
      imgArea.stroke(217, 4, 0);
      imgArea.strokeWeight(3);
      imgArea.fill(255);
      imgArea.rect(stampCenterX, stampCenterY, w, w/3); 
      imgArea.fill(217, 4, 0);
      
      pg.stroke(217, 4, 0);
      pg.strokeWeight(3/scaleFactor);
      
      pg.fill(255);
      pg.rect(stampCenterX, stampCenterY, w, w/3); 
      pg.fill(217, 4, 0);
      
      String text = "CENSORED";
      imgArea.textSize(w/5);
      imgArea.text(text, (stampCenterX + ((w - textWidth(text)) / 6)), (stampCenterY + ((w/3 - (textDescent() - textAscent())) / 2 )));
      
      pg.textSize(w/5);
      pg.text(text, (stampCenterX + ((w - textWidth(text)) / 6)), (stampCenterY + ((w/3 - (textDescent() - textAscent())) / 2 )));
  
      imgArea.popMatrix();
      imgArea.endDraw();
      pg.popMatrix();
      pg.endDraw();
      
      img = imgArea.get((int)upLeftX-leftCenterW, (int)upLeftY-leftCenterH, img.width, img.height);//imgArea.get(0, 0, img.width, img.height);
      
      /* combines graphic and image. set img as the combination */
      pg2.beginDraw();
      pg2.image(img2, 0, 0);
      pg2.image(pg, 0, 0);
      pg2.endDraw();
      
      img2 = pg2.get(0, 0, img2.width, img2.height);
    }
  }
}
