/**TODO:DRAW METHOD
 *      Author: Adam Smith and Robert Dale
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-04-09
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Obstacle.pde
 * Description: An obstacle that blocks paths.
 */
class Obstacle extends WorldObject
{
  int IDX;
  int IDY;
  boolean updated = false;

   /**
   * Constructor: public Obstacle()
   *  Parameters: void
   * Description: Constructs an obstacle.
   */
  Obstacle()
  {

  }

  /**
  //TODO: Make updated reset for all rocks at end of reset
  void update (ArrayList <ArrayList <Position>> Positions)
  {
    RockCount++;
    if (updated == false)
    {

      updated = true;
      for (int i=-1; i<=1; i++)
      {
        for (int j=-1; j<=1; j++)
        {
          if (Positions.get(i).get(j).getSpaceType()="Obstacle")
          {
            Positions.get(i).get(j).update();
          }
        }
      }
    }





    JSONObject json;
    {
      json=new JSONObject();
      json.setInt("X position", PosX);
      json.setInt("Y position", PosY);
    }
  }//TODO: FINISH SERIALIZE METHOD
  **/
  
  /**
   *      Method: serialize()
   *  Parameters: void
   *      Return: JSONObject obstacleData - very basic data for the obstacle
   * Description: Turns the Obstacle into a JSONObject
   */

  JSONObject serialize() {
   JSONObject obstacleData = new JSONObject();
   obstacleData.setString("className", "Obstacle");
   return obstacleData;
  }

  /**
   *      Method: void draw()
   *  Parameters: void
   *      Return: void
   * Description: Draws the obstacle.
   */

  void draw() {
    pushStyle();
    rectMode(CENTER);
    fill(200);
    rect(0, 0, 50, 50);
    popStyle();
  }
}
