import "../engine/Room.dart";
import "dart:html";
import "../global/Option.dart";
import "../room/Room1.dart";
import "Transition.dart";

class myEvent{
  int keyCode = 38;
  myEvent(int code){
    keyCode = code;
  }
}

class Menu extends Room{
  
  int _choix=1;//1.start , 2.couleurs, 3.regles
  List _couleur = ["green","red","yellow","blue"];
  int _couleurChoix=0;
  var _listening,_touchUp,_touchDown,_touchEnter;
  bool _rules = false;
  
  Menu() : super("#canvas",640,480){
    _listening = up;
    _touchUp = touch_up;
    _touchDown = touch_down;
    _touchEnter = touch_enter;
    
    var buttond = window.document.getElementById("button.down");
    var buttonu = window.document.getElementById("button.up");
    var buttone = window.document.getElementById("button.spacebar");
    var buttonl = window.document.getElementById("button.left");
    var buttonr = window.document.getElementById("button.right");
    
    window.addEventListener("keyup", _listening,false);
    
    buttonu.addEventListener("touchend", _touchUp,false);
    buttond.addEventListener("touchend", _touchDown,false);
    buttone.addEventListener("touchend", _touchEnter,false);
 
    buttond.setAttribute("style","right: 14vw; bottom: 3vh;");
    buttonu.setAttribute("style","right: 14vw; bottom: 20vh;");
    buttone.setAttribute("style","left: 1vw; bottom: 8vh;");
    buttonl.setAttribute("style","right: 2vw; bottom: 9vh;");
    buttonr.setAttribute("style","right: 26vw; bottom: 9vh;");
  }
  
  void touch_enter(var event){
    Option.isMobile = true;
    up(new myEvent(13));
    up(new myEvent(32));
  }
  
  void touch_up(var event){
    Option.isMobile = true;
    up(new myEvent(38));
  }
  
  void touch_down(var event){
      Option.isMobile = true;
      up(new myEvent(40));
    }
  
  void up(var e){
      if(Option.isMobile == false){
          var buttond = window.document.getElementById("button.down");
          var buttonu = window.document.getElementById("button.up");
          var buttone = window.document.getElementById("button.spacebar");
          var buttonl = window.document.getElementById("button.left");
          var buttonr = window.document.getElementById("button.right");
          
          buttond.setAttribute("style","display: none;");
          buttonu.setAttribute("style","display: none;");
          buttone.setAttribute("style","display: none;");
          buttonl.setAttribute("style","display: none;");
          buttonr.setAttribute("style","display: none;");
      }
      
      if(e.keyCode == 38 && _choix > 1){
        _choix--;
      }
      
      if(e.keyCode == 40 && _choix < 3){
            _choix++;
          }
      
      if(e.keyCode == 13 && _choix == 2){
        
        if(_couleurChoix < 3){
          _couleurChoix++;
        }else{
          _couleurChoix = 0;
        }
        
        Option.tankColor = _couleur[_couleurChoix];
      }
      
      if(e.keyCode == 13 && _choix == 1){
        this.destroy();
        window.removeEventListener("keyup",_listening);
        window.document.getElementById("button.up").removeEventListener("touchend",_touchUp);
        window.document.getElementById("button.down").removeEventListener("touchend",_touchDown);
        window.document.getElementById("button.spacebar").removeEventListener("touchend",_touchEnter);
        _listening = null;
        _touchUp = null;
        _touchDown = null;
        _touchEnter = null;
        
        new Transition();
      }
      
      if(e.keyCode == 13 && _choix == 3){
            if(_rules == true)
              _rules = false;
            else
            _rules = true;
          }
    }
  
  
  void update(var g){
    //Image du menu
    g.drawImage(document.getElementById("menu"),0,0);
    g.imageSmoothingEnabled = false;
    //choix des menu
    switch(_choix){
      case 1:
        g.drawImage(document.getElementById(Option.tankColor+"Right1"),98,100);
        g.drawImage(document.getElementById(Option.tankColor+"Left1"),174,100);
        break;
        
      case 2:
        g.drawImage(document.getElementById(Option.tankColor+"Right1"),47,125);
        g.drawImage(document.getElementById(Option.tankColor+"Left1"),239,125);
        break;
              
      case 3:
        g.drawImage(document.getElementById(Option.tankColor+"Right1"),93,145);
        g.drawImage(document.getElementById(Option.tankColor+"Left1"),184,145);
        break;
        
    }
    
    if(_rules == true){
      g.font = 'italic 9pt Calibri';
      g.fillStyle = "#FFFFFF";
      g.fillText("1:Trouver la clef cachée dans le niveau pour passer au prochain.",2,180);
      g.fillText("2:Éviter de vous faire tuer par les ennemis.",15,190);
      g.fillText("3:Faites le plus de points possibles!",15,200);
      g.fillText("4:Controlles flèches + espace",15,210);
      
      g.fillStyle = "#000000";
    }
    
  }
  
  
  
  
  
}