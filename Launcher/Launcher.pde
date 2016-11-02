Owi arm;

int i;
int angle;


void setup(){
  size(600,600);
  arm = new Owi();
}

void draw(){
  arm.calcArm(angle);
  arm.drawArm();
  arm.updateDashboard(angle);
  println(i);
}

void mouseWheel(MouseEvent event){
  i = event.getCount();
  angle = angle + 2*i;
  if (angle >= 90){
    angle = 90;
  }
  else if (angle <= -90){
    angle = -90;
  }
}