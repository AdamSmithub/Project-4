class Obstacle extends WorldObject
{
  int PosX;
  int PosY;
  int RockCount=0;
  boolean updated=false;

  Obstacle()
  {
    PosX=0;
    PosY=0;
  }

  Obstacle(int PosX, int PosY)
  {
    this.PosX=PosX;
    this.PosY=PosY;
  }


  //TODO: Make updated reset for all rocks at end of reset
  void update (WorldObject[][] positions)
  {
    RockCount++;
    if (updated==false)
    {

      updated=true;
      for (int i=-1; i<=1; i++)
      {
        for (int j=-1; j<=1; j++)
        {
          if (positions[i][j] instanceof Obstacle)
          {
             ((Obstacle)positions[i][j]).update(positions);
          }
        }
      }
    }
  }



    void draw()
    {
      
    }
    JSONObject json;
    {
      json=new JSONObject();
      json.setInt("X position", PosX);
      json.setInt("Y position", PosY);
    }
    JSONObject serialize()
    {
      return json;
      //TEMPORARY CODE FOR COMPILATION< MUST FIX
    }
    
  }//TODO: FINISH SERIALIZE METHOD
