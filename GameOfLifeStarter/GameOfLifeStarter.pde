final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
Tile[][] grid; // the 2D array to hold 0's and 1's

void setup() {
  size(1000, 1000); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  grid = new Tile[height / SPACING][width / SPACING];
  setupGrid();

  // populate initial grid
  // your code here

}

void draw() {
  showGrid();
  grid = calcNextGrid();
}

Tile[][] calcNextGrid() {
  Tile[][] nextGrid = new Tile[grid.length][grid[0].length];
  for(int row = 0; row < grid.length; row++) {
    for(int col = 0; col < grid[row].length; col++) {
      
      if (grid[row][col].getValue() == 1) {
        switch (countNeighbors(row, col)){
          case 2 :
            nextGrid[row][col] = grid[row][col];
            break;
          case 3 :
            nextGrid[row][col] = grid[row][col];
            break;
          default :
            nextGrid[row][col] = new Tile(0, SPACING * col, SPACING * row, SPACING);
            break;
          
        }
      } else if (countNeighbors(row, col) == 3) {
        nextGrid[row][col] = new Tile(1, SPACING * col, SPACING * row, SPACING);
      } else {
        nextGrid[row][col] = new Tile(0, SPACING * col, SPACING * row, SPACING);
      }
    }
  }
   return nextGrid;
   
   
}

int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!
  for (int row = y - 1; row <= y + 1; row++) {
    for (int col = x - 1; col <= x + 1; col++) {
      if (row < 0) {
        row++;
      } else if (row >= grid.length) {
        return n;
      }
      if (col < 0) {
        col++;
      } else if (col >= grid[row].length) {
        break;
      }
      if ( row != y || col != x) {
        n += grid[row][col].getValue() == 1? 1 : 0;
      }
    }
    
  }
  return n;
}

void setupGrid() {
  for (int row = 0; row < grid.length; row++) {
    for(int col = 0; col < grid[row].length; col++) {
      if(Math.random() < DENSITY) {
        grid[row][col] = new Tile(1, SPACING * col, SPACING * row, SPACING);
      } else {
        grid[row][col] = new Tile(0, SPACING * col, SPACING * row, SPACING);
      }
    }
  }
}

void showGrid() {
  for (Tile[] row : grid) {
    for (Tile tile : row) {
      tile.update();
    }
  }
}
      
