final int SPACING = 5; // each cell's width/height //<>// //<>//
final float DENSITY = 0.5; // how likely each cell is to be alive at the start
Tile[][] currentGrid; // 2D array of Tiles
ArrayList<Tile[][]> grids = new ArrayList<Tile[][]>();
int index = 0;
boolean playing = true;
Tile[][] lastGrid;

void setup() {
  size(1440, 850); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  currentGrid = new Tile[height / SPACING][width / SPACING];
  setupGrid(); // populate the grid

}

void draw() {
  if (playing) {
    if (index < grids.size() - 1) { // if you are stepping through old grids
      index++; // step to next grid
    } else {
      currentGrid = calcNextGrid(grids.get(index));
    }
    showGrid(grids.get(index));
  }
  
}

Tile[][] calcNextGrid(Tile[][] grid) {
  Tile[][] nextGrid = new Tile[grid.length][grid[0].length];
  for(int row = 0; row < grid.length; row++) {
    for(int col = 0; col < grid[row].length; col++) {
      if (grid[row][col].getValue() == 1) {// if square is alive
        int neighbors = countNeighbors(row, col, grid);
        if (neighbors == 2 || neighbors == 3 ){
          nextGrid[row][col] = grid[row][col];
        } else {
          nextGrid[row][col] = new Tile(0, SPACING * col, SPACING * row, SPACING);
        }
      } else if (countNeighbors(row, col, grid) == 3) { // if empty square has 3 neighbors
        nextGrid[row][col] = new Tile(1, SPACING * col, SPACING * row, SPACING);
      } else {
        nextGrid[row][col] = new Tile(0, SPACING * col, SPACING * row, SPACING);
      }
    }
  }
    grids.add(nextGrid);// save that grid in the arry of grids
    index++;
   return nextGrid;
   
   
}

int countNeighbors(int y, int x, Tile[][] grid) {
  int n = 0; // don't count yourself!
  for (int row = y - 1; row <= y + 1; row++) {
    for (int col = x - 1; col <= x + 1; col++) {
      if (row < 0) {
        row++;
      } else if (row >= grid.length) {
        return n; // there will be no more neighbors to be counted so n can be returned
      }
      if (col < 0) {
        col++;
      } else if (col >= grid[row].length) {
        break;
      }
      if (row != y || col != x) {
        n += grid[row][col].getValue() == 1? 1 : 0;
      }
    }
    
  }
  return n;
}

void setupGrid() {
  for (int row = 0; row < currentGrid.length; row++) {
    for(int col = 0; col < currentGrid[row].length; col++) {
      // chance based on Density to be alive at start
      if(Math.random() < DENSITY) {
        currentGrid[row][col] = new Tile(1, SPACING * col, SPACING * row, SPACING);
      } else {
        currentGrid[row][col] = new Tile(0, SPACING * col, SPACING * row, SPACING);
      }
    }
  }
  grids.add(currentGrid);
}

void showGrid(Tile[][] grid) {
  for (Tile[] row : grid) {
    for (Tile tile : row) {
      if (index == grids.size() - 1) {
        tile.update();
      } else {
        tile.show();
      }
      
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    playing = !playing; // pause game
  } else if (keyCode == RIGHT) {
    //step through one round at a time
    if ((index < grids.size() - 1 ) && grids.get(index + 1) != lastGrid) {
      index++;
    } else {
      currentGrid = calcNextGrid(grids.get(index));
    }
    showGrid(grids.get(index));
  } else if (keyCode == LEFT) {
    //step backwards
    index--;
    showGrid(grids.get(index));
    lastGrid = grids.get(grids.size() - 1);
  }
  
}
      
