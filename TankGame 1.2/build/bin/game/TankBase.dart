import "dart:html";
import "TilesMap.dart";
import "Shoot.dart";
import "../engine/Room.dart";
import "../engine/Entity.dart";
import "../entity/TankDead.dart";
import "../entity/Tank.dart";
import "../entity/Player.dart";

abstract class TankBase extends Entity{
  String _imgID="blue";
  int _speed = 1;
  
  //Animation
  int _animLatence = 3;//La latence sexprime en frame
  int _animLatenceCount=0;
  int _animFrame=0;
  String _lastDirection = "up";// left,right,up,down (stand nan fais pas partie)
  TilesMap _map=null;
  Room _room = null;
  Shoot _shoot=null;
  int _shootTime=4;
  
  bool _down=false,_left=false,_up=false,_right=false,_stand=true;
  bool _deadAnim = false;
  
  /**
   * colorName peut valoir-> "blue","green","red","yellow";
   * map est votre map de tableau "room" tous les tile de cette map qui on une valeur diferente du caractere '0' seront considerer comme solide
   */
  TankBase(String colorName, TilesMap map,Room room) : super(9,9){
    this.setName("TankBase");
    
    if(colorName == "blue" || colorName == "green" || colorName == "red" || colorName == "yellow"){
      this._imgID = colorName;
    }else{
      this._imgID = "blue"; 
    }
    this._map = map;
    this._room = room;
  }
  
  /**
   * green, blue, red , yellow
   */
  void setColor(String colorName){
    if(colorName == "blue" || colorName == "green" || colorName == "red" || colorName == "yellow"){
         this._imgID = colorName;
       }else{
         this._imgID = "blue"; 
       }
  }
  
  /**
   * Affiche l'entité pendant 1 frame lor de lapelle de cette méthode
   * "Méthode a apeller généralement a chaque update"
   */
  void draw(var context){
    String imgDrawID=this._imgID;
    String imgID=imgDrawID;
    
    //Gestion des projectiles
    if(this._shoot != null && this._shoot.dead == false){
      this._shoot.update(context,this._map,this._room);
    }else{
      this._shoot = null;
    }

    //Animation draw et les mouvements
    if(this._left == true){
      imgDrawID = imgID+"Left"+(this._animFrame+1).toString();
      this._lastDirection = "left";
      this.x -= this._speed;
    }
    
    if(this._right == true){
      imgDrawID = imgID+"Right"+(this._animFrame+1).toString();
      this._lastDirection = "right";
      this.x += this._speed;
      

    }
    
    if(this._up == true){
      imgDrawID = imgID+"Up"+(this._animFrame+1).toString();
      this._lastDirection = "up";
      this.y -= this._speed;
      
      
    }
    
    if(this._down == true){
      imgDrawID = imgID+"Down"+(this._animFrame+1).toString();
      this._lastDirection = "down";
      this.y += this._speed;
      

    }
    
    bool collision = this.collisionTile();
    
    if(collision || this._stand == true){
      
      if(this._lastDirection == "left"){
        imgDrawID = imgID+"Left"+(1).toString();
        //collision
        if(collision == true){
          this.x += this._speed;
        }
      }
      
      if(this._lastDirection == "right"){
        imgDrawID = imgID+"Right"+(1).toString();
        //collision
        if(collision == true){
          this.x -= this._speed;
        }
      }
      
      if(this._lastDirection == "up"){
        imgDrawID = imgID+"Up"+(1).toString();
        //collision
        if(collision == true){
          this.y += this._speed;
        }
      }
      
      if(this._lastDirection == "down"){
        imgDrawID = imgID+"Down"+(1).toString();
        //collision
        if(collision == true){
          this.y -= this._speed;
        }
      }
      
    }
    
    
    var img = document.getElementById(imgDrawID);
    if(img != null)
      context.drawImage(img,this.x-3,this.y-3);
    
    //Animation logic
    if(this._animLatenceCount >= this._animLatence){
      this._animLatenceCount = 0;
      this._animFrame++;
      
      if(this._animFrame >= 2){
        this._animFrame = 0;
      }
    }
    
    if(this._shoot != null && this._shootTime >= 0){
      int tx=0,ty=0;
      
      if(this._lastDirection == "left"){
        tx -= 9;
        ty += 1;
      }else if(this._lastDirection == "right"){
        tx += 13;
        ty += 1;
      }else if(this._lastDirection == "up"){
        tx += 1;
        ty -= 9;
      }else if(this._lastDirection == "down"){
        tx += 1;
        ty += 13;
      }
        
      
      context.drawImage(document.getElementById("shoot"+this._lastDirection[0].toUpperCase()+this._lastDirection.substring(1,this._lastDirection.length)),this.x+tx,this.y+ty);
      this._shootTime--;
    }else if(this._shoot == null){
      this._shootTime=4;
    }
    
    
    
    this._animLatenceCount++;
    
  }
  
  /**
   * Tire un projectile de base dans la direction du tank
   */
  void shoot(){
    var snd = document.getElementById("Shoot"); // buffers automatically when created
    snd.play();
    
    if(this._shoot == null){
      int x=0,y=0;
      int coX=0,coY=0;
      
      if(this._lastDirection == "left"){
        x-=(this._speed*4).toInt();
        coX -= this.width;
      }
      else if(this._lastDirection == "right"){
        x+=(this._speed*4).toInt();
        coX += this.width;
      }
      else if(this._lastDirection == "up"){
            y-=(this._speed*4).toInt();
            coY -= this.height;
      }
      if(this._lastDirection == "down"){
            y+=(this._speed*4).toInt();
            coY += this.height;
      }
      
      this._shoot = new Shoot(x,y);
      this._shoot.x = this.x+ (this.width/2).toInt() - (this._shoot.width/2).toInt() + coX;
      this._shoot.y = this.y+ (this.height/2).toInt() - (this._shoot.height/2).toInt() + coY;
    }
    
  }

  
  //getter and setter
  
  /**
   * Permet de configurer la vitesse de lanimation de mouvement.
   */
  void setAnimLatence(int latenceInFrame){
    this._animLatence = latenceInFrame;
  }
  
  /**
   * Récupère la latence pour les animations
   */
  int getAnimLatence(){
    return this._animLatence;
  }
  
  /**
   * Set la vitesse de l'objet pour c'est futur déplacement
   */
  void setSpeed(int speed){
    this._speed = speed;
  }
  
  /**
   * Retourne la vitesse de l'objet lor de ses déplacement futur
   */
  int getSpeed(){
    return this._speed;
  }
  
  // MOVE
  
  /**
   * La string direction accepte comme parametre-> "left","up","down","right","stand"
   */
  void setMove(String direction){
    
    direction.toLowerCase();
    
    if(direction == "left"){
      this._left = true;
      this._right = false;
      this._down = false;
      this._up = false;
      this._stand = false;
    } 
    else if(direction == "right"){
          this._left = false;
          this._right = true;
          this._down = false;
          this._up = false;
          this._stand = false;
      }
      else if(direction == "down"){
          this._left = false;
          this._right = false;
          this._down = true;
          this._up = false;
          this._stand = false;
      }
      else if(direction == "up"){
          this._left = false;
          this._right = false;
          this._down = false;
          this._up = true;
          this._stand = false;
      }
      else{//Stand par défaut
          this._left = false;
          this._right = false;
          this._down = false;
          this._up = false;
          this._stand = true;
        }
    
  }
  
  /**
   *  retourne true si il a collision avec une tile
   * 
    */
  bool collisionTile(){
    if(this._map !=  null){
      
      int tileSize= this._map.tileSize;
      
      int tileX= this.x ~/ tileSize;
      int tileWidth= (this.x+this.width)~/tileSize;
      int tileY= this.y ~/ tileSize;
      int tileHeight=( this.y + this.height)~/tileSize;
      
      while(tileY <= tileHeight){
        
        for(int i=tileX; i<=tileWidth;i++ ){
          if(this._map.getTile(i, tileY) != "0"){
            return true;
          }
        }
        
        tileY++;
      }
    
    }
    
    return false;
  }
  
  
  TilesMap getMap(){
    return this._map;
  }
  
  /**
   * Tue le tank avec une animation
   */
  void dead(){
    TankDead tank=null;
    if(this.getName() == "Player")
      tank = new TankDead(this._room,this);
    else
      tank = new TankDead(this._room,this);
    
    this._shoot = null;
    tank.x = x;
    tank.y = y;
    this._room.addEntity(tank);
    
    this.destroy();
  }
  
  /**
   * Récupère la direction actuel du tank meme si il est "stand"
   * Les valeur de retour son-> left,right,up,down || standLeft,standRight,standUp,standDown
   * ###### Méthode non terminer #########
   */
  string getDirection(){
    
  }
  
}