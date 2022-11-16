int moveX, moveY, ballX, ballY, score;  //movexy= how fast xy axis increases; ballxy= current pos of ball

void resetGame() {
  ballX = width/2;
  if (moveX < 0) {
    moveX = -moveX;
  }
  score = 0;
}

void setup() {
  size(500, 500);
  rectMode(CENTER);
  moveX = 5;
  moveY = 5;
  ballX = width/2;
  ballY = height/2;
}

void draw() {
  background(0);

  //bat
  fill(150);
  final float batW = width*0.05;
  final float batH = height*0.3;
  rect(width-(batW/2), mouseY, batW, batH);  //makesure to shift half rec width bc off screen, messes up bounce

  //ball
  final int ballR = 25;
  fill(250);
  ellipse(ballX, ballY, ballR*2, ballR*2);

  //game rules
  if (ballX<ballR) {  //if left wall
    moveX = -moveX;
    score++;
  } else if (ballX>width+ballR) {  //if right wall
    println("You got " + score + " points.");
    resetGame();
  } else if (ballX > (width-ballR-batW) && ballY<=mouseY+batH/2 && ballY>=mouseY-batH/2) {  //if at bat width & between bat bottom & top
    //making batH is too lenient
    moveX = -abs(moveX);
  }
  if (ballY>height-ballR  || ballY<0+ballR) {  //if top or bottom wall
    moveY = -moveY;
  }

  ballX += moveX;
  ballY += moveY;  //change once bat skew is added, moves right and left initially until hit by skew

  //some bug when mouse is off screen as it takes the last mouseY pos D:
  //same repetition of ball pattern :(

  //println("ballX = " + ballX + ", ballY = " + ballY);
}

//if positive velocity of ball then read collision otherwise no,
//then add if top half, skew y up and if bottom half, skew y down, if dead centre, only move x (so do nothing)
