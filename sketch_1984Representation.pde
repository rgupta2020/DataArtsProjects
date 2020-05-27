import processing.sound.*;

PImage img;
PImage img2;
PFont f;

// Oscillator and envelope 
TriOsc triOsc;
Env env; 

// Times and levels for the ASR envelope
float attackTime = 0.001;
float sustainTime = 2;
float sustainLevel = 0.2;
float releaseTime = 0.2;

// This is an octave in MIDI notes.
float[] freqSequence = { 
  288.2, 497.8, 471.6, 366.8
}; 

// Set the duration between the notes
int duration = 1984;
// Set the note trigger
int trigger = 0; 

// An index to count up the notes
int note = 0; 
int textNum = 0;

int xSize = 900;
int ySize = 600;

void setup() {
  size(900, 600);
  background(255, 69, 0);
  
  img = loadImage("orange.jpg");
  img2 = loadImage("black.jpg");
  
  f = createFont("Arial",16,true);
  
  // Create triangle wave and envelope 
  triOsc = new TriOsc(this);
  env  = new Env(this);
  
  image(img, 0, 0);
  
  delay(10000);
}
String[] strArr = {"1", "9", "8", "4", "Big", "Brother", "Is", "Watching"};
void draw() {
  
  textFont(f,200); 
  fill(0);
  // If value of trigger is equal to the computer clock and if not all 
  // notes have been played yet, the next note gets triggered.
  if ((millis() > trigger) && (note<freqSequence.length)) {
    if(textNum<4){
      text(strArr[textNum],note*xSize/4,ySize/2);
    }
    else{
      textFont(f,170);
      image(img2,0,0);
      image(img2, 0, 0, width*2, height*1.5);
      fill(255);
      text(strArr[textNum],note*50,note*100+180);
    }
    // midiToFreq transforms the MIDI value into a frequency in Hz which we use 
    //to control the triangle oscillator with an amplitute of 0.8
    triOsc.play(freqSequence[note], 0.8);

    // The envelope gets triggered with the oscillator as input and the times and 
    // levels we defined earlier
    env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);

    // Create the new trigger according to predefined durations and speed
    trigger = millis() + duration;
  
    // Advance by one note in the midiSequence;
    note++;
    textNum++;

    // Loop the sequence
    if (note == 4) {
      note = 0;
    }
    
    if(textNum == 8){
      textNum = 0;
    }
  }
} 
