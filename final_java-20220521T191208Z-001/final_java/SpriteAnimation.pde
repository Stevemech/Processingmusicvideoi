public class SpriteAnimation {
  
  private PImage[] images;
  private int pos, skipFrames;
  private float w, h;
  private boolean repeat;
  
  //See comment at top of class for constructor parameter discussion
  public SpriteAnimation( String fileNameStart, 
      String nameNumbSeparator, String fileExtension,
      int lowImgNumb, int highImgNumb, int skipFrames,
      float w, float h, boolean repeat ) {
    
    int numbImages = highImgNumb - (lowImgNumb - 1);
    images = new PImage[numbImages];
    for(int i = 0; i < images.length; i++) {
      String fileName = fileNameStart + 
                        nameNumbSeparator +
                        (lowImgNumb + i) + "." +
                        fileExtension;
      images[i] = loadImage( fileName );
    }
    this.skipFrames = skipFrames;
    this.w = w;
    this.h = h;
    this.repeat = repeat;
    pos = 0;
  }
  
  /** Call this method over and over to advance the animation. */
  public void update() {
    if(frameCount%skipFrames == 0) {
      pos++;
    }
    
    if( repeat ) {
      pos %= images.length; 
    }
    else if( pos >= images.length ) {
      pos = images.length - 1; 
    }
  }
  
  /** Call this method to draw it at the location indicated
  *  by the parameters. The parameters are the top-left corner
  *  of the image if you are using Processing's CORNER for imageMode;
  *  if you switch the imageMode to CENTER, then the parameters
  *  represent the center of the image.
  */
  public void displayAt(float x, float y) {
    image(images[pos], x, y, w, h);
  }
}
