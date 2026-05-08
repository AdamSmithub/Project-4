/**
class Obstacle extends WorldObject
{
  int PosX;
  int PosY;
  boolean updated=0;

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
    void update (ArrayList <ArrayList <Position>> Positions)
    {
      RockCount++;
      if(updated==0)
      {
        
        updated=1;
        for(int i=-1; i<=1; i++)
        {
          for (int j=-1; j<=1; j++)
          {
            if(Positions.get(i).get(j).getSpaceType()="Obstacle")
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
}
*/
