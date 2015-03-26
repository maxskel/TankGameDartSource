import "../engine/Room.dart";
import '../entity/Player.dart';
import "../game/TilesMap.dart";
import "../entity/Fire.dart";
import "../entity/Tank.dart";

class Room1 extends Room{
  
  TilesMap _MAP;
  
  Room1() : super("#canvas",640,480){
    /*
    String map = 
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"+
            "00000000000000000000"; // 20x15
    */
    
   /* String map = 
        "BBBBBBBBBBBBBBBBBBBB"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "B000000000000000000B"+
        "BBBBBBBBBBBBBBBBBBBB"; // 20x15*/
    String map = TilesMap.generateCostumMap(20, 15, "0WcCbBbBcCw");
    
    _MAP = new TilesMap(map,20,15,16);
    Player player = new Player(_MAP,this);
    this.addEntity(player);
    
    if(Player.level < 4){
      for(int i=0; i < Player.level;i++){
        this.addEntity(new Tank(_MAP,this));
      }
    }else{
      player.setSpeed(player.getSpeed()*2);
      
      for(int i=0; i < Player.level-3;i++){
        Tank tank = new Tank(_MAP,this);
        tank.setSpeed(tank.getSpeed()*2);
        this.addEntity(tank);
      }
    }
    
  }
  
  update(var g){
    _MAP.draw(g);
    
  }
  

}