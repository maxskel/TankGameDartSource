import "dart:html";
import "dart:async";
import "Entity.dart";

/**
 * Classe abstraite
 * 
 * Constructeur:
 *    Room(String canvasID, int width, int height);
 * 
 * Méthode abstraite:
 *    void update(var context2D);
 * 
 * Constante static:
 *    fpsMilli = 33 se qui est équivalent a 30 fps par défaut
 *    Changer cette constante directement dans la class Room
 */
abstract class Room{
  static const int fpsMilli= 26;// 1000/fps = fpsMilli
  
  var _ctx;
  Timer _timer;
  String _canvasId;
  int _width=0,_height=0;
  List _entity=new List();
  bool _isDestroy=false;
  
  /**
   * Arguments(String canvasID, int width, int height);
   * 
   * #Note: vous devez dejas avoir créer les balise canvas + les attributs id,width et height et...
   * ...les retranscrires dans les attributs du constructeur. 
   */
  Room(String canvasID, int width, int height){
    this._ctx = querySelector(canvasID).getContext("2d");
    this._ctx.imageSmoothingEnabled = false;
    this._canvasId = canvasID;
    
    if(this._width > 0 && this._height > 0){
      this._width = width;
      this._height = height;
    }else{
      this._width = 640;
      this._height = 480;
    }
    
    this._timer = new Timer(const Duration(milliseconds: fpsMilli), this._roomUpdate);
  }
  
  /**
    * Méthode a redefinir dans la classe enfant. Cette méthode est apeller automatiquement à une vitesse d'aproximativement 30fps
    */
    void update(var context);
  
  /**
   * Controlle la méthode update(context);
   */
  void _roomUpdate(){
    if(this._entity != null){
      this._timer.cancel();
      this._timer = null;
      this._timer = new Timer(const Duration(milliseconds: fpsMilli), this._roomUpdate);
      
      this._ctx.clearRect(0,0,this._width, this._height);
      this.update(this._ctx);
      
      List tempEntity = new List();
    
      for(int i=0; i < this._entity.length; i++ ){
        
        this._entity[i].update(this._ctx);
        
        if(i < this._entity.length && this._entity[i].getValidity() == true){
          tempEntity.add(this._entity[i]);
        }
        
      }
      
      this._entity.clear();
      this._entity = tempEntity;
    }
  }
  
  /**
   * Ajoute un entity a la room les méthode suivant son gérer par la room : "update(var context)"
   */
  void addEntity(Entity ent){
    this._entity.add(ent);
    ent.setEngineValidity(true);
  }
  
  /**
   * Suprimme une entity de la room de facon propre.
   */
  void removeEntity(Entity ent){
    this._entity.remove(ent);
    ent.setEngineValidity(false);
  }
  
  /**
   * Suprimme toute les entity de la room
   */
  void removeAllEntity(){
    this._entity.clear();
  }
  
  /**¸
   * Retourne la liste des entité trouver dans la room
   */
  List getAllEntity(){
    return this._entity;
  }
  
  /**
   * Détruit de facon propre une room
   */
  void destroy(){
    this._entity.clear();
    _timer.cancel();
    _isDestroy = true;
  }
  
  bool getIsDestroy(){
    return _isDestroy;
  }
}