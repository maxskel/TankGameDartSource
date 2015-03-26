import "dart:html";
import "../engine/Entity.dart";
import "Player.dart";
import "../engine/Room.dart";
import "../game/TilesMap.dart";
import "dart:math";

class Fire extends Entity{
  int _frame=0;
  int _latence=3;
  int _latMem;
  int _lifeFrame=20; // 90 = 3sec (30frame sec)
  
  TilesMap _map;
  Room _room;
  
  Fire(int x, int y,TilesMap map, Room room) : super(15,15){
    this.x = x;
    this.y = y;
    _latMem = _latence;
    _map = map;
    _room = room;
    
    this.setName("Fire");
  }
  
  void update(var context){
    
    if(_latence <= 0){
      _latence = _latMem;
      
      if(_frame < 4)
        _frame++;
      else
        _frame = 0;
    }
    
    var img = document.getElementById("fire"+_frame.toString());
    context.drawImage(img, x, y);
    
    _latence--;
    
    //A sa mort
    if(_lifeFrame <= 0){
      int tileX = (x/_map.tileSize).toInt();
      int tileY = (y/_map.tileSize).toInt();
      _map.setTile(tileX, tileY, "0");
      
      if(new Random().nextInt(100) < 90){
        
        if(new Random().nextInt(100) < 90 && _map.getTile(tileX+1, tileY) == "b" || _map.getTile(tileX+1, tileY) == "B"){
          _room.addEntity(new Fire( ((this.x / _map.tileSize).toInt()+1)*_map.tileSize,  (this.y / _map.tileSize).toInt()*_map.tileSize,_map,_room));
        }
        
        if(new Random().nextInt(100) < 90 && _map.getTile(tileX-1, tileY) == "b" || _map.getTile(tileX-1, tileY) == "B"){
          _room.addEntity(new Fire( ((this.x / _map.tileSize).toInt()-1)*_map.tileSize,  (this.y / _map.tileSize).toInt()*_map.tileSize,_map,_room));
        }
        
        if(new Random().nextInt(100) < 90 && _map.getTile(tileX, tileY+1) == "b" || _map.getTile(tileX, tileY+1) == "B"){
          _room.addEntity(new Fire( (this.x / _map.tileSize).toInt()*_map.tileSize,  ((this.y / _map.tileSize).toInt()+1)*_map.tileSize,_map,_room));
        }
        
        if(new Random().nextInt(100) < 90 && _map.getTile(tileX, tileY-1) == "b" || _map.getTile(tileX, tileY-1) == "B"){
          _room.addEntity(new Fire( (this.x / _map.tileSize).toInt()*_map.tileSize,  ((this.y / _map.tileSize).toInt()-1)*_map.tileSize,_map,_room));
        }
      }
      
      Player.score += 5;
      this.destroy();
    }
    
    _lifeFrame--;
  }
  
  void dead(){
    
  }
  
}