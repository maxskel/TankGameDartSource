import 'dart:html';
import 'dart:async';
import 'dart:js';
import "room/Room1.dart";
import "room/Menu.dart";
import "engine/Entity.dart";

void main() {
  
  //print(Entity.collisionRect(0, 0, 16, 16, -10, -10, 9, 10));
    
  //window.setInterval(executed,1000);
    new Timer(const Duration(milliseconds: 1000), executed);
   // timer.cancel();
    
    
  
    new Menu();
   //new Room1();
}

int lastSize;

void executed(){
  
      var correctX = window.innerWidth / 20*-1;
      var correctY = window.innerHeight / 20*-1;
      
      if(lastSize != window.innerWidth*window.innerHeight){
        document.getElementById("canvas").setAttribute("width", (window.innerWidth+correctX).toString()+"px" );
        document.getElementById("canvas").setAttribute("height", (window.innerHeight+correctY).toString()+"px" );
        document.getElementById("canvas").getContext("2d").scale((window.innerWidth/320)-0.1, (window.innerHeight/240)-0.1);
        lastSize = window.innerWidth*window.innerHeight;
      }

      new Timer(const Duration(milliseconds: 1500), executed);
    
}