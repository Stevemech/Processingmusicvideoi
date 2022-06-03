class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  int h,s,b;
  
  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    
     h = (int)random(360);
     s= (int)random(100);
     b= (int)random(100);
    stroke(h,s,b,lifespan);
    strokeWeight(4);
    fill(h,s,b,lifespan);
    ellipse(position.x, position.y, 3, 3);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
