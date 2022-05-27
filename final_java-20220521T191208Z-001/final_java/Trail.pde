class Trail{
  PVector pos = new PVector();
  PVector v = new PVector();
  ArrayList<PVector> ps = new ArrayList<PVector>();
  float energy=255;
  float hue;
  
  void update(){
    energy -= random(3);
    if(energy > 50){
      pos.add(v);
      v.add(new PVector(0, grav));
    }
    add();
  }
  
  void add(){
    add(pos.copy());
  }
  
  void add(PVector p){
    ps.add(p);
    if(ps.size()>len){
      ps.remove(0);
    }
  }
  
  void show(){
    float n = ps.size();
    PVector prevP = null;
    stroke(hue, 100, 100, energy);
    for(int i = 0; i < n; i++){
      strokeWeight(float(i)/n*sw);
      PVector p = ps.get(i);
      if(prevP != null && prevP.x != 0 && prevP.y != 0){
        line(p.x, p.y, p.z, prevP.x, prevP.y, prevP.z);
      }
      prevP = p;
    }
    endShape();
  }
}
