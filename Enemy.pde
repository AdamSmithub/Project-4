class Enemy extends Actor
{
  WorldObject room[][];
  Position position;
  int playerX;
  int playerY;
  Enemy(JSONObject json, WorldObject[][] room, Position position)
  {
    super(json.getJSONObject("super"));
    this.room=room;
    this.position=position;
  }
  Enemy(Direction direction, WorldObject[][] room, Position position)
  {
    super(100, 10, direction);
    this.room=room;
    this.position=position;
  }
  public void draw()
  {
    pushStyle();
    fill(200, 0, 0);
    ellipse(0, 0, 50, 50);
    popStyle();
  }
  public JSONObject serialize()
  {
    JSONObject json=new JSONObject();
    
    json.setJSONObject("super", super.serialize());
    return json;
  }
  private Direction getPlayerDirection()
  {
    int x=0;
    int y=0;
    if(abs(playerX-position.x)>abs(playerY-position.y)) x=1;
    else if(abs(playerX-position.x)<abs(playerY-position.y)) y=1;
    else
    {
      x+=round(random(0, 1));
      if(x==0) y=1;
    }
    if(x==1)
    {
      if(playerX<position.x) return Direction.EAST;
      else return Direction.WEST;
    }
    else
    {
      if(playerY<position.y) return Direction.SOUTH;
      else return Direction.NORTH;
    }
  }
  void keyPressed()
  {
    getAction();
  }
      
      
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
    if(room[position.x+getPlayerDirection().x][position.y-getPlayerDirection().y] instanceof Player)
    {
      if(getPlayerDirection().y==1) return Action.ATTACK_NORTH;
      if(getPlayerDirection().y==-1) return Action.ATTACK_SOUTH;
      if(getPlayerDirection().x==-1) return Action.ATTACK_EAST;
      if(getPlayerDirection().x==1) return Action.ATTACK_WEST;
      else return Action.ATTACK_NORTH;
    }
    else
    {
      if(getPlayerDirection().y==1) return Action.MOVE_NORTH;
      if(getPlayerDirection().y==-1) return Action.MOVE_SOUTH;
      if(getPlayerDirection().x==-1) return Action.MOVE_EAST;
      if(getPlayerDirection().x==1) return Action.MOVE_WEST;
      else return Action.MOVE_NORTH;
    }
  }  
};
