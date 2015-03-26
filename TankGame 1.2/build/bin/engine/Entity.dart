


abstract class Entity{
  int x=0,y=0,width=0,height=0;
  String name="";
  bool _validity=true;
  
  
  Entity(this.width, this.height);
  
  /**
   * Vérifie si il a collision entre 2 rectangle.
   * retourne true si collision ou false.
   */
  static bool collisionRect(int x1, int y1, int width1, int height1, int x2, int y2, int width2, int height2){
    
    if(x2 <= x1+width1 && x2+width2 >= x1){
      if(y2 <= y1+height1 && y2+height2 >= y1){
        return true;
      }
    }
    
    return false;
  }
  
  /**
   * Choisi un nom pour lentité
   */
  void setName(String name){
    this.name = name;
  }
  
  /**
   * Récupere le nom donner a lentité
   */
  String getName(){
    return this.name;
  }
  
  /**
   * Vérifi si il a collision entre 2 entity
   * Retourne true si il a collision sinon false
   */
  static bool collisionEntity(Entity ent1, Entity ent2){
    return Entity.collisionRect(ent1.x, ent1.y, ent1.width, ent1.height, ent2.x, ent2.y, ent2.width, ent2.height);
  }

  /**
   * Args(Entity entity);
   * retourne true si il a collision avec l'entity passer en argument sinon false
   */
  bool collision(Entity entity){
    return Entity.collisionEntity(this, entity);
  }
  
  /**
   * Decharge tous les elements lier a l'instance
   */
  void destroy(){
    this._validity = false;
  }
  
  /**
   * Retourne si lobjet est valide ou pas "Si il est detrui ou pas"
   * retourne 1 si non valide ou detruit
   */
  bool getValidity(){
    return this._validity;
  }
  
  /**
   * Controller par la room et lengine. "Change la validiter de lobjet"
   */
  void setEngineValidity(bool val){
    this._validity = val;
  }
  
  /**
     * Cette méthode n'est pas apeller automatiquement.
     * Pour metre a jour lentité il sufis dapeller la méthode dans la méthode update d'une room
     * Cette méthode doit être redéfinis dans la class enfant.
     */
    void update(var context);
}