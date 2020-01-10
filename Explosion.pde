import java.util.ArrayList;

class Explosion {

  ArrayList<Explosion> explosions;
  PImage[] images ;
  PVector pos = new PVector();
  PVector siz = new PVector();
  float scale = 0.1;
  int count;
  int currentFrame;
  int framesPerImage = 5;

  Explosion(PVector _pos, PVector _siz, ArrayList<Explosion> _e, PImage[] _images, int _framesPerImage) {
    explosions = _e;
    explosions.add(this);
    pos = _pos;
    siz = _siz;
    images = _images;
    framesPerImage = _framesPerImage;
    count = 0;
  }

  void draw() {
    if (checkActive()){
      image(images[currentFrame], pos.x, pos.y, siz.x, siz.y);
    }
    else {
       explosions.remove(this); 
    }
  }

  boolean checkActive() {
    count ++;
    currentFrame = count/framesPerImage;
    return currentFrame < images.length;
  }
}