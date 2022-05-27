float grav = 0.01;
float len = 50;
float sw = 10;
ArrayList<Firework> fireworks = new ArrayList<Firework>();;

void setup(){
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(ADD);
  //size(500, 500);
  
}

void draw(){
  background(0);
  noFill();
  if(random(50) < 1){
    fireworks.add(new Firework(new PVector(width/2, height), new PVector(random(-4, 4), random(-10, -6))));
  }
  for(int i = fireworks.size()-1; i >= 0; i--){
    Firework firework = fireworks.get(i);
    firework.update();
    firework.show();
    if(!firework.isAlive())fireworks.remove(i);
  }
}

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
