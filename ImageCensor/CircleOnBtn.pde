/* visual for pen size adjustment */
public class CircleOnBtn extends Button {
  private boolean hide = true;
  private int diameter;
  
  public CircleOnBtn(float x, float y, float btnWidth, float btnHeight, float padding, String text, float fontSize, color c, String function, int diameter) {
    super(x, y, btnWidth, btnHeight, padding, text, fontSize, c, function);
    this.diameter = diameter;
  }
  
  void draw(){
    if (!hide) {
      textAlign(LEFT);
      strokeWeight(1);
      stroke(255);
      super.drawBtn(super.c, 55);
      drawCircle(10);
      
      if (super.onButton() || (penSize == diameter)) {
        /* darken on hover or when in use */
        super.drawBtn(200, 0);
        drawCircle(0);
        
        /* blackens when directly clicked. changes pen size based off circle size */
        if (mousePressed && super.onButton() && !super.mouseDragged){
          fill(0);
          rect(super.x, super.y, super.w, super.h);
          penSize = diameter;
        }
      }
    }
  }
  
  private void drawCircle(color circleColor) {
    stroke(0);
    fill(circleColor);
    circle((super.x + (super.w / 2)), (super.y + (super.h / 2)), diameter);
  }

}
