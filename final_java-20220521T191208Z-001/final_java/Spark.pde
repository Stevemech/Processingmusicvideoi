class Spark{
  ArrayList<Trail> trails = new ArrayList<Trail>();
  PVector center;
  
  Spark(PVector center, float hue){
    this.center = center;
    for(int i = 0; i < 100; i++){
      Trail trail = new Trail();
      trail.hue = hue;
      trail.pos = center.copy();
      float theta = random(PI);
      float phi = random(TWO_PI);
      float r = 2;
      trail.v = new PVector(r*sin(theta)*cos(phi), r*sin(theta)*sin(phi), r*cos(theta));
      trails.add(trail);
    }
  }
  
  void update_show(){
    for(int i = trails.size()-1; i >= 0 ; i--){
      Trail trail = trails.get(i);
      trail.update();
      trail.add();
      trail.show();
      if(trail.energy < 0){
        trails.remove(i);
      }
    }
  }
}
