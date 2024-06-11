public class Stamp {
  private PGraphics pg2;

  public Stamp() {
    pg = createGraphics(img.width, img.height);
    pg2 = createGraphics(img.width, img.height);
  }
  
  void mousePressed() {
    pg.beginDraw();
    pg.pushMatrix();
    pg.translate(-leftCenterW, -leftCenterH);
    
    int a = img.width/3;
    int stampCenterX = mouseX-a;
    int stampCenterY = mouseY-a/3;
    pg.stroke(217, 4, 0);
    pg.strokeWeight(3);
    pg.fill(255);
    pg.rect(stampCenterX, stampCenterY, a, a/3); 
    pg.fill(217, 4, 0);
    pg.textSize(a/5);
    String text = "CENSORED";
    pg.text(text, (stampCenterX + ((a - textWidth(text)) / 2)), (stampCenterY + (a/5 - (-15 + (textAscent() - textDescent())))));

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

/*
void setup() {
  size(500, 500);
}
void draw(){}
void mousePressed() {
  println("SD");
    int stampCenterX = mouseX-100;
    int stampCenterY = mouseY-25;
    stroke(217, 4, 0);
    strokeWeight(4);
    fill(255);
    rect(stampCenterX, stampCenterY, 200, 50);
    fill(217, 4, 0);
    textSize(42);
    String text = "CENSORED";
    //text("CENSORED", stampCenterX, stampCenterY);
    text(text, (stampCenterX + ((200 - textWidth(text)) / 2)), (stampCenterY + (50 - (-10 + (textAscent() - textDescent())))));
    
}
*/
