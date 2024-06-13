public class Stamp {
  private boolean stampDown = false;
  private PGraphics pg, pg2;
  private int w; //stamp width

  public Stamp() {
    pg = createGraphics(img2.width, img2.height);
    pg2 = createGraphics(img2.width, img2.height);
  }
  
  void mousePressed() {
    if (stampDown) {
      pg.beginDraw();
      pg.pushMatrix();
      imgArea.beginDraw();
      imgArea.pushMatrix();
      
      /* move pg pos to img pos */
      //pg.translate(-leftCenterW, -leftCenterH);
      imgArea.translate(-leftCenterW, -leftCenterH);
      
      w = img.width/3;
      int stampCenterX = mouseX-(w/2);
      int stampCenterY = mouseY-(w/6);
     
      imgArea.stroke(217, 4, 0);
      imgArea.strokeWeight(3);
      imgArea.fill(255);
      imgArea.rect(stampCenterX, stampCenterY, w, w/3); 
      imgArea.fill(217, 4, 0);
      
      String text = "CENSORED";
      imgArea.textSize(w/5);
      imgArea.text(text, (stampCenterX + ((w - textWidth(text)) / 6)), (stampCenterY + ((w/3 - (textDescent() - textAscent())) / 2 )));
      
      w = (int)(w / scaleFactor);
      stampCenterX = ((int)((mouseX-upLeftX) / scaleFactor)) - (w/2);
      stampCenterY = ((int)((mouseY-upLeftY) / scaleFactor)) - (w/6);
      
      pg.stroke(217, 4, 0);
      //pg.strokeWeight(3/scaleFactor);
      pg.strokeWeight(3);
      
      pg.fill(255);
      pg.rect(stampCenterX, stampCenterY, w, w/3); 
      pg.fill(217, 4, 0);
      
      pg.textSize(w/5);
      pg.text(text, (stampCenterX + ((w - textWidth(text)) / 6)), (stampCenterY + ((w/3 - (textDescent() - textAscent())) / 2 )));
  
      imgArea.popMatrix();
      imgArea.endDraw();
      pg.popMatrix();
      pg.endDraw();
      
      /* combines graphic and image. set img as the combination */
      pg2.beginDraw();
      pg2.image(img2, 0, 0);
      pg2.image(pg, 0, 0);
      pg2.endDraw();
      
      img2 = pg2.get(0, 0, img2.width, img2.height);
    }
  }
}
