import "../game/TankBase.dart";
import "../engine/Room.dart";
import "../game/TilesMap.dart";
import "dart:math";
import "../global/Option.dart";
import "Player.dart";

class Tank extends TankBase{
  
  TilesMap _map;
  Room _room;
  bool _xySwitch = false;
  int _counter=0;
  int px=0,py=0;//Point de destination du tank
  static int _sid=0;
  int id;
  
  int _randomIA= new Random().nextInt(10);
  
  Tank(TilesMap map, Room room) : super("green",map,room){
    this.setName("Tank");
    this._map = map;
    this._room = room;
    List ranColor = ["red","green","yellow","blue"];
    
    int random = new Random().nextInt(4);
    id = _sid;
    
    
    
    while(Option.tankColor == ranColor[random]){
      random = new Random().nextInt(4);
    }
    
    
    this.setColor(ranColor[random]);
    
    while(map.getTile(x~/map.tileSize, y~/map.tileSize) != "0"){
          this.x = new Random().nextInt(map.mapWidth*this.width);
          this.y = new Random().nextInt(map.mapHeight*this.height);
          
          this.x -= (this.x%map.tileSize)-3;
          this.y -= (this.y%map.tileSize)-3;
        }
    
    this.startPosition();
    
    _sid++;
    if(_sid >= 3){
          _sid=0;
        }
  }
  
  void startPosition(){
    switch(id){
          case 0:
            this.x=18;
            this.y=18;
            this._map.setTile(1, 1, "0");
            this._map.setTile(2, 1, "0");
            this._map.setTile(1, 2, "0");
            this._map.setTile(2, 2, "0");
            break;
            
          case 1:
                  this.x=285;
                  this.y=18;
                  this._map.setTile(17, 1, "0");
                  this._map.setTile(18, 1, "0");
                  this._map.setTile(17, 2, "0");
                  this._map.setTile(18, 2, "0");
                  break;
                  
          case 2:
                  this.x=280;
                  this.y=200;
                  this._map.setTile(17, 12, "0");
                  this._map.setTile(18, 12, "0");
                  this._map.setTile(17, 13, "0");
                  this._map.setTile(18, 13, "0");
                  break;
        }
  }
  
  void update(var g){
    _logic(g);
    this.draw(g);
  }
  
  void _logic(var g){
    
    //Trouve le joueur dans la room
    List entList = this._room.getAllEntity();
    Player player;
    
    for(int i=0; i < entList.length; i++){
      if(entList[i].getName() == "Player"){
        player = entList[i];
        break;
      }
    }
    
    // IA
    if(player != null){
      
      
      if(this._counter >= 30){
        this._counter = 0;
        
        if(new Random().nextInt(100) < 50){
          this._xySwitch = true;
        }else
          this._xySwitch = false;
        
        px = player.x;
        py = player.y;
        
        if(new Random().nextInt(100) < this._randomIA+10){
          px = new Random().nextInt(this.getMap().mapWidth*this.getMap().tileSize);
          py = new Random().nextInt(this.getMap().mapHeight*this.getMap().tileSize);
        }
      }
      
      this._counter++;
      
      //Mouvement de base avec le else
      if(this._xySwitch == false){
        
        if(px <  this.x){
          this.setMove("left");
          
        }else if(px >  this.x){
          
          this.setMove("right");
        }else{
          
          if(py <  this.y){
            this.setMove("up");
          }
          
          if(py >  this.y){
            this.setMove("down");
          }
          
        }
        
      }else{
        
        if(py <  this.y){
          this.setMove("up");
        }else if(py >  this.y){
          this.setMove("down");
        }else{
          if(px <  this.x){
            this.setMove("left");
            
          }
          if(px >  this.x){
            
            this.setMove("right");
          }
        }
      }
      
      if(this._counter > 27 && new Random().nextInt(100) < 50){
        this.shoot();
      }
      
      
    }
    
    
  }
  
  
}





