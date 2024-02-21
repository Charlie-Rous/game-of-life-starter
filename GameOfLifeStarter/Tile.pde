public class Tile{
  private int val;
  private float rValue = 255;
  private float bValue = 0;
  private float colorConst = 20;
  private float xPos;
  private float yPos;
  private float size;
  
  public Tile(int val, float xPos, float yPos, float size) {
    this.val = val;
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
  }
  
  public void update() {
    rValue -= colorConst;
    bValue += colorConst;
    show();
  }
  
  private void show() {
    if (val == 1) {
      fill(rValue, 0, bValue);
    } else {
      fill(0,0,0);
    }
    square(xPos, yPos, size);
  }
  
  public void setVal(int val) {
    this.val = val;
  }
  
  
  public int getValue() {
    return val;
  }
  
}
