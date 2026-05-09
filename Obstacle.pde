class Obstacle extends WorldObject
{
  int IDX;
  int IDY;
  boolean updated = false;


  Obstacle()
  {

  }

  Obstacle(int PosX, int PosY)
  {
    this.IDX=PosX;
    this.IDY=PosY;
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
  
  JSONObject serialize() {
   JSONObject rockData = new JSONObject();
   rockData.setString("className", "Obstacle");
   return rockData;
  }

  void draw() {
    pushStyle();
    rectMode(CENTER);
    fill(200);
    rect(0, 0, 50, 50);
    popStyle();
  }
}
