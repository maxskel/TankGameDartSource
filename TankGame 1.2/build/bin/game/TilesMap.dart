import "dart:html";
import "dart:math";

class TilesMap{
  
  String MAP;
  int mapWidth,mapHeight,tileSize;
  
  /**
   * Pour les code de map aller voir game1.html
   * Exprimer la largeur et la hauteur de la map en tile et non en pixle EX: les tiles son de 16 (16x16) donc pour une
   * Map de 64x64 pixel cela vaux une map de 4x4 en tile
   */
  TilesMap(String map, int mapWidth, int mapHeight, int tileSize){
    MAP = map;
    this.mapWidth = mapWidth;
    this.mapHeight = mapHeight;
    this.tileSize = tileSize;
  }
  
  draw(var g){
    
    for(int y=0; y < mapHeight; y++){
      
      for(int x=0; x < mapWidth; x++){
        
        int ID = y*mapWidth + x;
        var img = null;
        img = document.getElementById(MAP[ID]);
        
        if(img != null){
          g.drawImage(img,x*tileSize, y*tileSize);
        }
        
      }
      
    }
    
  }
  
  /**
   * Cette méthode retourne une map format String en norme généré aléatoirement selont les dimenssion spécifier
   */
  static String generateMap(int tileWidth, int tileHeight){
    return null;
  }
  
  /**
   * index 0.caractere de la string seras le background,
   * index 1. le deuxiemme seras les Wall, les mures, les contour indestructible de larene.
   * index 2. a partire de lindex 2 et au dessu ce son les tile generer aleatoirement dans larene
   */
  static String generateCostumMap(int tileWidth, int tileHeight,String costumCharacter){
    
    String generateMap="";

    
    for(int i=0; i < tileWidth; i++){
      generateMap+=costumCharacter[1];
    }
    
    
    for(int y=1; y < tileHeight-1; y++){
      generateMap+=costumCharacter[1];
      
      for(int x=1; x < tileWidth-1; x++){
            int random = 9999999999;
            while(random >= costumCharacter.length || random == 1){
              if(new Random().nextInt(100) <= 70)
                random = new Random().nextInt(costumCharacter.length);
              else
                random = 0;
            }
            
            generateMap+=costumCharacter[random];
          }
      
      generateMap+=costumCharacter[1];
    }
    
      
    for(int i=0; i < tileWidth; i++){
      generateMap+=costumCharacter[1];
    }
    
    
    return generateMap;
  }
  
  /**
   * Retourne la tile a lemplacement specifier x,y en tile
   * La tile correspond a 1 caractere.
   */
  String getTile(int tileX, int tileY){
    return this.MAP[tileY*this.mapWidth+tileX];
  }
  
  /**
   * ramplace la tile spécifier par une nouvelle
   */
  void setTile(int tileX, int tileY, String char){
    String finalMap = "";
    
    for(int y=0; y < this.mapHeight; y++){
      
      for(int x=0; x < this.mapWidth; x++){
          if(tileX == x && tileY == y){
            finalMap+= char;
          }else{
            finalMap+= this.MAP[y*this.mapWidth+x];
          }
      }
      
    }
    
    this.MAP = finalMap;
    
  }
  
  
}