class Obstacle extends WorldObject
{
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
  int PosX;
  int PosY;
  JSONObject json;
  {
  json=new JSONObject();
  json.setInt("X position", PosX);
  json.setInt("Y position", PosY);
  }
}//TODO: FINISH SERIALIZE METHOD
