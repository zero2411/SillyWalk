/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/
 http://codigogenerativo.com/code/kinectpv2-k4w2-processing-library/
 https://github.com/ThomasLengeling/KinectPV2
 https://github.com/antoine1000/kinect-skeleton/tree/master/Kinect_V2/skeleton_color_3D
 
 KinectPV2, Kinect for Windows v2 library for processing
 
 Skeleton color map example.
 Skeleton (x,y) positions are mapped to match the color Frame
 */


import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

SillyPose sillyPose;
SillySkeleton sillySkeleton;

PImage kinectImage;

Boolean mouseClicked = false;
float scale = 1.0;


void setup() {
  size(1024, 768, P3D);

  // Init the Kinect
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.enableSkeleton3DMap(true); //enable 3d  with (x,y,z) position
  kinect.init();

  // Init SillyPose
  sillyPose = new SillyPose();
}

void draw() {
  background(0);
  image(sillyPose.getPoseImage(), 128, 0, 768, 768);
  tint(255, 127);  // Display at half opacity
  image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeleton3DArray =  kinect.getSkeleton3d();

  // Iterate skeletons
  for (int i = 0; i < skeleton3DArray.size(); i++) {
    sillySkeleton = new SillySkeleton(skeleton3DArray.get(i));


    //KSkeleton skeleton3D = (KSkeleton) skeleton3DArray.get(i);
    if (sillySkeleton.isTracked()) {
      fill(0, 255, 0);
      ellipse(100, 100, 100, 100);

      //  KJoint[] joints = skeleton3D.getJoints();
      //  color col  = sillySkeleton.getIndexColor();
      fill(0, 0, 255);
      stroke(0, 0, 255);
      sillySkeleton.draw();

      if (mouseClicked) {
        sillySkeleton.saveSkeletonAsJson(sillyPose.getPoseNumber());
        mouseClicked = false;
      }
    } else {
      fill(255, 0, 0);
      ellipse(100, 100, 100, 100);
    }
  }

  fill(255, 0, 0);
  text(frameRate, 30, 10);
}


void mouseClicked() {
  mouseClicked = true;
}

void keyPressed() {
  if (key=='.') {
    sillyPose.increasePoseNumber();
  }
  if (key==',') {
    sillyPose.decreasePoseNumber();
  }
}   
