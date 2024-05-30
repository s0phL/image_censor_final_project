PGraphics pg;
PImage img, imgCopy;
int zoomSize = 2;
int zoomCount = 0;
int thingX; // image centered at mouse x
int thingY; 

int xStart;
int yStart;

void setup() {
  //size(342, 400);
  size(1000, 500);
  img = loadImage("bird.jpg");
  img.resize(342, 400);
  rect(0, 0, 342, 400);
  image(img, 0, 0);
  pg = createGraphics(img.width*2, img.height*2);
  //pg = createGraphics(img.width, img.height);
}

void draw() {
  //println(mouseX, mouseY);
}

void keyPressed() {
  //OutOfMemoryError @ img.height == 12800
  if (key == 'a') {
    img.resize(img.width*zoomSize, img.height*zoomSize);
    //image(img, mouseX-img.width, mouseY-img.height);
    //image(img, 0, 0);
    //image(img, 0-(mouseX*(zoomSize-1)), 0-(mouseY*(zoomSize-1)));
    zoomCount++;
    println(0-(mouseX*(zoomSize-1)), 0-(mouseY*(zoomSize-1)));
    println(0-(mouseX*((int)(Math.pow(zoomSize, zoomCount)))-mouseX), 
            0-(mouseY*((int)(Math.pow(zoomSize, zoomCount)))-mouseY));
    thingX = 0-(mouseX*((int)(Math.pow(zoomSize, zoomCount)))-mouseX);
    thingY = 0-(mouseY*((int)(Math.pow(zoomSize, zoomCount)))-mouseY);
    image(img, thingX, thingY);
    println(img.height);
  }
  
  if (key == 'b') {
    //thingX = 0+(mouseX/((int)(Math.pow(zoomSize, zoomCount)))+mouseX);
    //thingY = 0+(mouseY/((int)(Math.pow(zoomSize, zoomCount)))+mouseY);
    img.resize(img.width/zoomSize, img.height/zoomSize);
    image(img, thingX, thingY);
  }
  
  if (key == 'r') {
    //background(100);
    img.resize(342, 400);
    image(img, 0, 0);
  }
}

void mousePressed() {
  xStart = mouseX;
  yStart = mouseY;
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    line(pmouseX, pmouseY, mouseX, mouseY);
    pg.beginDraw();
        //pg.pushMatrix();

    //pg.translate(342/2, 400/2);
    pg.line(pmouseX, pmouseY, mouseX, mouseY);
    //pg.popMatrix();
    pg.endDraw();
    pg.save("test.png");
  }
  if (mouseButton == RIGHT) {
    //background(150);
    image(img, thingX+(mouseX-xStart), thingY+(mouseY-yStart));
  }
}

void mouseReleased() {
  thingX += (mouseX-xStart);
  thingY += (mouseY-yStart);
  
  pg.beginDraw();
  pg.image(img, thingX, thingY);
  pg.image(pg, 0, 0);
  pg.endDraw();
  
  img = pg.get(0, 0, img.width, img.height);
}
