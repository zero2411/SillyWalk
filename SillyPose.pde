class SillyPose {
  private int poseNumber;
  private PImage poseImage;
  private String poseImagePath = "C:/Users/r.zegwaard/Dropbox/Documenten/Processing/Silly Walk/Images/poses/";


  /**
   * Constructor
   */
  SillyPose() {
    this.poseNumber = 1;
    this.update();
  }
  
  /**
   * Get the Pose Number
   */
  public int getPoseNumber() {
    return this.poseNumber;
  }
  
  /**
   * Get the Pose Image
   */
  public PImage getPoseImage() {
    return this.poseImage;
  }
  
  /**
   * Update
   */
  public void update() {
    this.poseImage = loadImage(this.poseImagePath + "pose-" + this.poseNumber + ".png");
  }

  /**
   * Increase pose number
   */
  public void increasePoseNumber() {
    if (this.poseNumber < 12) {
      this.poseNumber ++;
      this.update();
    }
  }

  /**
   * Decrease pose number
   */
  public void decreasePoseNumber() {
    if (this.poseNumber > 1) {
      this.poseNumber --;
      this.update();
    }
  }
  
  
}
