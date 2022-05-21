/* NOTES
Song: Toxic by Iverness
*/
import processing.sound.*;

//these two variables help with calculating the delay when the 
//project starts up...so that the timing can be consistent 
boolean firstTime = true;
int startTime;


//The length, in seconds, of each scene of your animation
float[] timesPerScene = {7, 10, 8, 10, };

//The transition times will be the times at which one
//scene transitions to another...based on timesPerScene.
//This gets initialized in the setup() method, using the values
//found in timesPerScene
float[] transitionTimes;

SoundFile mainAudio;

PImage peppaLives;
float peppaX, peppaY;


void setup() {
  size(2560, 2560);
  
  //Transition times are when we want the scenes to change
  //while times per scene are the lengths of individual scenes
  transitionTimes = new float[timesPerScene.length];
  transitionTimes[0] = timesPerScene[0];
  for(int i = 1; i < transitionTimes.length; i++) {
    transitionTimes[i] = transitionTimes[i - 1] + timesPerScene[i]; 
  }
  
  mainAudio = new SoundFile( this, "thissong.mp3");      //modify this line
  mainAudio.amp(.25);              //setting volume to 25%
  mainAudio.cue( 0 );                //move to 45s in audio
  mainAudio.play();                //start the audio
  
  //peppaLives = loadImage("obama.jpg");        //modify this line
  peppaX = 100;                //starting location for img
  peppaY = 100;
  
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
  
  if( now - startTime < transitionTimes[0] * 1000 ) {
    scene1(); 
  }
  else if( now - startTime < transitionTimes[1] * 1000 ) {
    scene2(); 
  }  
  else if( now - startTime < transitionTimes[2] * 1000 ) {
    scene3(); 
  }
  
  else {
    background(242, 142, 221);
    endScene();
  }
}

///////////////////////////////////////////
//BELOW HERE ARE THE VARIOUS SCENE METHODS
//AND THE HELPER METHODS USED BY THE SCENES
///////////////////////////////////////////


void scene1() {
  textAlign( CENTER, CENTER );
  
  fill(0);
  textSize( 200 );
  text( "The End", width/2, height/2 ); 
  
  
  fill( 0, 120, 161 );
  textSize( 35 );
  text( "Peppa Lives! by Maunu", width/2, height - 150 );
}


void scene2() {
  
  /* THIS IS JUST A SAMPLE...YOU CAN USE IT AS A MODEL

  //draw a bunch of random dots...random locations each frame
  fill(84, 93, 245);
  for(int i = 0; i < 500; i++) {
     ellipse( random(width), random(height), 5, 5);
  }
  */
}


void scene3() {
  
  /* JUST A SAMPLE...
  
  //set size and color based on current time
  int time = millis() / 4;
  int size = time % width;
  fill( time % 256, 2*time % 256, 100 + time%156 );
  ellipse( width/2, height/2, size, size );
  
  */
}


void endScene() {
  //Use x and y for text as center of text block
  textAlign( CENTER, CENTER );
  
  fill(0);
  textSize( 200 );
  text( "The End", width/2, height/2 ); 
  
  
  fill( 0, 120, 161 );
  textSize( 35 );
  text( "Peppa Lives! by Maunu", width/2, height - 150 );
}
