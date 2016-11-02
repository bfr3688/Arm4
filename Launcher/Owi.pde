class Owi {

  int[] origin = { 100, 500 };
  int segmentLength = 100;

  float xOne, yOne, xTwo, yTwo, xThree, yThree;
  int xOrigin = origin[0];
  int yOrigin = origin[1]; 
  float pointTwoXPosition, pointTwoYPosition;
  float pointTwoXPositionTemp, pointTwoYPositionTemp;
  int angle;
  float vectorPointTwoX, vectorPointTwoY, vectorPointThreeX, vectorPointThreeY;
  float mouseXPositionTemp, mouseYPositionTemp, mouseXPosition, mouseYPosition;
  

  float thetaZeroGlobal, thetaOneGlobal, thetaTwoGlobal;
  int thetaZeroLocal, thetaOneLocal, thetaTwoLocal;

  int i; // used for mouse

  Owi() {
  }

  void drawArm() {
    background(255);
    strokeWeight(14);
    stroke(100, 0, 100);
    line(xOrigin, yOrigin, xOne, yOne); // humerous
    stroke(0, 100, 100);
    line(xOne, yOne, xTwo, yTwo); // Unla
    line(xTwo, yTwo, xThree, yThree);
    //circles
    strokeWeight(4);
    stroke(0, 0, 0);
    fill(245, 255, 166);
    ellipse(xOrigin, yOrigin, 20, 20);
    ellipse(xOne, yOne, 20, 20);
    ellipse(xTwo, yTwo, 20, 20);
    ellipse(xThree, yThree, 20, 20);
  }

  void calcArm(int angle)
  {
    mouseXPositionTemp = mouseX;
    mouseYPositionTemp = mouseY;
    
    vectorPointThreeX = segmentLength * cos(radians(-(float)angle)); //not a scalar!
    vectorPointThreeY = segmentLength * sin(radians(-(float)angle));

    println("vector Y", vectorPointThreeY);

    pointTwoXPositionTemp = (float)mouseX - vectorPointThreeX;
    pointTwoYPositionTemp = (float)mouseY - vectorPointThreeY;

    println("y", pointTwoYPositionTemp);

    if (mouseXPositionTemp >= xOrigin && mouseYPositionTemp <= yOrigin) {
      if (pointTwoXPositionTemp >= xOrigin && pointTwoYPositionTemp <= yOrigin) {
        mouseXPosition = mouseX;
        mouseYPosition = mouseY;
       } 
      else if (pointTwoXPositionTemp < xOrigin && pointTwoYPositionTemp < yOrigin) {
        mouseXPosition = xOrigin + vectorPointThreeX;
        mouseYPosition = mouseY;
      } 
      else if (pointTwoXPositionTemp > xOrigin && pointTwoYPositionTemp > yOrigin) {
        mouseXPosition = mouseX;
        mouseYPosition = yOrigin - abs(vectorPointThreeY);
      }
      else {
        mouseXPosition = xOrigin + vectorPointThreeX;
        mouseYPosition = yOrigin - abs(vectorPointThreeY);
      }
    }
    else if (mouseX < xOrigin && mouseY < yOrigin){
      if (pointTwoXPositionTemp >= xOrigin && pointTwoYPositionTemp <= yOrigin) {
        mouseXPosition = mouseX;
        mouseYPosition = mouseY;
      } 
      else if (pointTwoXPositionTemp < xOrigin && pointTwoYPositionTemp < yOrigin) {
        mouseXPosition = xOrigin + vectorPointThreeX;
        mouseYPosition = mouseY;
      } 
      else if (pointTwoXPositionTemp > xOrigin && pointTwoYPositionTemp > yOrigin) {
        mouseXPosition = mouseX;
        mouseYPosition = yOrigin - abs(vectorPointThreeY);
      }
      else {
        mouseXPosition = xOrigin + vectorPointThreeX;
        mouseYPosition = yOrigin - abs(vectorPointThreeY);
        println("p4");
      }
    }
    else if(mouseX > xOrigin && mouseY > yOrigin){
      mouseXPositionTemp = mouseX;
      mouseYPositionTemp = yOrigin;
      pointTwoXPositionTemp = mouseXPositionTemp - vectorPointThreeX;
      pointTwoYPositionTemp = mouseYPositionTemp - vectorPointThreeY;
      
      if (pointTwoXPositionTemp >= xOrigin && pointTwoYPositionTemp <= yOrigin) {
        mouseXPosition = mouseX;
        mouseYPosition = yOrigin;
        println("px1");
      } 
      else if (pointTwoXPositionTemp >= xOrigin && pointTwoYPositionTemp > yOrigin) {
        mouseXPosition = mouseX;
        mouseYPosition = yOrigin - abs(vectorPointThreeY);
        println("px2");
      } 
      
      //println("pointTwoXPositionTemp",pointTwoXPositionTemp);
      //println("pointTwoYPositionTemp",pointTwoYPositionTemp);
      //else if (pointTwoXPositionTemp < xOrigin && pointTwoYPositionTemp < yOrigin) {
      //  mouseXPosition = xOrigin;
      //  mouseYPosition = yOrigin + vectorPointThreeY;
      //} 
      //else if (pointTwoXPositionTemp < xOrigin && pointTwoYPositionTemp > yOrigin) {
      //  mouseXPosition = mouseX;
      //  mouseYPosition = yOrigin - abs(vectorPointThreeY);
      //}
      //else {
      //mouseXPosition = mouseX;
      //mouseYPosition = yOrigin;
      //}
    }


    pointTwoXPosition = (float)mouseXPosition - vectorPointThreeX;
    pointTwoYPosition = (float)mouseYPosition - vectorPointThreeY;

    float pointTwoXComponent = pointTwoXPosition - xOrigin;
    float pointTwoYComponent = pointTwoYPosition - yOrigin;
    float radiusPointTwo = sqrt(sq(pointTwoXComponent) + sq(pointTwoYComponent));

    vectorPointTwoX = pointTwoXComponent / radiusPointTwo;
    vectorPointTwoY = pointTwoYComponent / radiusPointTwo;

    float limit = 2 * segmentLength - radiusPointTwo;

    if (limit < 0)
    {
      xOne = xOrigin + vectorPointTwoX * segmentLength;
      yOne = yOrigin + vectorPointTwoY * segmentLength;
      xTwo = xOrigin + vectorPointTwoX * segmentLength * 2;
      yTwo = yOrigin + vectorPointTwoY * segmentLength * 2;
      xThree = xTwo + vectorPointThreeX;
      yThree = yTwo + vectorPointThreeY;
    } else 
    {
      xOne = xOrigin + vectorPointTwoX * radiusPointTwo / 2;
      yOne = yOrigin + vectorPointTwoY * radiusPointTwo / 2;
      xTwo = pointTwoXPosition;
      yTwo = pointTwoYPosition;
      float normalMagnitude = -sqrt(sq(segmentLength)-sq(radiusPointTwo/2));

      //normalMagnitude =- normalMagnitude; // Make it a negative number

      xOne -= vectorPointTwoY * normalMagnitude;
      yOne += vectorPointTwoX * normalMagnitude;
      xThree = mouseXPosition;
      yThree = mouseYPosition;
    }
    thetaZeroGlobal = abs(round(degrees(atan((yOne-yOrigin)/(xOne-xOrigin)))));
    thetaZeroLocal = (int)thetaZeroGlobal;
    thetaOneGlobal = round(degrees(atan((yTwo-yOne)/(xTwo-xOne))));
    thetaOneLocal = (int)(thetaZeroGlobal - (float)thetaOneGlobal);
    thetaTwoLocal = angle + (int)round(thetaOneGlobal);
  }

  void updateDashboard(int angle) {
    textSize(20);
    fill(0);
    text ("Gripper Coordinates", 200, 100);
    text ("(" + round(xThree - 100) + "," + round(500 - yThree) + ")", 400, 100);
    text ("mm", 500, 100);
    text ("angle 0", 300, 130);
    text (thetaZeroLocal, 420, 130);
    text ("degrees", 500, 130);
    text ("angle 1", 300, 160);
    text (thetaOneLocal, 420, 160);
    text ("degrees", 500, 160);
    text ("angle 2", 300, 190);
    text (thetaTwoLocal, 420, 190);
    text ("degrees", 500, 190);
    text ("angle horz.", 300, 220);
    text (angle, 420, 220);
    text ("degrees", 500, 220);
  }
}