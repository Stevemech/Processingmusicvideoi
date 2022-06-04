/* NOTES
Song: Toxic by Iverness
*/
import processing.sound.*;

//these two variables help with calculating the delay when the 
//project starts up...so that the timing can be consistent 
boolean firstTime = true;
int startTime;


//The length, in seconds, of each scene of your animation
float[] timesPerScene = {7, //0
                         5, //1
                         1, //2
                         1, //3
                         1, //4
                         2, //5
                         4, //6
                         1, //7
                         1, //8
                         1, //9
                         1, //10
                         4, //11
                         2, //12
                         1, //13
                         1, //14
                         3, //15
                         3, //16
                         2, //17
                         2,//18
                         1,//19
                         1, //20
                         2,//21
                         15,//22
                         0,//23
                         3};//24
//45
//Scene1 is buffer scene, scene2 is where it actually starts.

//The transition times will be the times at which one
//scene transitions to another...based on timesPerScene.
//This gets initialized in the setup() method, using the values
//found in timesPerScene
float[] transitionTimes;

SoundFile mainAudio;

PImage peppaLives;
float peppaX, peppaY;
int xspacing = 16;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 75.0;  // Height of wave
float period = 500.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave
float grav = 0.01;
float len = 50;
float sw = 10;
ArrayList<Firework> fireworks = new ArrayList<Firework>();;

PImage cloud1;
PImage cloud2;
PImage cloud3;
PImage cloud4;
PImage rocks;
PImage sky;
PImage cloud13;
PImage cloud23;
PImage ground13;
PImage ground23;
PImage ground33;
PImage plant2;
PImage rocks2;
PImage sky2;
float angleRotate = 0.0;
SpriteAnimation toxic1;
SpriteAnimation boom;

ArrayList<ParticleSystem> systems;

int count = 100;
 
float[] x = new float[count];
float[] y = new float[count];
float[] h = new float[count];
 
void setup() {
  size(1080, 720, P3D);
  noStroke();
   colorMode(HSB, 360, 100, 100, 100);
  
  //Transition times are when we want the scenes to change
  //while times per scene are the lengths of individual scenes
  transitionTimes = new float[timesPerScene.length];
  transitionTimes[0] = timesPerScene[0];
  for(int i = 1; i < transitionTimes.length; i++) {
    transitionTimes[i] = transitionTimes[i - 1] + timesPerScene[i]; 
  }
  
  mainAudio = new SoundFile( this, "MyAudio.mp3");      //modify this line
  mainAudio.amp(.25);              //setting volume to 25%
  mainAudio.cue( 0 );                //move to 45s in audio
  mainAudio.play();                //start the audio
  
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
  
  //photos for scene 3
  cloud1 = loadImage("clouds_1.png");
  cloud2 = loadImage("clouds_2.png");
  cloud3 = loadImage("clouds_3.png");
  cloud4 = loadImage("clouds_4.png");
  rocks = loadImage("rocks_2.png");
  sky = loadImage("sky.png");
  cloud13 = loadImage("clouds_13.png");
  cloud23 = loadImage("clouds_23.png");
  ground13 = loadImage("ground_13.png");
  ground23= loadImage("ground_23.png");
  ground33 = loadImage("ground_33.png");
  rocks2 = loadImage("rocks2.png");
  plant2 = loadImage("plant2.png");
  sky2 = loadImage("sky2.png");
 
  cloud1.resize(1080, 720);
  cloud2.resize(1080, 720);
  cloud3.resize(1080, 720);
  cloud4.resize(1080, 720);
  rocks.resize(1080, 720);
  sky.resize(1080, 720);
  cloud13.resize(1080, 720);
  cloud23.resize(1080, 720);
  ground13.resize(1080, 720);
  ground23.resize(1080, 720);
  ground33.resize(1080, 720);
  rocks2.resize(1080, 720);
  plant2.resize(1080, 720);
  sky2.resize(1080, 720);
  
  
  toxic1 = new SpriteAnimation("toxic","_","png",1, 10,1,1080,720,false);
  boom = new SpriteAnimation("Explosion","_","png",1, 10,1,1080,720,false);
  
  systems = new ArrayList<ParticleSystem>();
  for (int i=0; i<=50; i++){
   systems.add(new ParticleSystem(1, new PVector(random(1000),random(700))));
  }
   for (int k = 0; k < count; k++) {
    x[k] = random(width);
    y[k] = random(height);
    h[k] = random(360);
  }
}

void draw() {
  //the audio takes a bit to load, so get the start time of the program
  //once we start drawing…but only the first time through the draw method
  if(firstTime) {
    firstTime = false;
    startTime = millis();
  }

  //Gets the number of milliseconds the program has been running,
  //but we must offset by startTime in our calculations because the
  //audio causes a delay at startup
  int now = millis();
  
 // 8, 5, 1, 1, 1, 2, 4, 1, 1, 1, 1, 5, 10, 8, 9, 9, 10
  if( now - startTime < transitionTimes[0] * 1000 ) {
    buffer(); 
  }
  
  else if( now - startTime < transitionTimes[1] * 1000 ) {
    scene2part1(); 
  } 
  else if( now - startTime < transitionTimes[2] * 1000 ) {
    scene2part2(); 
  } 
  else if( now - startTime < transitionTimes[3] * 1000 ) {
    scene2part3(); 
  } 
  else if( now - startTime < transitionTimes[4] * 1000 ) {
    scene2part4(); 
  } 
  else if( now - startTime < transitionTimes[5] * 1000 ) {
    scene2part5(); 
  } 
   else if( now - startTime < transitionTimes[6] * 1000 ) {
    buffer2(); 
  }
  else if( now - startTime < transitionTimes[7] * 1000 ) {
    scene3part1(); 
  }
  else if( now - startTime < transitionTimes[8] * 1000 ) {
    scene3part2(); 
  }
  else if( now - startTime < transitionTimes[9] * 1000 ) {
    scene3part3(); 
  }
  else if( now - startTime < transitionTimes[10] * 1000 ) {
    scene3part4(); 
  }
  else if( now - startTime < transitionTimes[11] * 1000 ) {
    buffer3();
  }
  else if( now - startTime < transitionTimes[12] * 1000 ) {
    scene4(); 
  }
  else if( now - startTime < transitionTimes[13] * 1000 ) {
    scene5(); 
  }
   else if( now - startTime < transitionTimes[14] * 1000 ) {
    scene5part2(); 
  }
  else if( now - startTime < transitionTimes[15] * 1000 ) {
    buffer2(); 
  }
  else if( now - startTime < transitionTimes[16] * 1000 ) {
    scene6(); 
  }
  
  else if( now - startTime < transitionTimes[17] * 1000 ) {
    scene6part2(); 
  }
  
  else if( now - startTime < transitionTimes[18] * 1000 ) {
    buffer2(); 
  }
  else if( now - startTime < transitionTimes[19] * 1000 ) {
  scene7(); 
  }
  else if( now - startTime < transitionTimes[20] * 1000 ) {
  scene7part2(); 
  }
  else if( now - startTime < transitionTimes[21] * 1000 ) {
  buffer2();
  }
  else if( now - startTime < transitionTimes[22] * 1000 ) {
    scene8(); 
  }
  else if( now - startTime < transitionTimes[23] * 1000 ) {
    buffer(); 
  }
  else if( now - startTime < transitionTimes[24] * 1000 ) {
    scene8part2(); 
    background(0);
  } 
  else {
    endScene();
  }
}

///////////////////////////////////////////
//BELOW HERE ARE THE VARIOUS SCENE METHODS
//AND THE HELPER METHODS USED BY THE SCENES
///////////////////////////////////////////


void buffer() {
  background(0,0,0);
}


void scene2part1() {
   
  int gridSize = 100;

for (int x = gridSize; x <= width - gridSize; x += gridSize) {
  for (int y = gridSize; y <= height - gridSize; y += gridSize) {
    noStroke();
    fill(255);
    rect(x-1, y-1, 3, 3);
    stroke(255, 100);
    line(x, y, width/2, height/2);
  }
}
}

void scene2part2() {
   background(0,0,0);
  int gridSize = 200;

for (int x = gridSize; x <= width - gridSize; x += gridSize) {
  for (int y = gridSize; y <= height - gridSize; y += gridSize) {
    noStroke();
    fill(255);
    rect(x-1, y-1, 3, 3);
    stroke(360, 100, 100,100);
    line(x, y, width/2, height/2);
  }
}
}

void scene2part3() {
   background(0,0,0);
  int gridSize = 150;

for (int x = gridSize; x <= width - gridSize; x += gridSize) {
  for (int y = gridSize; y <= height - gridSize; y += gridSize) {
    noStroke();
    fill(255);
    rect(x-1, y-1, 3, 3);
    stroke(240, 100, 100, 100);
    line(x, y, width/2, height/2);
  }
}
}

void scene2part4() {
  background(0,0,0);
  int gridSize = 120;

for (int x = gridSize; x <= width - gridSize; x += gridSize) {
  for (int y = gridSize; y <= height - gridSize; y += gridSize) {
    noStroke();
    fill(255);
    rect(x-1, y-1, 3, 3);
    stroke(90, 100, 100, 100);
    line(x, y, width/2, height/2);
  }
}
}

void scene2part5() {
   background(0,0,0);
  int gridSize = 100;

for (int x = gridSize; x <= width - gridSize; x += gridSize) {
  for (int y = gridSize; y <= height - gridSize; y += gridSize) {
    noStroke();
    fill(255);
    rect(x-1, y-1, 3, 3);
    stroke(255, 100);
    line(x, y, width/2, height/2);
  }
}
}

void buffer2() {
  background(0,0,0);
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }
}

void scene3part1() {
  image(rocks, 0, 0);
}
void scene3part2() {
 
  image(sky, 0, 0);
  image(cloud1, 0, 0);
  image(cloud2, 0, 0);
  image(cloud3, 0, 0);
  image(cloud4, 0, 0);
  image(rocks, 0, 0);
}
void scene3part3() {
   background(0, 0,0);
  image(rocks2, 0, 0);
  image(plant2, 0, 0);
  image(ground13, 0, 0);
  image(ground23, 0, 0);
  image(ground33, 0, 0);
}
void scene3part4() {
  background(0, 0,0);
  image(sky2, 0, 0);
  image(rocks2, 0, 0);
  image(plant2, 0, 0);
  image(ground13, 0, 0);
  image(ground23, 0, 0);
  image(ground33, 0, 0);
  image(cloud13, 0, 0);
  image(cloud23, 0, 0);
}

void buffer3(){
  background(0,0,0);
}

void scene4() {
  background(0);
  textFont(createFont("Georgia Bold", 36));
  textSize(100);
  pushMatrix();
  translate(540,360);
  rotate(radians(angleRotate));
  fill(350, 25, 100);
  tint(255, 127);
  text("Yeah", 0, 0);
  popMatrix();
  
  angleRotate += 10;
  
}

void scene5() {
  background(0,0,0);
  textFont(createFont("Georgia Bold", 36));
  textSize(100);
  fill(39, 100, 100);
  tint(255, 127);
  textAlign( CENTER, CENTER );
  text("Can't Help Myself", width/2, height/2);
}

void scene5part2() {
  background(0,0,0);
  textFont(createFont("Georgia Bold", 36));
  textSize(100);
  fill(184, 93, 85);
  tint(255, 127);
  textAlign( CENTER, CENTER );
  text("Can't Help Myself",  width/2, height/2);
}
void scene6() {
  float heartSize = random(10, 100);
  float heartX = random(width);
  float heartBottomY = random(height+heartSize);

  float h = random(360);

  fill(h, 100,100);
  stroke(h, 100,100);

  //fill in line that sometimes appears between halves
  line(heartX, heartBottomY, heartX, heartBottomY-heartSize*.75);

  //left half of heart
  beginShape();
  curveVertex(heartX, heartBottomY+heartSize); //anchor point
  curveVertex(heartX, heartBottomY); //bottom tip
  curveVertex(heartX - heartSize/2, heartBottomY-heartSize/1.5); //left edge
  curveVertex(heartX - heartSize/3, heartBottomY-heartSize); //top of left edge
  curveVertex(heartX, heartBottomY-heartSize*.75); //top middle dip
  curveVertex(heartX, heartBottomY); //guiding point
  endShape();

  //right half of heart
  beginShape();
  curveVertex(heartX, heartBottomY);
  curveVertex(heartX, heartBottomY-heartSize*.75);
  curveVertex(heartX + heartSize/3, heartBottomY-heartSize);
  curveVertex(heartX + heartSize/2, heartBottomY-heartSize/1.5);
  curveVertex(heartX, heartBottomY);
  curveVertex(heartX, heartBottomY + heartSize);
  endShape();
}

void scene6part2() {
  background(0);
  for (ParticleSystem ps : systems) {
    ps.run();
    ps.addParticle();
  }
}
void scene7() {
  background(0,0,0);
  toxic1.update();
  toxic1.displayAt(0, 0);
}

void scene7part2() {
  background(0,0,0);
  boom.update();
  boom.displayAt(0, 0);
}

void scene8(){
  background(0,0,0);
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

void scene8part2(){
  background(0,0,0);
  len = 80;
 sw = 40;
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

void endScene() {
  for(int i = 0; i < count; i++){
    x[i] += random(0, 10);
    y[i] += random(0, 10);
   
    if(x[i] < 0){
     x[i] = width;
    }
    if(x[i] > width){
      x[i] = 0;
    }
   
    if(y[i] < 0){
      y[i] = height;
    }
    if(y[i] > height){
     y[i] = 0;
    }

    stroke(h[i],100,100);
    strokeWeight(3);
    point(x[i], y[i]);
   
  }
  //Use x and y for text as center of text block
  textAlign( CENTER, CENTER );
  
 fill(0,0,100);
  textSize( 200 );
  text( "Toxic", width/2, height/2 ); 
  
    fill(0,0,100);
  textSize( 35 );
  text( "Toxic by Steve Zhang", width/2, height - 150 );
}
