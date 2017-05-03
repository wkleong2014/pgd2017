/* 
 Exercise 38: Make a Gauntlet-style game (Figure 4) for three (or more) simultanious player1s. Your implementation does not need to be (and should not be) a clone, 
 but an original and modern reinterpretation. Make a playable, interesting and finished game (include, at least, starting the game, winning/losing, score, 
 restart, 16 levels, various kinds of enemies). As the original, it is top-down 2D, non-splitscreen; the player1 characters have different abilities and 
 strengths, and use projectile weapons (not e.g. lasers) as distance weapons. Use one (or several) sprite sheet(s) for the graphics. 
 Save and load a hiscore list with ten entries. As stated above, use the time fix, and use classes and objects. Work in two-person teams
 
 Program Title: 
 Program Description: 
 
 Author: Leong Wei Kong & Nicholas Tan Joo Sin
 Reference: XXX
 Developer Notes: XXX
 */

PFont font1;
PFont font2;
Player player1;
Player player2;
Level level;
final int tileSize = 32;
boolean isWPressed = false;
boolean isAPressed = false;
boolean isDPressed = false;
boolean isSPressed = false;

void setup() {
  size(640, 640);

  //font1 = createFont("tamagotchi.ttf", 35);
  //font2 = createFont("tamagotchi.ttf", 35);
  player1 = new Player(0);
  player2 = new Player(1);
  level = new Level();
}

void draw() {
  fill(100);
  rect(0, 0, 500, 500);
  noStroke();
  level.update();
  if (level.hasEnded()) {
    rectMode(CORNERS);
    fill(0);
    rect(0, 0, 640, 640);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("GAME OVER", width/2, height/2);
  }
}

void keyPressed() {
  //nextStage
  if (char(keyCode) == 'M') {
    level.currentLevel++;
  }
  
  //Player 1
  if (char(keyCode) == 'W') {
    player1.moveUp();
    isWPressed = true;
    player1.setDirection(0);
  }
  if (char(keyCode) == 'S') {
    player1.moveDown();
    isSPressed = true;
    player1.setDirection(4);
  }
  if (char(keyCode) == 'A') {
    player1.moveLeft();
    isAPressed = true;
    player1.setDirection(6);
  }
  if (char(keyCode) == 'D') {
    player1.moveRight();
    isDPressed = true;
    player1.setDirection(2);
  }
  if (char(keyCode) == 'A' && isWPressed || char(keyCode) == 'W' && isAPressed) player1.setDirection(7);
  if (char(keyCode) == 'D' && isWPressed || char(keyCode) == 'W' && isDPressed) player1.setDirection(1);
  if (char(keyCode) == 'A' && isSPressed || char(keyCode) == 'S' && isAPressed) player1.setDirection(5);
  if (char(keyCode) == 'D' && isSPressed || char(keyCode) == 'S' && isDPressed) player1.setDirection(3);
  
  //Player 2
  if (char(keyCode) == UP) {
    player2.moveUp();
  }
  if (char(keyCode) == DOWN) {
    player2.moveDown();
  }
  if (char(keyCode) == LEFT) {
    player2.moveLeft();
  }
  if (char(keyCode) == RIGHT) {
    player2.moveRight();
    //player1.direction = -1;
  }
}

void keyReleased() {
  //Player 1
  if (char(keyCode) == 'W') {
    player1.resetUp();
    isWPressed = false;
  }
   
  if (char(keyCode) == 'S') {
    player1.resetDown();
    isSPressed = false;
  }
  if (char(keyCode) == 'A') {
    player1.resetLeft();
    isAPressed = false;
  }
  if (char(keyCode) == 'D') {
    player1.resetRight();
    isDPressed = false;
  }

  //Player 2
  if (char(keyCode) == UP) {
    player2.resetUp();
  }
  if (char(keyCode) == DOWN) {
    player2.resetDown();
  }
  if (char(keyCode) == LEFT) {
    player2.resetLeft();
  }
  if (char(keyCode) == RIGHT) {
    player2.resetRight();
  }
}