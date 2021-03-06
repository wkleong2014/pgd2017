class Item {
  int type;
  int posX;
  int posY;
  int itemWidth = TILE_SIZE;
  int itemHeight = TILE_SIZE;
  Item(int type, int posX, int posY) {
    this.type = type;
    this.posX = posX;
    this.posY = posY;
    drawObj();
  }

  void drawObj() {
    imageMode(CORNER);
    switch(type){ // Two types of items - Switch and Potion
      case 0:
        image(loadImage("switch.png"), posX, posY); // A statue that unlocks gates
        break;
      case 1:
        image(loadImage("potion.png"), posX, posY); // Potion that increases HP
        break;
    }    
  }

  int getPosX() {
    return posX;
  }

  int getPosY() {
    return posY;
  }

  int getItemWidth() {
    return itemWidth;
  }

  int getItemHeight() {
    return itemHeight;
  }
}