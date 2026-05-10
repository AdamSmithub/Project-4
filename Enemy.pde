/**TODO:DRAW METHOD
 *      Author: Adam Smith and Jack WIlson
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-05-10
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Enemy.pde
 * Description: An enemy that tries to attack the player.
 */
class Enemy extends Actor
{
  WorldObject room[][];
  Position position;
  int playerX;
  int playerY;
  
  /**
   * Constructor: public Enemy()
   * Parameters: JSONObject json - Pre-existing data to be loaded.
   *             WorldObject[][] room - The current room layout used to figure out where everything is.
   *             Position position - The starting position of the enemy.
   * Description: Constructs an enemy using existing JSON data. 
   */
  Enemy(JSONObject json, WorldObject[][] room, Position position)
  {
    super(json.getJSONObject("super"));
    this.room=room;
    this.position=position;
  }

  /**
   * Constructor: public Enemy()
   * Parameters: Direction direction - The starting direction.
   *             WorldObject[][] room - The current room layout used to figure out where everything is.
   *             Position position - The starting position of the enemy.
   * Description: Constructs an enemy from scratch. 
   */
  Enemy(Direction direction, WorldObject[][] room, Position position)
  {
    super(100, 10, direction);
    this.room=room;
    this.position=position;
  }
  
  /**
   *      Method: void draw()
   *  Parameters: void
   *      Return: void
   * Description: Draws the enemy.
   */
  public void draw()
  {
    pushStyle();
    fill(200, 0, 0);
    ellipse(0, 0, 50, 50);
    popStyle();
    
    //draws a line to show facing
    switch(this.facing) {
      case NORTH:
        line(0, 0, 0, -100);
        break;
  
      case EAST:
        line(0, 0, 100, 0);
        break;
  
      case SOUTH:
        line(0, 0, 0, 100);
        break;
  
      case WEST:
        line(0, 0, -100, 0);
        break;   
    }
  }
  
  /**
   *      Method: serialize()
   *  Parameters: void
   *      Return: JSONObject obstacleData - very basic data for the obstacle
   * Description: Turns the enemy into a JSONObject
   */
  public JSONObject serialize()
  {
    JSONObject json=new JSONObject();
    json.setJSONObject("super", super.serialize());
    return json;
  }
  
  /**
   *      Method: getPlayerDirection()
   *  Parameters: void
   *      Return: Direction - the direction of the player relative to the enemy.
   * Description: Finds the direction to face to get to the player.
   */
  private Direction getPlayerDirection()
  {
    int dx = playerX - position.getX();
    int dy = playerY - position.getY();
    
    //moving
    if(abs(dx)>abs(dy)) {
      return dx < 0 ? Direction.WEST: Direction.EAST;
    } else {
      return dy < 0? Direction.NORTH: Direction.SOUTH;
    }
  }
  
  /**
   *      Method: keyPressed()
   *  Parameters: void
   *      Return: void
   * Description: Stuff that happens when keys are pressed.
   */
  void keyPressed()
  {
    getAction();
  }
  
  /**
   *      Method: public getAction()
   *  Parameters: void
   *      Return: Action - What the enemy wants to do.
   * Description: The enemy's pathfinding.
   */
  public Action getAction()
  {
    for(int i=0; i<room.length; i++)
    {
      for (int j=0; j<room[0].length; j++)
      {
        if(room[i][j] instanceof Player)
        {
          playerX=i;
          playerY=j;
        }
      }
    }
    
    Direction dir = getPlayerDirection();
    
    int tx = position.getX() + dir.x;
    int ty = position.getY() + dir.y;
    
    if(tx < 0 || tx >= room.length || ty < 0 || ty >= room[0].length)
    {
      return null;
    }
    
    if(room[tx][ty] instanceof Player) {
      switch(dir)
      {
        case NORTH: return Action.ATTACK_NORTH;
        case SOUTH: return Action.ATTACK_SOUTH;
        case EAST: return Action.ATTACK_EAST;
        case WEST: return Action.ATTACK_WEST;
      }
    }
    switch(dir)
    {
        case NORTH: return Action.MOVE_NORTH;
        case SOUTH: return Action.MOVE_SOUTH;
        case EAST: return Action.MOVE_EAST;
        case WEST: return Action.MOVE_WEST;
    }
    return null;
  }
}
