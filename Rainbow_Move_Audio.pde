import processing.serial.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Serial myPort;  // Create object from Serial class
Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;

class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;
  
  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
  
  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}

void setup() 
{
  size(200, 200, P3D);
  minim = new Minim(this);
  song = minim.loadFile("song4.mp3", 2048);
  song.play();
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(300); 
  bl = new BeatListener(beat, song); 
  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

void draw() 
{
  if (beat.isKick())
  {                         
    myPort.write('1'); 
    println("1");
  } 
  else 
  {                          
    myPort.write('0');
    println("0");
  }   
}
