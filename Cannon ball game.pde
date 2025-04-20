//Nikolayeva Darya
//Assignment 4
// Important! Please don't click when firing cannonball, only press and pull away.
//Otherwise program will close because of mouseclicked function.
//And mousePressed can't be used for last step to close sketch, because it's already used in other function
color color1= color(255, 0, 0);//red, not the target
color color2= color(0, 255, 0);//green, target
color color3= color (150, 150, 150);// ball color
color cliff= color(150, 100, 70);//cliff color
float minAngle=0;
float midAngle=180-3*PI/2;
float maxAngle=6*PI/4;
float circleX=150;
float circleY=200;
float circleD=35;
float lineX1;
float lineY1;
float lineX2;
float lineY2;
float lineX3;
float lineY3;
float cannonballX;
float cannonballY;
float cannonballD=35;
float distance;
float MAX_SPEED;
float MIN_SPEED;
float speed;
float angle;
float Degrees;
String speedOutcome;
String angleOutcome;
float t=1;
float colorRect;
boolean drop=false;
float wonRectangle;
boolean gameWon;
boolean gameDone=false;
void setup() {
  size(500, 500);
  colorRect=int(random(7));
  wonRectangle=220+(colorRect*40);
}
void draw() {
  if (gameDone==false) {
    background(255);
    rectangles();//draw rect
    drawOriginal();//draw cliff and etc
    Press();//pull away canon when mousepressed+angle+speed calculation
    if (drop==true) {//if released-update x and y with projectile path
      if (Degrees>=0 && Degrees<=90 && cannonballX>=0 && cannonballX<=500 && cannonballY>=0 && cannonballY<480 && t<4 ) {
        cannonballX=200+(distance* (cos(radians(Degrees))))*t;
        cannonballY=16*sq(t)+(distance*sin(radians(Degrees)))*t+300;
        circle(cannonballX, cannonballY, circleD);
        t=t+0.1;
        if (cannonballY>=470) {
          gameDone=true;
          gameOver();
          if (gameWon==true) {
            background(0);
            textSize(30);
            strokeWeight(5);
            stroke(255);
            text("You won", 200, 200);
            noFill();
            rect(150, 250, 200, 50);
            text("Click to exit", 170, 280);
            if (mousePressed && mouseX>=150 && mouseX<=350 && mouseY>=250 && mouseY<=300) {
              exit();
            }
          }
          if (gameWon==false) {
            background(0);
            textSize(30);
            strokeWeight(5);
            stroke(255);
            text("You lost", 200, 200);
            noFill();
            rect(150, 250, 200, 50);
            textSize(30);
            text("Click to exit", 170, 280);
            if (mousePressed && mouseX>=150 && mouseX<=350 && mouseY>=250 && mouseY<=300) {
              exit();
            }
          }
        }
      }
    }
  }
}




void rectangles() {//draw rectangles
  float rectX=220;
  float rectY=470;
  float rectW=40;
  float rectH=30;
  for (int i=0; i<7; i++) {
    if (i==colorRect) {
      fill(color2);
    } else {
      fill(color1);
    }
    rect(rectX, rectY, rectW, rectH);
    rectX=rectX+40;
  }
}
void drawOriginal() {// draws cliff and lines
  textSize(16);
  fill(0);
  text("Instructions:", 40, 30);
  text("1:To start, move cannonball away.", 40, 50);
  text("2:Change angle of projectile within the guides", 40, 70);
  text("3:Change speed of cannonball by pulling away", 40, 90);
  text("4:Release cannonball to fire shot", 40, 110);
  fill(150, 100, 70);
  rect(0, 200, 150, 300);
  fill(color3);
  circle(circleX, circleY, circleD);
  lineX1=circleX+circleD/2*cos(minAngle)+30;
  lineY1=circleY+circleD/2*sin(minAngle);
  lineX2=(circleX+circleD/2*cos(midAngle))+30;
  lineY2=circleY+circleD/2*sin(midAngle)-30;
  lineX3=circleX-circleD/2*cos(maxAngle);
  lineY3=circleY+circleD/2*sin(maxAngle)-30;
  line(circleX, circleY, lineX1, lineY1);
  line(circleX, circleY, lineX3, lineY3);
  strokeWeight(5);
  line(circleX, circleY, lineX2, lineY2);
  strokeWeight(1);
}

void mousePressed() {//when mouse is pressed not released
  drop=false;
}
void Press() {// when pressed pull away cannon and decide on speed and angle
  if (mousePressed ) {
    cannonballX=mouseX;
    cannonballY=mouseY;
    circle(cannonballX, cannonballY, cannonballD);
    line(circleX, circleY, cannonballX, cannonballY);
    if (mouseX>=0 && mouseX<=500 && mouseY>=0 && mouseY<=500) {
      distance=sqrt(sq(mouseX-circleX)+sq(mouseY-circleY));      // calculating distance=speed
      speed=distance;
      angle=(atan2(cannonballY-circleY, cannonballX-circleX));             // calculate angle
      Degrees=180-degrees(angle);                                // changes programming clockwise agles to normal counter clockwise
      speedOutcome="speed "+speed;
      angleOutcome="angle "+Degrees;
      textSize(20);
      fill(0);
      text(speedOutcome, 350, 100);
      text(angleOutcome, 350, 130);
    }
  }
}

void mouseReleased() {  // when mouse released change position of ball
  drop=true;
}
void gameOver() {
  if (cannonballX>=wonRectangle && cannonballX<=wonRectangle+40 && cannonballY>=470 && cannonballY<=500) {
    gameWon=true;
  }
  if (cannonballX>=220 && cannonballX<=500 && cannonballX>wonRectangle+40 && cannonballX<wonRectangle && cannonballY>=470 && cannonballY<=500) {
    gameWon=false;
  }
}
void mouseClicked() {
  exit();
}
