class Player {
  int id;
  final int ANIMATION_DURATION = 300; //in milliseconds
  int frame = 0;
  int frameMax = 2;
  int ticksLastUpdate = millis();
  int ticksLastAnimation = 0;  
  int[] playerClassList = {0, 1, 2, 3};
  int playerWidth = 32;
  int playerHeight = 32;
  PVector position;
  PVector velocity = new PVector(0, 0);
  float walkSpeed = 200;
  int direction = 4;
  int moveLeft;
  int moveRight;
  int moveUp;
  int moveDown;
  int playerClass;
  int hp;
  int mana;  
  int projectileSpeed;
  int projectileDamage;
  int score;
  boolean isDead;

  Player(int playerClass, int id) {
    isDead = false;
    this.playerClass = playerClass;
    this.id = id;
    score = 0;
    position = level.getSpawnLocation();
    switch(playerClass) { //set hp & mana
    case 0:
      hp = 10;
      projectileSpeed = 300;
      projectileDamage = 1;
      break;
    case 1:
      hp = 10;
      projectileSpeed = 250;
      projectileDamage = 2;
      break;
    case 2:
      hp = 10;
      projectileSpeed = 300;
      projectileDamage = 1;
      break;
    case 3:
      hp = 10;
      projectileSpeed = 300;
      projectileDamage = 1;
      break;
    }
  }

  void resetPosition() {
    position = level.getSpawnLocation();
  }

  void updateMovement() {
    rectMode(CENTER);
    ellipseMode(CENTER);
    if (hp > 0) { 
      // Alive
      velocity.x = walkSpeed * (moveLeft + moveRight) * float(millis() - ticksLastUpdate) * 0.001;
      velocity.y = walkSpeed * (moveUp + moveDown) * float(millis() - ticksLastUpdate) * 0.001;
      PVector nextPosition = new PVector(position.x, position.y);
      nextPosition.add(velocity);
      int[][] currentLayout = level.getCurrentTileLayout();
      float offset = 32 + playerWidth/2;
      if (currentLayout != null) {
        if (!(currentLayout[int((nextPosition.y)/32)][int((nextPosition.x+1-playerWidth/2)/32)] <= 15) && !(currentLayout[int((nextPosition.y)/32)][int((nextPosition.x-1+playerWidth/2)/32)] <= 15) && 
          !(currentLayout[int((nextPosition.y+1-playerWidth/2)/32)][int((nextPosition.x)/32)] <= 15) && !(currentLayout[int((nextPosition.y-1+playerWidth/2)/32)][int((nextPosition.x)/32)] <= 15) && 
          !(currentLayout[int((nextPosition.y+1-playerWidth/2)/32)][int((nextPosition.x+1-playerWidth/2)/32)] <= 15) && !(currentLayout[int((nextPosition.y+1-playerWidth/2)/32)][int((nextPosition.x-1+playerWidth/2)/32)] <= 15) && 
          !(currentLayout[int((nextPosition.y-1+playerWidth/2)/32)][int((nextPosition.x+1-playerWidth/2)/32)] <= 15) && !(currentLayout[int((nextPosition.y-1+playerWidth/2)/32)][int((nextPosition.x-1+playerWidth/2)/32)] <= 15)) {
          if (nextPosition.x > offset && nextPosition.x < (width - offset)) position.x = nextPosition.x;
          if (nextPosition.y > offset && nextPosition.y < (height - offset)) position.y = nextPosition.y;
        }
      }
      imageMode(CENTER);  
      image(spriteSheet.get((direction * 32) + (frame * 256), 0 + (playerClass * 32), 32, 32), position.x, position.y);
    } else
    {    
      // Dead
      isDead = true;
      velocity.x = 0;
      velocity.y = 0;
      imageMode(CENTER);  
      image(spriteSheet.get(1024, 0, 32, 32), position.x, position.y);
    }
    if (millis() - ticksLastAnimation >= ANIMATION_DURATION && (velocity.x != 0 || velocity.y != 0)) {
      frame++;
      if (frame >= frameMax) { 
        frame = 0;
      }     
      ticksLastAnimation += millis() - ticksLastAnimation;
    }
    ticksLastUpdate = millis();
  }

  void setDirection(int direction) {
    this.direction = direction;
  }

  void moveRight() {
    moveRight = 1;
  }

  void moveLeft() {
    moveLeft = -1;
  }

  void moveUp() {
    moveUp = -1;
  }

  void moveDown() {
    moveDown = 1;
  }

  void resetRight() {
    moveRight = 0;
  }

  void resetLeft() {
    moveLeft = 0;
  }

  void resetUp() {
    moveUp = 0;
  }

  void resetDown() {
    moveDown = 0;
  }

  void shootProjectile() {
    if (!isDead)
    {
      int offset = 20;
      Projectile proj;
      switch(direction) {
      default:
        proj = new Projectile(position.x, position.y, direction, projectileSpeed, playerClass, projectileDamage, id);
      case 0:
        proj = new Projectile(position.x, position.y - offset, direction, projectileSpeed, playerClass, projectileDamage, id);
        break;
      case 1:
        proj = new Projectile(position.x + offset, position.y - offset, direction, projectileSpeed, playerClass, projectileDamage, id);
        break;
      case 2:
        proj = new Projectile(position.x + offset, position.y, direction, projectileSpeed, playerClass, projectileDamage, id);
        break;
      case 3:
        proj = new Projectile(position.x + offset, position.y + offset, direction, projectileSpeed, playerClass, projectileDamage, id);
        break;
      case 4:
        proj = new Projectile(position.x, position.y + offset, direction, projectileSpeed, playerClass, projectileDamage, id);
        break;
      case 5:
        proj = new Projectile(position.x - offset, position.y + offset, direction, projectileSpeed, playerClass, projectileDamage, id);
        break;
      case 6:
        proj = new Projectile(position.x - offset, position.y, direction, projectileSpeed, playerClass, projectileDamage, id);
        break;
      case 7:
        proj = new Projectile(position.x - offset, position.y - offset, direction, projectileSpeed, playerClass, projectileDamage, id);
        break;
      }
      level.addProjectile(proj);
    }
  }

  int getHP()
  {
    return hp;
  }

  int getScore() {
    return score;
  }

  void pickUpItem(int itemType) {
    switch(itemType) {
    case 1:
      hp += 50;
      break;
    }
  }

  void addScore(int number) {
    score += number;
  }

  void getHit(int projectileDamage) {
    hp -= projectileDamage;
    if (hp < 0 ) hp = 0;
  }

  float getPosX() {
    return position.x;
  }

  float getPosY() {
    return position.y;
  }
  
  boolean getIsDead()
  {
    return isDead;
  }
}