class SillySkeleton {
  KSkeleton sillySkeleton;

  /**
   * Constructor
   */
  SillySkeleton(KSkeleton _sillySkeleton) {
    this.sillySkeleton = _sillySkeleton;
  }

  /**
   * Is skeleton tracked?
   */
  public Boolean isTracked() {
    return this.sillySkeleton.isTracked();
  }

  /** 
   * Draw the skeleton
   */
  public void draw() {
    this.drawBody(this.sillySkeleton.getJoints());
  }

  /**
   * Save Skeleton to JSON-file
   */
  void saveSkeletonAsJson(int _poseNumber) {
    int version = 1;
    String basePath = sketchPath("poses")+File.separator ;
    String fileName = "pose_"+_poseNumber;
    String fullPath = basePath+fileName+"_v"+version+".json";

    File f = new File(dataPath(fullPath));

    while (f.exists()) {
      version = version + 1;
      fullPath = basePath+fileName+"_v"+version+".json";
      println(fullPath+" - v:"+version);
      f = new File(dataPath(fullPath));
    }

    saveJSONArray(this.getSkeletonAsJson(), fullPath);
  }

  /**
   * create Json Array of Skeleton
   */
  private JSONArray getSkeletonAsJson() {
    JSONArray skeletonJson = new JSONArray();
    KJoint[] joints = this.sillySkeleton.getJoints();
    for (int j =0; j<joints.length; j++) {
      skeletonJson.setJSONObject(j, this.getJointAsJson(joints[j]));
    }
    return skeletonJson;
  }

  /**
   * create Json Object of Joint
   */
  private JSONObject getJointAsJson(KJoint _joint) {
    JSONObject jointJson = new JSONObject();
    jointJson.setFloat("x", _joint.getX());
    jointJson.setFloat("y", _joint.getY());
    jointJson.setFloat("z", _joint.getZ());
    jointJson.setFloat("type", _joint.getType());
    //jsonJoint.setFloat("position", joint.getPosition()));
    jointJson.setString("name", this.getJointName(_joint.getType()));
    jointJson.setString("string", _joint.toString());
    return  jointJson;
  }

  /**
   * DRAW BODY
   */
  private void drawBody(KJoint[] joints) {
    this.drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
    this.drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
    this.drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
    this.drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
    this.drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
    this.drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
    this.drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
    this.drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

    // Right Arm
    this.drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
    this.drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
    this.drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
    this.drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
    this.drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

    // Left Arm
    this.drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
    this.drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
    this.drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
    this.drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
    this.drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

    // Right Leg
    this.drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
    this.drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
    this.drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

    // Left Leg
    this.drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
    this.drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
    this.drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

    // Hands
    this.drawJoint(joints, KinectPV2.JointType_HandTipLeft);
    this.drawJoint(joints, KinectPV2.JointType_HandTipRight);
    this.drawJoint(joints, KinectPV2.JointType_ThumbLeft);
    this.drawJoint(joints, KinectPV2.JointType_ThumbRight);

    // Feet
    this.drawJoint(joints, KinectPV2.JointType_FootLeft);
    this.drawJoint(joints, KinectPV2.JointType_FootRight);

    // Head
    this.drawJoint(joints, KinectPV2.JointType_Head);
  }

  //draw joint
  private void drawJoint(KJoint[] joints, int jointType) {
    float x = map(joints[jointType].getX(), -1, 1, 0, width/scale);
    float y = map(joints[jointType].getY(), 0.7, -1.7, 0, height/scale);
    float z = 100;//map(joints[jointType].getZ(), 2.5, 3.2, 100,200);
    pushMatrix();
    translate(x, y, z);
    //translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
    ellipse(0, 0, 25, 25);
    popMatrix();
  }

  //draw bone
  private void drawBone(KJoint[] joints, int jointType1, int jointType2) {
    float x1 = map(joints[jointType1].getX(), -1, 1, 0, width/scale);
    float y1 = map(joints[jointType1].getY(), 0.7, -1.7, 0, height/scale);
    float z1 = 100; //map(joints[jointType1].getZ(), 2.5, 3.2, 100,200);
    float x2 = map(joints[jointType2].getX(), -1, 1, 0, width/scale);
    float y2 = map(joints[jointType2].getY(), 0.7, -1.7, 0, height/scale);
    float z2 = 100; 
    map(joints[jointType2].getZ(), 2.5, 3.2, 100, 200);
    pushMatrix();
    translate(x1, y1, z1);
    //translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
    ellipse(0, 0, 25, 25);
    popMatrix();
    strokeWeight(10);
    line(x1, y1, z1, x2, y2, z2);
    //line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
  }

  /**
   * Get the Joint Name
   */
  private String getJointName(int jointType) {
    String[] jointNames = {
      "SPINE_BASE", // #0
      "SPINE_MID", // #1
      "NECK", // #2
      "HEAD", // #3
      "SHOULDER_LEFT", // #4
      "ELBOW_LEFT", // #5
      "WRIST_LEFT", // #6
      "HAND_LEFT", // #7
      "SHOULDER_RIGHT", // #8
      "ELBOW_RIGHT", // #9
      "WRIST_RIGHT", // #10
      "HAND_RIGHT", // #11
      "HIP_LEFT", // #12
      "KNEE_LEFT", // #13
      "ANKLE_LEFT", // #14
      "FOOT_LEFT", // #15
      "HIP_RIGHT", // #16
      "KNEE_RIGHT", // #17
      "ANKLE_RIGHT", // #18
      "FOOT_RIGHT", // #19
      "SPINE_SHOULDER", // #20
      "HAND_TIP_LEFT", // #21
      "THUMB_LEFT", // #22
      "HAND_TIP_RIGHT", // #23
      "THUMB_RIGHT" //#24
    };
    return jointNames[jointType];
  }
}
