public class Stamp {
  private boolean stampDown = false;
  private PGraphics pg2;

  public Stamp() {
    pg2 = createGraphics(img.width, img.height);
  }
  
  void mousePressed() {
    if (stampDown) {
      pg.beginDraw();
      pg.translate(-leftCenterW, -leftCenterH);
      
      int a = img.width/3;
      
      int stampCenterX = mouseX-(a/2);
      int stampCenterY = mouseY-(a/6);
      pg.stroke(217, 4, 0);
      pg.strokeWeight(3);
      pg.fill(255);
      pg.rect(stampCenterX, stampCenterY, a, a/3); 
      pg.fill(217, 4, 0);
      pg.textSize(a/5);
      String text = "CENSORED";
      pg.text(text, (stampCenterX + ((a - textWidth(text)) / 6)), (stampCenterY + ((a/3 - (textDescent() - textAscent())) / 2 )));
  
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
