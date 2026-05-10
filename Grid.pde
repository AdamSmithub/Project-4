/**
 *      Author: Robert Dale
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-05-10
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Grid.pde
 * Description: A grid for objects to be placed in.
 */
class Grid  {
  
  int rWidth;    //room width
  int rHeight;   //room height
  
  public Grid(int rw, int rh) {
    rWidth = rw;
    rHeight = rh;
  }
  
  /**
   *      Method: draw()
   *  Parameters: void
   *      Return: void
   * Description: Draws the grid.
   */
  void draw() {
    pushStyle();
    stroke(255);
    for(int i = 0; i < rWidth; i++) {
       line((width/rWidth)*i, 0, (width/rWidth)*i, height);
    }
     for(int i = 0; i < rHeight; i++) {
       line(0, (height/rHeight)*i, width, (height/rHeight)*i);
    }
    popStyle(); 
  }
}
