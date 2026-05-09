/**TODO:DEFAULT CONSTRUCTOR, JSONOBJECT CONSTRUCTOR, SERIALIZE, RESET METHOD(GENERATES NEW ROOMS), DRAW METHOD
 *      Author: Prof. Morales
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-04-15
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Scene.pde
 * Description: The game scene that handles each room
 *              and all objects within those rooms,
 *              including the player and enemies
 */

import java.util.LinkedList;

class Scene {
  private int roomWidth;
  private int roomHeight;
  private WorldObject[][] room;
  private Direction entry;
  private Player player;
  private LinkedList<Actor> enemies;
  private HashMap<WorldObject, Position> positions;
  private HashMap<Direction, Position> doors;

  public float[] positionX = {width/14, width/14*3, width/14*5, width/14*7, width/14*9, width/14*11, width/14*13};
  public float[] positionY = {height/10, height/10*3, height/10*5, height/10*7, height/10*9};



  public Scene() {
    roomWidth = 7;
    roomHeight = 5;
    room = new WorldObject[7][5];    //7 left-right, 5 top-bottom
    player = new Player(entry);
    Obstacle o = new Obstacle();
    room[3][2] = player;
    room[3][4] = o;
    room[6][2] = o;
  }

  public Scene(JSONObject data) {
    roomWidth = data.getInt("roomWidth");
    roomHeight = data.getInt("roomHeight");
    
    room = new WorldObject[7][5];    //7 left-right, 5 top-bottom
    player = new Player(entry);
    Obstacle o = new Obstacle();
    room[3][2] = player;
    room[3][1] = o;
  }

  /**
   *      Method: private reset()
   *  Parameters: Direction entry - The direction from which
   *                                the player entered the room
   *      Return: void
   * Description: Resets the room to a random state
   */

  private void reset(Direction entry) {
    if (entry == null) {
      return;
    }

    //----------------------------\\
    // TODO: COMPLETE THIS METHOD \\
    //----------------------------\\
  }

  /**
   *      Method: private updateActions()
   *  Parameters: Actor actor - The actor whose actions will be
   *                            updated to reflect their validity
   *      Return: void
   * Description: Updates an actor's list of valid actions
   */

  private void updateActions(Actor actor) {
    for (Action action : Action.values()) {
      actor.setActionValidity(action, this.isActionValid(actor, action));
    }
  }

  /**
   *      Method: public tryTurn()
   *  Parameters: void
   *      Return: boolean - Whether or not the state of
   *                        the scene should be saved
   * Description: Tries to execute a single turn of game
   *              logic for the player and all enemies
   */

  public boolean tryTurn() {
    // If the player is dead, reset the room
    if (this.player == null || this.player.getHealth() == 0) {
      Direction[] directions = Direction.values();
      Direction direction = directions[int(random(directions.length))];
      this.player = new Player(direction);
      this.reset(direction);
    }

    // Get the player's action
    Action action = this.player.getAction();

    // If no action was chosen, do nothing
    if (action == null) {
      return false;
    }

    // If the player attacked or entered a new room, save the game
    Position door = this.doors.get(action.direction);
    boolean save = action.isAttack || door != null && door.equals(this.positions.get(this.player)) && this.enemies.size() == 0;

    // If the action failed, do nothing
    if (!this.tryAction(this.player, action)) {
      return false;
    }

    for (int i = 0; i < this.enemies.size(); ++i) {
      Actor enemy = this.enemies.get(i);

      // Remove dead enemies
      if (enemy.getHealth() == 0) {
        this.enemies.remove(i--);
        continue;
      }

      // Get the enemy's action
      this.updateActions(enemy);
      action = enemy.getAction();

      if (this.tryAction(enemy, action) && action.isAttack) {
        // If the player died, reset the room and save the game
        if (player.getHealth() == 0) {
          Direction[] directions = Direction.values();
          Direction direction = directions[int(random(directions.length))];
          this.player = new Player(direction);
          this.reset(direction);
          return true;
        }

        // If the enemy attacked, save the game
        save = true;
      }
    }

    this.updateActions(this.player);
    return save;
  }

  /**
   *      Method: private tryAction()
   *  Parameters: Actor  actor  - The actor performing the action
   *              Action action - The action being performed
   *      Return: boolean - Whether or not the action succeeded
   * Description: Tries to execute an action on behalf of an actor
   */

  private boolean tryAction(Actor actor, Action action) {
    if (!isActionValid(actor, action)) {
      return false;
    }

    Position position = this.positions.get(actor);

    if (position == null) {
      return false;
    }

    // Get the position of the cell being targeted
    int x = position.getX() + action.direction.x;
    int y = position.getY() + action.direction.y;

    // Check if the player can enter a new room
    if (!action.isAttack && actor == this.player && action.direction != this.entry.inverse() && this.enemies.size() == 0) {
      Position door = this.doors.get(action.direction);

      if (door != null && door.equals(position)) {
        this.reset(action.direction);
        return true;
      }
    }

    // Check if the actor is facing a wall
    if (x < 0 || x >= this.roomWidth || y < 0 || y >= this.roomHeight) {
      return false;
    }

    // Check if the actor can attack
    if (action.isAttack) {
      boolean isActionValid = this.room[x][y] instanceof Actor && (actor == this.player || this.room[x][y] == this.player);

      if (isActionValid) {
        Actor enemy = (Actor)this.room[x][y];

        if (enemy.getHealth() > 0) {
          enemy.updateHealth(-actor.getDamage());
        } else {
          this.room[x][y] = null;
        }
      }

      return isActionValid;
    }

    // Check if the actor can interact with an interactable object
    if (actor == this.player && this.room[x][y] instanceof Interactable) {
      Interactable interactable = (Interactable)this.room[x][y];

      if (!interactable.interact(this.player)) {
        return false;
      }
    } else if (this.room[x][y] != null) {
      return false;
    }

    // Check if the actor can move
    this.room[x][y] = actor;
    this.room[position.getX()][position.getY()] = null;
    position.move(action.direction);
    return true;
  }

  /**
   *      Method: private isActionValid()
   *  Parameters: Actor  actor  - The actor performing the action
   *              Action action - The action being performed
   *      Return: boolean - Whether or not the action is valid
   * Description: Determines if an actor's action would be valid
   */

  private boolean isActionValid(Actor actor, Action action) {
    if (actor == null || action == null || actor.getHealth() == 0) {
      return false;
    }

    Position position = this.positions.get(actor);

    if (position == null) {
      return false;
    }

    // Get the position of the cell being targeted
    int x = position.getX() + action.direction.x;
    int y = position.getY() + action.direction.y;

    // Check if the player can enter a new room
    if (!action.isAttack && actor == this.player && action.direction != this.entry.inverse() && this.enemies.size() == 0) {
      Position door = this.doors.get(action.direction);

      if (door != null && door.equals(position)) {
        return true;
      }
    }

    // Check if the actor is facing a wall
    if (x < 0 || x >= this.roomWidth || y < 0 || y >= this.roomHeight) {
      return false;
    }

    // Check if the actor can attack
    if (action.isAttack) {
      return this.room[x][y] instanceof Actor && (actor == this.player || this.room[x][y] == this.player);
    }

    // Check if the actor can move
    return this.room[x][y] == null || this.room[x][y] instanceof Interactable && actor == this.player;
  }

  /**
   *      Method: public getRoomWidth()
   *  Parameters: void
   *      Return: int - The width of the room, in number of columns
   * Description: Returns the width of the room
   */

  public int getRoomWidth() {
    return roomWidth;
  }

  /**
   *      Method: public getRoomHeight()
   *  Parameters: void
   *      Return: int - The height of the room, in number of rows
   * Description: Returns the height of the room
   */

  public int getRoomHeight() {
    return roomHeight;
  }

  /**
   *      Method: public keyPressed()
   *  Parameters: void
   *      Return: void
   * Description: Passes key press events to the player
   */

  public void keyPressed() {
    if (this.player != null) {
      this.player.keyPressed();
    }
    
    //the above is what was already there. below is what I (Robby) added.
    for (int i = 0; i < roomWidth - 1; i++) {
      for (int j = 0; j < roomHeight - 1; j++) {
        if (room[i][j] instanceof Player) {
          switch(key) {
            case 'w':  //moves up
              if (j == 0) { //if already at the border can't move
                continue;
              } else if(room[i][j-1] instanceof Obstacle) {
                continue;
              } else 
                room[i][j-1] = player;
                room[i][j] = null;

                break;
            
            case 'a':  //moves down
              if (i == 0) {
                continue;
              } else if(room[i-1][j] instanceof Obstacle) {
                continue;
              } else {
                room[i-1][j] = player;
                room[i][j] = null;
              } break;
            
            
            //these are broken for some reason. they instantly snap the player as far right or down as possible. they still stop at obstacles though.
            case 's':  //moves down
              if (i == 4) {
                break;
              } else if(room[i][j+1] instanceof Obstacle) { //bandaid fix could just be adding offscreen obstacles.
                break;
              } else {
                room[i][j + 1] = player;
                room[i][j] = null;
            } break;
            
            case 'd':  //moves right
              if (j == 6) {
                break;
              } else if(room[i+1][j] instanceof Obstacle) {
                break;
              } else {
                room[i + 1][j] = player;
                room[i][j] = null;
            } break;
            
            
            case 't':          //debug that prints the current X position
              print(i);
              break;
              
            case 'y':          //debug that prints the current Y position
              print(j);
              break;
          }
        }
      }
    }
  }

  /**
   *      Method: public keyReleased()
   *  Parameters: void
   *      Return: void
   * Description: Passes key release events to the player
   */

  public void keyReleased() {
    if (this.player != null) {
      this.player.keyReleased();
    }
  }

  /**
   *      Method: public draw()
   *  Parameters: void
   *      Return: void
   * Description: Draws the scene
   */

  public void draw() {

    // Determine the floor size
    float size = min((float)width / (this.roomWidth + 2), (float)height / (this.roomHeight + 2));

    //----------------------------\\
    // TODO: COMPLETE THIS METHOD \\
    //----------------------------\\

    //drawing the grid
    pushStyle();
    stroke(255);
    for (int i = 0; i < 7; i++) {
      line((width/7)*i, 0, (width/7)*i, height);
    }
    for (int i = 0; i < 5; i++) {
      line(0, (height/5)*i, width, (height/5)*i);
    }
    popStyle();

    
    //draws everything in the room at its correct position
    for (int i = 0; i < roomWidth; i++) {
      for (int j = 0; j < roomHeight; j++) {
        if(room[i][j] != null){
          pushMatrix();
          translate(positionX[i], positionY[j]);
          room[i][j].draw();
          popMatrix();


            if(room[i][j] instanceof Player) {
              //println(i + " " + j);
            }
        }
      }
    }
  }

  public JSONObject serialize() {
    JSONObject data = new JSONObject();
    data.setInt("roomWidth", roomWidth);
    data.setInt("roomHeight", roomHeight);


    return data;
  }
}
