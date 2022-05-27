class Firework{
  Spark spark;
  Trail trail = new Trail();
  float hue = (frameCount/10)%360;
  
  Firework(PVector pos, PVector v){
    trail.pos = pos;
    trail.v = v;
    trail.hue = hue;
  }
  
  void update(){
    if(trail != null){
      trail.update();
      if(trail.energy<0){
        spark = new Spark(trail.pos, hue);
        trail = null;
      }
    }
  }
  
  void show(){
    if(trail != null){
      trail.show();
    }
    if(spark != null){
      spark.update_show();
    }
  }
  
  boolean isAlive(){
    return (trail != null) || (spark != null);
  }
}
