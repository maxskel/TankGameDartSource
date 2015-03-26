import "dart:html";
import "../engine/Room.dart";
import "Room1.dart";
import "../global/Option.dart";
import "../entity/Player.dart";
import "Menu.dart";

class Transition extends Room{
  
  int _delay=120;
  
  Transition() : super("canvas",340,240){
    
  }
  
  void update(var g){
    
    g.fillStyle="#000000";
    g.fillRect(0,0,340,240);
    g.fillStyle="#FFFFFF";
    
    if(Player.vie > 0){
      g.font = 'italic 30pt Calibri';
      g.fillText("Level: "+Player.level.toString(),80,80);
      
      g.font = 'italic 16pt Calibri';
      g.fillText("Vie: "+Player.vie.toString(),80,110);
      
      g.font = 'italic 16pt Calibri';
      g.fillText("Score: "+Player.score.toString(),80,140);
      
      g.font = 'italic 12pt Calibri';
      g.fillText((_delay/33.00).toInt().toString(),100,180);
      
      if(_delay <= 0){
        this.destroy();
        new Room1();
      }
    }else{
      g.font = 'italic 30pt Calibri';
      g.fillText("Game Over",60,80);
      
      g.font = 'italic 16pt Calibri';
      g.fillText("Score: "+Player.score.toString(),80,140);
      
      g.font = 'italic 12pt Calibri';
      g.fillText((_delay/33.00).toInt().toString(),100,180);
            
      if(_delay <= 0){
              this.destroy();
              Player.score = 0;
              Player.vie = 3;
              Player.level = 1;
              new Menu();
            }
      
      
    }
    
    _delay--;
    
  }
}