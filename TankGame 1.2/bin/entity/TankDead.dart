//faire la mort des tank avec les animation
//Ces cette meme objet qua ca mort resurecteras le tank

import "../engine/Entity.dart";
import "../engine/Room.dart";
import "dart:html";

/**
 * Classe qui gere la mort des tank que ce soi le Player ou les ennemis "Tank"
 */
class TankDead extends Entity{
  
  int _delay=6;
  int _frame=1;
  Room _room; 
  Entity _respawnEnt;
  
  TankDead(Room room, Entity respawnEnt) : super(0,0){
    this.setName("TankDead");
    _room = room;
    _respawnEnt = respawnEnt;
    
    var snd = document.getElementById("Mort"); // buffers automatically when created
    snd.play();
  }
  
  
  void update(var g){
    
    if(_frame < 6){
      var img = document.getElementById("dead"+_frame.toString());
      g.drawImage(img,x-3,y-3);
    }else{
      _respawnEnt.startPosition();
      _room.addEntity(_respawnEnt);
      this.destroy();
      _room.removeEntity(this);
    }
    
    if(_delay >= 10){
      _frame++;
      _delay = 0;
    }
    
    _delay++;
  }
  
}