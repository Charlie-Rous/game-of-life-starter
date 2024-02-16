final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's

void setup() {
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];
  setupGrid();

  // populate initial grid
  // your code here

}

void draw() {
  showGrid();
  grid = calcNextGrid();
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  for(int row = 0; row < grid.length; row++) {
    for(int col = 0; col < grid[row].length; col++) {
      if (grid[row][col] == 1) {
        switch (countNeighbors(row, col)){
          case 2 :
            nextGrid[row][col] = 1;
            break;
          case 3 :
            nextGrid[row][col] = 1;
            break;
        }
      } else if (countNeighbors(row, col) == 3) {
          nextGrid[row][col] = 1;
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
        n += grid[row][col] == 1? 1 : 0;
      }
    }
    
  }
  return n;
}
void setupGrid() {
  for (int row = 0; row < grid.length; row++) {
    for(int col = 0; col < grid[row].length; col++) {
      if(Math.random() < DENSITY) {
        grid[row][col] = 1;
      } else {
        grid[row][col] = 0;
      }
    }
  }
}
      
void showGrid() {
  // your code here
  for (int row = 0; row < grid.length; row++) {
    for(int col = 0; col < grid[row].length; col++) {
      if(grid[row][col] == 1) {
        fill(255, 0, 0);
        square(SPACING * col, SPACING * row, SPACING);
      } else {
        fill(0, 0, 0);
        square(SPACING * col, SPACING * row, SPACING);
      }
    }
  }
           
  // use square() to represent each cell
  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
}
