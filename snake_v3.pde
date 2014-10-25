
int boardSize = 10;
int[][] board = new int[boardSize][boardSize];
int w;
int h;

int headX;
int headY;
boolean playing = true;

boolean keyUp = false;
boolean keyDown = false;
boolean keyLeft = false;
boolean keyRight  = true;

int sLen = 3;
int maxLen = boardSize*boardSize;
//int[] snake = new int[maxLen];

void setup() {
  size(500, 500);
  boardSetup();
  w = width/boardSize;
  h = height/boardSize;
  println(w+" "+h);
  noStroke();
}
void draw() {
  background(255);
  for (int y = 0; y < board.length; y++) {
    for (int x = 0; x < board[y].length; x++) {

      if (board[y][x] > 0) {

        pushMatrix();
        translate(x*w, y*h);
        fill(0);
        rect(0, 0, w, h);
        fill(255);
        // text(board[y][x], w/2, h/2);
        popMatrix();
        if (!playing) {
          pushMatrix();
          translate(headX*w, headY*h);
          fill(255, 0, 0);
          rect(0, 0, w, h);
          fill(255);
          //text("X", w/2, h/2);
          popMatrix();
        }
      } else
        if (board[y][x] < 0) {

        pushMatrix();
        translate(x*w, y*h);
        fill(204);
        rect(0, 0, w, h);
        fill(0);
        // text(board[y][x], w/2, h/2);
        popMatrix();
      } else
      {

        pushMatrix();
        translate(x*w, y*h);
        fill(255);
        rect(0, 0, w, h);
        fill(0);
        // text(board[y][x], w/2, h/2);
        popMatrix();
      }
    }
  }
  checkKeys();
}

void boardSetup() {
  headX = 5;
  headY = 5;
  for (int i = sLen; i >= 0; i--) {
    board[headY][headX-(sLen-i)] = i;
  }
  randomFood();
}

void randomFood() {
  int rX = int(random(0, boardSize-1));
  int rY = int(random(0, boardSize-1));
  if (board[rY][rX] == 0) {
    board[rY][rX] = -1;
  } else {
    randomFood();
  }
}

void moveSnake(int dirX, int dirY) {
  if (board[wrapEdges(headY+(dirY*1))][wrapEdges(headX+(dirX*1))] <= 0 && playing) {
    if (board[wrapEdges(headY+(dirY*1))][wrapEdges(headX+(dirX*1))] < 0) {
      sLen += 1;
      randomFood();
    }

    for (int y = 0; y < board.length; y++) {
      for (int x = 0; x < board[int (y)].length; x++) {
        if (board[y][x] > 0) {
          board[y][x] -= 1;
        }
      }
    }
    headY += dirY;
    headX += dirX;

    headY = wrapEdges(headY);
    headX = wrapEdges(headX);

    board[headY][headX] = sLen;
  } else
    if (board[wrapEdges(headY+(dirY*1))][wrapEdges(headX+(dirX*1))]  != (sLen - 1)) {
    playing = false;
  }
}


int wrapEdges(int num) {
  //top
  if (num < 0) {
    return boardSize-1;
  } else
    //bottom
  if (num > boardSize-1) {
    return 0;
  } else
    return num;
}

void checkKeys() {
  if (frameCount%4 == 0) {
    if (keyUp) {
      moveSnake(0, -1);
    } else
      if (keyDown) {
      moveSnake(0, 1);
    } else
      if (keyLeft) {
      moveSnake(-1, 0);
    } else
      if (keyRight) {
      moveSnake(1, 0);
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (!keyUp && !keyDown) {
        keyUp = true;
        keyDown = false;
        keyLeft = false;
        keyRight  = false;
      }
    } else
      if (keyCode == DOWN) {
      if (!keyUp && !keyDown) {
        keyUp = false;
        keyDown = true;
        keyLeft = false;
        keyRight  = false;
      }
    } else
      if (keyCode == LEFT) {
      if (!keyLeft && !keyRight) {
        keyUp = false;
        keyDown = false;
        keyLeft = true;
        keyRight  = false;
      }
    } else
      if (keyCode == RIGHT) {
      if (!keyLeft && !keyRight) {
        keyUp = false;
        keyDown = false;
        keyLeft = false;
        keyRight  = true;
      }
    }
  }
}

