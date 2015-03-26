import "../engine/Entity.dart";
import "../engine/Room.dart";
import "../game/TilesMap.dart";
import "dart:math";
import "dart:html";

class Key extends Entity{
  Room _room;
  TilesMap _map;
  int _tileX=0,_tileY=0;
  
  
  Key(Room room, TilesMap map) : super(13,13){
    
    _map = map;
    _room = room;
    
    int tx=new Random().nextInt(map.mapWidth);
    int ty = new Random().nextInt(map.mapHeight);
    
    while( "0" == map.getTile(tx,ty) || "W" == map.getTile(tx,ty) || "w" == map.getTile(tx,ty)){
      tx=new Random().nextInt(map.mapWidth);
      ty = new Random().nextInt(map.mapHeight);
    }
    
    this.setName("Key");
    
    _tileX = tx;
    _tileY = ty;
    x = _tileX*_map.tileSize;
    y = _tileY*_map.tileSize;
  }
  
  void update(var context){
    if(_map.getTile(_tileX,_tileY) == "0"){
      var img = document.getElementById("key");
      context.drawImage(img,_tileX*_map.tileSize,_tileY*_map.tileSize);
    }
    
     
  }
  
  /**
   * Retourne true si le player touche a la cle
   */
  Entity getEntityColidKey(){
    
    List ent = _room.getAllEntity();
    
    for(int i=0; i < ent.length;i++){
      if(true == this.collision(ent[i]) && ent[i].getName() != "Key"){
        return ent[i];
      }
    }
    
    return null;
  }
}