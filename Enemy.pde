class Enemy extends Actor
{
  WorldObject room[][];
  Position position;
  //player's coordinates
  int playerX;
  int playerY;
  //enemy's coordinates
  int enemyX;
  int enemyY;
  //jsonobject constructor
  Enemy(JSONObject json, WorldObject[][] room)
  {
    super(json.getJSONObject("super"));
    this.room=room;
  }
  //default constructor
  Enemy(Direction direction, WorldObject[][] room)
  {
    super(100, 10, direction);
    this.room=room;
  }
  /**
   *      Method: Draw
   *  Parameters: No
   *      Return: void
   * Description: draws enemy
   */
  public void draw()
  {
    pushStyle();
    fill(200, 0, 0);
    ellipse(0, 0, 50, 50);
    popStyle();
  }
  /**
   *      Method: serialize()
   *  Parameters: none
   *      Return: json
   * Description: serializes to json
   */
  public JSONObject serialize()
  {
    JSONObject json=new JSONObject();
    json.setJSONObject("super", super.serialize());
    return json;
  }
  /**
   *      Method: getPlayerDirection()
   *  Parameters: none
   *      Return: direction
   * Description: returns direction in which player is farthest
   */
  private Direction getPlayerDirection()
  {
    int dx=playerX-enemyX;
    int dy=playerY-enemyY;
    if(abs(dx)>abs(dy))
    {
    return dx<0?Direction.WEST:Direction.EAST;
    }
    else return dy<0?Direction.NORTH:Direction.SOUTH;
  }
  
  void keyPressed()
  {
    getAction();
  }
      
   /**
   *      Method: getAction()
   *  Parameters: none
   *      Return: action
   * Description: constructs action from a direction and a boolean
   */   
  public Action getAction()
  {
    for(int i=0; i<room.length; i++)
    {
      for(int j=0; j<room[0].length; j++)
      {
        if(room[i][j]==this)
        {
          enemyX=i;
          enemyY=j;
        }

        if(room[i][j] instanceof Player)
        {
          playerX=i;
          playerY=j;
        }
      }
    }
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
    Direction dir=getPlayerDirection();
    int tx=enemyX+dir.x;
    int ty=enemyY+dir.y;
    if(tx<0||tx>=room.length||ty<0||ty>=room[0].length)
    {
      return null;
    }
    if(room[tx][ty] instanceof Player)
    {
      switch(dir)
      {
        case NORTH:return Action.ATTACK_NORTH;
        case SOUTH:return Action.ATTACK_SOUTH;
        case EAST:return Action.ATTACK_EAST;
        case WEST:return Action.ATTACK_WEST;
      }
    }
      switch(dir)
      {
        case NORTH:return Action.MOVE_NORTH;
        case SOUTH:return Action.MOVE_SOUTH;
        case EAST:return Action.MOVE_EAST;
        case WEST:return Action.MOVE_WEST;
      }
    return null;
  }
};
