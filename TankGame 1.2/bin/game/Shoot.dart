import "dart:html";
import "TilesMap.dart";
import "../engine/Entity.dart";
import "../engine/Room.dart";
import "../entity/Fire.dart";
import "../entity/Player.dart";

class Shoot{
  int x=0,y=0,width=3,height=3;
  int _dirX,_dirY;
  bool dead=false;
  var _img=null;
  
  Shoot(int directionX, int directionY){
    this._dirX = directionX;
    this._dirY = directionY;
    this._img = document.getElementById("shoot");
  }
  
  void update(var context,TilesMap map,Room room){
    this.x += this._dirX;
    this.y += this._dirY;
    
   context.drawImage(this._img,x,y);
    
    
    //Detection des collision par tile
    String tileCol = map.getTile( (this.x / map.tileSize).toInt(), (this.y / map.tileSize).toInt());
    if(tileCol != "0"){
      
      if(tileCol == "W" || tileCol == "w"){
        this.destroy();
      }else{
        
        if(tileCol == "b" || tileCol == "B"){
          
          room.addEntity(new Fire((this.x / map.tileSize).toInt()*map.tileSize,  (this.y / map.tileSize).toInt()*map.tileSize,map,room));
          
        }else if(tileCol == "c"){
          map.setTile((this.x / map.tileSize).toInt(), (this.y / map.tileSize).toInt(), "C");
        }else{
          map.setTile((this.x / map.tileSize).toInt(), (this.y / map.tileSize).toInt(), "0");
          Player.score += 60;
        }
        
        var snd = document.getElementById("Hit"); // buffers automatically when created
        snd.play();
        
        this.destroy();
        
      }
      
    }
    
    //Detection des collision selon les entitys
     List allEnt = room.getAllEntity();
     if(allEnt != null){
       
       for(int i=0; i < allEnt.length; i ++){
         
         if(true == Entity.collisionRect(allEnt[i].x,allEnt[i].y,allEnt[i].width,allEnt[i].height, this.x,this.y,this.width,this.height) )
         {
           if(allEnt[i].getName() != "Key"){

             if(i < allEnt.length && allEnt[i].getName() == "Tank" ){
                 Player.score += 500;
                 allEnt[i].dead();
                 //room.removeEntity(allEnt[i]);
             }
             
             if( i < allEnt.length && allEnt[i].getName() == "Player"){
                  Player.score -= 500;
                  Player.vie--;
                  allEnt[i].dead();
                  //room.removeEntity(allEnt[i]);
              }
             
             if(allEnt[i].getName() != "TankDead" && allEnt[i].getName() != "Fire" && allEnt[i].getName() != "Tank" && allEnt[i].getName() != "Player")
               allEnt[i].destroy();
             
            
             this.destroy();
           }
           
           
           
           
         }
         
       }
       
     }
    
  }
  
  
  void destroy(){
    this.dead = true;
  }
  
  
}