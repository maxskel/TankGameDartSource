import "../game/TankBase.dart";
import "dart:html";
import "../game/TilesMap.dart";
import "../engine/Room.dart";
import "dart:math";
import "Key.dart";
import "../room/Room1.dart";
import "../global/Option.dart";
import "../room/Transition.dart";

class myEvent{
  int keyCode = 0;
  myEvent(int code){
    keyCode = code;
  }
}

class Player extends TankBase{
  
  bool _moveD=false, _moveL=false, _moveR=false, _moveU=false;
  Key _keyLvl=null;
  TilesMap _map;
  Room _room;
  static int vie=3;
  static int score=0;
  static int level=1;
  
  static var keyUpListener,keyDownListener;
  static var _touchUp,_touchDown,_touchSpace,_touchLeft,_touchRight;
  static var _touchUpD,_touchDownD,_touchSpaceD,_touchLeftD,_touchRightD;
  
  Player(TilesMap map,Room room) : super(Option.tankColor,map,room){
    this.setName("Player");
    
    window.removeEventListener("keyup", keyUpListener);
    window.removeEventListener("keydown", keyDownListener);
    
 
    var buttond = window.document.getElementById("button.down");
    var buttonu = window.document.getElementById("button.up");
    var buttons = window.document.getElementById("button.spacebar");
    var buttonl = window.document.getElementById("button.left");
    var buttonr = window.document.getElementById("button.right");
    
    buttond.removeEventListener("touchend", _touchDown);
    buttond.removeEventListener("touchstart", _touchDownD);
    //remove
    buttonr.removeEventListener("touchend", _touchRight,false);
       buttonl.removeEventListener("touchend", _touchLeft,false);
       buttonu.removeEventListener("touchend", _touchUp,false);
       buttond.removeEventListener("touchend", _touchDown,false);
       buttons.removeEventListener("touchend", _touchSpace,false);
       
       buttonr.removeEventListener("touchstart", _touchRightD,false);
       buttonl.removeEventListener("touchstart", _touchLeftD,false);
       buttonu.removeEventListener("touchstart", _touchUpD,false);
       buttond.removeEventListener("touchstart", _touchDownD,false);
       buttons.removeEventListener("touchstart", _touchSpaceD,false);
    
       _touchRight = touch_right;
       _touchLeft = touch_left;
       _touchUp = touch_up;
       _touchDown = touch_down;
       _touchSpace = touch_space;
       
       _touchRightD = touch_rightD;
           _touchLeftD = touch_leftD;
           _touchUpD = touch_upD;
           _touchDownD = touch_downD;
           _touchSpaceD = touch_spaceD;
    
    //Add
    buttonr.addEventListener("touchend", _touchRight,false);
    buttonl.addEventListener("touchend", _touchLeft,false);
    buttonu.addEventListener("touchend", _touchUp,false);
    buttond.addEventListener("touchend", _touchDown,false);
    buttons.addEventListener("touchend", _touchSpace,false);
    
    buttonr.addEventListener("touchstart", _touchRightD,false);
    buttonl.addEventListener("touchstart", _touchLeftD,false);
    buttonu.addEventListener("touchstart", _touchUpD,false);
    buttond.addEventListener("touchstart", _touchDownD,false);
    buttons.addEventListener("touchstart", _touchSpaceD,false);
    

    
    
    
    keyDownListener = keydown;
    keyUpListener = keyup;
    
    window.addEventListener("keydown",keyDownListener);
    window.addEventListener("keyup",keyUpListener);
    
    _keyLvl = new Key(room,map);
    room.addEntity(_keyLvl);
    _map = map;
    _room = room;
    
    while(map.getTile(x~/map.tileSize, y~/map.tileSize) != "0"){
      this.x = new Random().nextInt(map.mapWidth*this.width);
      this.y = new Random().nextInt(map.mapHeight*this.height);
      
      this.x -= (this.x%map.tileSize)-3;
      this.y -= (this.y%map.tileSize)-3;
    }
    
    startPosition();

  }
  // tactile start/keydown
  void touch_spaceD(var event){
      Option.isMobile = true;
      keydown(new myEvent(32));
    }
    
    void touch_upD(var event){
      Option.isMobile = true;
      keydown(new myEvent(38));
    }
    
    void touch_downD(var event){
        Option.isMobile = true;
        keydown(new myEvent(40));
      }
    
    void touch_leftD(var event){
          Option.isMobile = true;
          keydown(new myEvent(39));
        }
    
    void touch_rightD(var event){
              Option.isMobile = true;
              keydown(new myEvent(37));
            }
  
  //Tactile end/keyup
  void touch_space(var event){
      Option.isMobile = true;
      keyup(new myEvent(32));
    }
    
    void touch_up(var event){
      Option.isMobile = true;
      keyup(new myEvent(38));
    }
    
    void touch_down(var event){
        Option.isMobile = true;
        keyup(new myEvent(40));
      }
    
    void touch_left(var event){
          Option.isMobile = true;
          keyup(new myEvent(39));
        }
    
    void touch_right(var event){
              Option.isMobile = true;
              keyup(new myEvent(37));
            }
  
  
  update(var g){
    
    if(_moveD == true){
      this.setMove("down");
      
    }else if(_moveU == true){
      this.setMove("up");
      
    }else if(_moveL == true){
      this.setMove("left");
      
    }else if(_moveR == true){
      this.setMove("right");
      
    }
    
    
    this.draw(g);
    
    //gestion du chargement de niveau et de la cles
    if(_keyLvl.getEntityColidKey() != null && _keyLvl.getEntityColidKey().getName() == "Player"){

      //Regeneration de niveau
      var snd = document.getElementById("Key"); // buffers automatically when created
      snd.play();
      level++;
      score+=750;
      new Transition();
      _room.destroy();
    }
    
    List allEnt = this._room.getAllEntity();
    
    for(int i=0; i < allEnt.length; i++){
      if(allEnt[i].getName() == "Tank" && this.collision(allEnt[i]) == true){
        this.dead();
        Player.vie--;
      }
    }
    
    this.gui(g);
  }
  
  /*
   * Lorssque les touche son peser
   */
  void keydown(var e){
    int key = e.keyCode;
    
    if(key == 40){
      this.setMove("down");
      _moveD = true;
      
    }else if(key == 38){
      this.setMove("up");
      _moveU = true;
      
    }else if(key == 37){
      this.setMove("left");
      _moveL = true;
      
    }else if(key == 39){
      this.setMove("right");
      _moveR=true;
    }
     
    
    //print(e.keyCode);
  }
  
  /*
   * Lorsque les touche son relacher
   */
  void keyup(var e){
    int key = e.keyCode;
    
    if(key == 37 || key == 38 || key == 39 || key == 40){
      this.setMove("stand");
    }
    
    if(key == 40){
      _moveD = false;
    }
    
    if(key == 38){
      _moveU = false;
    }
    
    if(key == 37){
      _moveL = false;
    }
    
    if(key == 39){
      _moveR = false;
    }
    
    if(key == 32){
      this.shoot();
    }
  }
  
  /**
   * Mais a jour la gui et ca gestion
   */
  void gui(var g){
    g.font = 'italic 8pt Calibri';
    g.fillRect(2,225,316,14);
    g.setFillColorRgb(225, 228, 225, 1);
    g.fillText("Vie: "+vie.toString(), 4,235);
    g.fillText("|  Score: "+score.toString(), 84,235);
    g.fillText("|  Level: "+level.toString(), 34,235);
    
    
    g.setFillColorRgb(0, 0, 0, 1);
  }
  
  void startPosition() {
    this.x=18;
        this.y=200;
        this._map.setTile(1, 12, "0");
        this._map.setTile(2, 12, "0");
        this._map.setTile(1, 13, "0");
        this._map.setTile(2, 13, "0");
        
        if(vie <= 0){
              this._room.destroy();
              new Transition();
            }
  }
  
}