  import java.util.ArrayList;
  /**
   * Running Platform Game (3.0)
   *complete
   *sound
   *final gif
   *healthpack
   *three + game states
  Program uses all required provided functions  (drawProjectile(), drawExplosion())
  ****Program has correct required functions (detectHit(), startScreen(), gameScreen(),endScreen() 
  *Health for character
  *Player fires bullets
  *Player jumps  with gravity
  *Boss level 
  *Boss has health
  *Player has lives to go to end state
  *Game has a score
  *Two power ups
  *Boss fires
  *Enemies fire
   *background music
   *Event sounds - coins 
   *multiple levels 2+ (level 1, level 2, level 3 and draw boss)
   * @author Haider Khan 
   * Character movement/projecticles/ PVectors developed by Mr.Rowbottom
   * Takes the under standing of PVectors and PVector array and implemet them to create a running and a run and gun platform game 
   * Use PVector array to randomly spawn a varitry of projectiles 
   *use the the up arrow key to make the character jump and move forward and backwords
   *Contain array of PVectors for animations 
   *Program has two power ups (Sheild & Healthpack)
   *Program uses the varibile playerhealth to decrease the width of the health bar as the player collides with the enemy projectiles and uses similar algorith to implement boss health 
   *Game has progression as the player collects more and more coins first progression is initiated as the character has collected 20>= coins 
   *Program uses soundfiles to implement sound
   *Running game has multiple game states, introduction state, instruction state, game state, drawboss state, end state, win state(conclusion state)
   Implements drawbullet and drawexplosions to create the boss
   Uses the draw turrent to make player bullets 
   *///
  
  // sound variables
  import processing.sound.*; // imports sound library
  // sets the name for the sound files
  SoundFile file; 
  SoundFile Coins;
  SoundFile Theme2;
  
  //explosions variables
  //need this to implement explosions
  ArrayList <Explosion> explosions;//this will hold the explosions you need to make
  int numberOfExplosionsImages = 8;//set this to your amount of explosion images
  PImage[] explImages = new PImage[numberOfExplosionsImages];//your explosion frames of animation
  //PVector mouse;//only needed for the example and used to place explosions
  
  //ball variables and constants
  float floor = 500;
  int numCircles = 10;
  int shieldTimer = 200;
  PVector[] bPos;
  PVector[] bVel;
  int frameSkip=6;
  PVector[] bSiz;
  int [] circleModes= new int[numCircles];
  color[] bCol;
  color pCol = color(0, 50, 150);
  color okCol = color(0, 50, 150);
  color hitCol = color(200, 50, 0);
  color shieldCol= color (50, 240, 255, 100);
  PImage [][] frames= new PImage[3][4];
  int currentFrame=0;//currentframe of player animation 
  int frameMode=0;//mode of frames to be drawn based on what the player is doing 
  PVector pos;
  PVector siz;
  PVector vel;
  PVector acc;
  float speed = 5;
  float jumpSpeed=-20;
  boolean canJump = true;
  int amo = 500; 
  // game layout code
  PVector expolocation; 
  //stae and background changing colour variable 
  int state=0;
  float tree = 1;
  
  //button variables
  float mouseW;
  int ellipseSize=150;
  int ellipseSize2=150;
  int instructions=1;
  float mouseH;
  boolean restart=false;
  boolean startGame=false;
  boolean introOnly=false;
  boolean testmode =true;
  // boolean for new levels 
  boolean leveltwo = false;
  boolean levelthree = false;
  boolean levelfour;
  boolean bosslevel = false;  
  boolean sheildon = false;
  float buttonSelecter=0;
  float m = 1;//user slope
  float b = 10;//user y-intercept
  float randM = 0;//the random gtarget slope
  float randB = 0;//the randome target y-intercept
  int startbuttonX = 480;
  int startbuttonY = 250;
  
  //variable for gif 
  PImage [] frame_;
  PImage [] Proj_;
  PImage [] SheildOn_;
  PImage [] Sheild_;
  PImage [] COIN_;
  PImage [] over_;
  PImage [] enemy_;
  PImage [] enemy3_;
  PImage [] back2_; // for level 2
  PImage [] boss_;
  PImage [] win_;
  int framesmovement = 0;
  int frameskip = 5;
  
  // varibale for images
  PImage Platforn_1;
  PImage Platform_2;
  PImage healthpack;
  PImage Restart_Game;
  PImage Play;
  PImage Mute;
  
  //health/score variables
  int playerhealth = 500;
  int score = 0;
  int lives = 3;
  
  //variables for map chosing 
  PImage Map_1;
  PImage Map_2;
  PImage backlev3;
  PImage backboss;
  boolean map1 = true;
  boolean map2 = false;
  
  //variables for turrent 
  PVector tPos = new PVector(100, 550);
  PVector tDir = new PVector();
  PVector mouse = new PVector();
  PVector location = new PVector();
  PVector bosslocation = new PVector();
  PVector Tacc = new PVector(0, 2);
  PVector [] TbPos = new PVector[]{new PVector(-1000, -1000), new PVector(-1000, -1000), new PVector(-1000, -1000)};
  PVector [] TbVel = new PVector[]{new PVector(-1000, -1000), new PVector(-1000, -1000), new PVector(-1000, -1000)};
  int bIndex = 0; //which bullet is available to fire 
  
  //variables for enemy bullets 
  
  //for the drawBullet example
  PImage bullet;
  PVector bulletPos;
  PVector bulletVel;
  PVector bulletSiz;
  int x = 650;
  int y = 375;
  int bosshealth = 300;
  boolean testingMode = true;
  
  //setup function
  void setup() {
    size(800, 600);
    rectMode(CENTER);
    imageMode(CENTER);
    //platforms (actual maps/game locations)
    Platforn_1 = loadImage("Platforn_1.jpg");
    Platform_2 = loadImage("Platform_2.jpg");
  
    //Images for platform chosing (just the pictures for user to chose)
    Map_1 = loadImage("Platforn_1.jpg");
    Map_2 = loadImage("Platform_2.jpg");
  
    // Health/Defense bar pictures
   backlev3 = loadImage("background_3.jpg");
   backboss = loadImage("background4.jpg");
  
    // initalizing health packs picture
    healthpack = loadImage("healthpack.png");
  
    //inilizing restart button image 
    Restart_Game = loadImage("Restart_Game.png");
  
    //inits picture for play and mute button
    Play = loadImage("Play.png");
    Mute = loadImage("Mute.png");
  
    init();// initalizes init fucntion 
  
    //plays the main theme song 
    file = new SoundFile(this, "Theme_Song.mp3");
    file.play();
    //sound file coins
  } 
  // init function
  void init() {
    //load up the bullet image
    bullet =loadImage("bullet.png");
    //set up the bullet vectors
    bulletPos = new PVector(100, 500);
    bulletVel = new PVector(20, -50);
    bulletSiz = new PVector(50, 50);
  
    //make the list that will hold the explosions
    explosions = new ArrayList<Explosion>();
    //load up the explosion images
    for (int i = 0; i < explImages.length; i++) {
      explImages[i] = loadImage("explosion"+i+".png");
    }
    //create the player pvectors
    //imageMode(CENTER);
    siz = new PVector(120, 120);
    pos = new PVector(siz.x, floor - siz.y/2);
    vel= new PVector ();
    acc= new PVector (0, 0.8);
    //create the arrays
    bPos = new PVector [numCircles];
    bVel = new PVector [numCircles];
    bSiz = new PVector [numCircles];
    bCol = new color   [numCircles];
  
  
    //initialize everything in the arrays with a for loop
    //________________________________________________________________________________________________________________
    for (int i = 0; i < numCircles; i++) { 
      bSiz[i] = new PVector(100, 100);
      bVel[i] = new PVector(random(-8, -4), 0);
      bCol[i] = color(200, random(0, 120), random(0, 160));
      circleModes[i]=0;
    }
    //for (int i=0; i<frames.length; i++){
    for (int i=0; i < 2; i++) {
      for (int j=0; j<frames[i].length; j++) {//for every eleent in the row 
        frames[i][j]= loadImage("PlayerRun"+i+j+".png");
      }
    }
    bPos[0] = new PVector(width+200, floor - bSiz[0].y/2);// -siz.y/2 to lift us out of the floor
  
    //loads the numerous gifs through out the game
    //main screen gif
    frame_ = new PImage[50];
    //for eacg unage in the array
    for (int i = 0; i < frame_.length; i++) {
      //load the images into the array
      frame_[i] = loadImage("frame_"+i+".gif");
    }
        //level two background
    back2_ = new PImage[16];
    //for eacg unage in the array
    for (int i = 0; i < back2_.length; i++) {
      //load the images into the array
      back2_[i] = loadImage("back2_"+i+".jpg");
    }
    

    // load images for enemy # 2
    enemy_ = new PImage[5];
    //for each image in the array
    for (int i = 0; i <enemy_.length; i++) {
      //load images into the array
      enemy_[i] = loadImage("enemy_"+i+".gif");
    }
    // load images for enemy # 3
    enemy3_ = new PImage[2];
    //for each image in the array
    for (int i = 0; i <enemy3_.length; i++) {
      //load images into the array
      enemy3_[i] = loadImage("enemy3_"+i+".gif");
    }
    // drawing a projectile
    Proj_ = new PImage[4];
    for (int i = 0; i < Proj_.length; i++) {
      //load the images into the array
      Proj_[i] = loadImage("Proj_"+i+".gif");
    }
    // initalizing sheild on
    SheildOn_ = new PImage[9];
    for (int i = 0; i < SheildOn_.length; i++) {
      //load the images into the array
      SheildOn_[i] = loadImage("SheildOn_"+i+".gif");
    }
    //initalizing sheild projectiles
    Sheild_ = new PImage[7];
    for (int i = 0; i < Sheild_.length; i++) {
      //load the images into the array
      Sheild_[i] = loadImage("Sheild_"+i+".gif");
    }
    //initalizing COINprojectiles
    COIN_ = new PImage[10];
    for (int i = 0; i < COIN_.length; i++) {
      //load the images into the array
      COIN_[i] = loadImage("COIN_"+i+".gif");
    }
    
      //initalizing boss projectiles
    boss_ = new PImage[16];
    for (int i = 0; i < boss_.length; i++) {
      //load the images into the array
      boss_[i] = loadImage("boss_"+i+".png");
    }
    // end state gif background
    over_ = new PImage[11];
    for (int i = 0; i < over_.length; i++) {
      //load the images into the array
      over_[i] = loadImage("over_"+i+".gif");
    }
        // end state gif background
    win_ = new PImage[12];
    for (int i = 0; i < win_.length; i++) {
      //load the images into the array
      win_[i] = loadImage("win_"+i+".gif");
    }
  }
  
  
  //the add explosions is just to simplify the action of making an explosion
  void addExplosion(PVector pos, PVector siz, int animationRate) {
    new Explosion(pos, siz, explosions, explImages, animationRate);//makes an explosion and adds it to a list
    //maybe add an explosions should to play here
  }  
  
  // instruction function
  void instructions() {
    background(frame_[framesmovement]);
  
    // SETTINg up the gif 
    if (frameCount % frameSkip == 0) {
      framesmovement++;
    }
  
    // check to see if framess equal to banana.length
    if (framesmovement >= frame_.length) {
  
      //set frames back to 0frames = 0
      framesmovement = 0;
    }
    // instrcutions title 
    textSize(68);
    tree = tree + 0.01;
    fill(sin(tree)*293, sin(tree)*199 + 250, cos(tree+5)*125);
    text("Instructions", 220, 50);
  
    // instruction # 1 
    textSize(30);
    fill(#1A51D8);
    text("*Use Up Arrow Key to Make Character Jump", 50, 120);
  
    //instruction # 2
    textSize(30);
    fill(#1A51D8);
    text("*Dodge Obstacles to Maintain Health", 50, 180);
  
    // instruction # 3
    textSize(30);
    fill(#1A51D8);
    text("*Shoot To Kill enemies", 50, 240);
  
    // instruction # 1 
    textSize(30);
    fill(#1A51D8);
    text("*Defeat The Boss to Win the Game", 50, 300);
  
    // drawing the images for map chosing 
    image(Map_1, 120, 440, 200, 200);
    image(Map_2, 680, 440, 200, 200);
  
    //draws return button
    tree = tree + 0.01;
    fill(sin(tree)*293, sin(tree)*199 + 250, cos(tree+5)*125);
    rect(410, 540, 250, 100, 25);
    fill(255);
    textSize(45);
    text("Return", 340, 550);
  }
  
  void winstate(){
        // sets the background gif
    background(win_[framesmovement]);
  
    // SETTINg up the gif 
    if (frameCount % frameSkip == 0) {
      framesmovement++;
    }
  
    // check to see if framess equal to banana.length
    if (framesmovement >= win_.length) {
  
      //set frames back to 0frames = 0
      framesmovement = 0;
    }
    textSize(100);
    fill(255,0,0);
   text("YOU WON",260,150);
  }
  
  
  // declaring states
  void mouseClicked() { 
    // when screen is clicked produce a random value 
    if (state==0 && introOnly==true) {
      state=1;
    }
    if (state==1 && restart==true) {
      state=0;
    }
    if (state==0 && startGame==true) {
      state=2;
    }
    // if you are in the win state and screen is cliked return to play state 
    if (state == 3) {
      state = 2;
    }
    // set up the turrent mouse clicked
    TbPos[bIndex].set(pos);
    TbVel[bIndex].set(tDir);
    bIndex++; //since I just fired a bullet , update the index
    if (bIndex >= TbPos.length) {
      bIndex = 0;
    }
  }
  
  //function that checks parameters for the start, instructions and return button (Resize them all)
  void mousePressed() {
    //checks parameters of instrcutons button 
    if ((mouseX<500) && (mouseX>350) && (mouseY>325) && (mouseY < 490)) {
      ellipseSize=175;
      instructions=0;
      introOnly=true;
    } else if (instructions==0) {
      ellipseSize=150;
      introOnly=false;
    } 
    //checks parameters of return button 
    if ((mouseX>285) && (mouseX<535) && (mouseY>490) && (mouseY<590) && state==1) {
      instructions=1;
      restart=true;
    } else if (instructions==1) {
      restart=false;
    }
    //checks pramaters for the start button 
    if ((mouseX>350) && (mouseX<510) && (mouseY>42) && (mouseY<200) && state==0) {
      ellipseSize2=175;
      startGame=true;
    } else if (state==0) {
      ellipseSize2=150; 
      startGame=false;
    }
  
    if (state == 1) {
      // checks parameters for map 1 
      if ((mouseX> 20) && (mouseX<220) && (mouseY>340) && (mouseY<540)) {
        map1 = true;
        map2 = false;
      } else {
        Map_1.resize(260, 260);
      }
  
      // checks prameters for button 2  
      if ((mouseX>580) && (mouseX<775) && (mouseY> 340) && (mouseY<540)) {
        map1 = false;
        map2 = true;
      } else {
        Map_2.resize(260, 260);
      }// ends else
    } // ends state == 1 button detection
  
    // buttons for play
    if ((mouseX>10)&&(mouseX<100)&&(mouseY>10) && (mouseY<100 && mousePressed)) {
      Theme2 = new SoundFile(this, "Theme_Song.mp3");
      Theme2.play();
    }
    // checks prameter for the mute button
    if ((mouseX>670) && (mouseX<760) && (mouseY>10) && (mouseY< 100 && mousePressed)) {
      //  file.stop();
    }
  }// ends mouse clicked function
  
  boolean detectHit(PVector pos1, float siz1, PVector pos2, float siz2) {
    return PVector.dist (pos1, pos2) < (siz1+siz2)/2;
  }
  
  //draw bullet function taken from summative requried functions // all varibales have a B with them to make them seperate from player variables 
  void drawBullet(PVector _Bpos, PVector _Bdir, PVector _Bsiz, PImage _Bimg) {//make sure you dont change this in any way.  Talk to me if you need additional functionality
    pushMatrix();
    translate(_Bpos.x, _Bpos.y);
    rotate(_Bdir.heading());
    image(_Bimg, 0, 0, _Bsiz.x, _Bsiz.y);  
    popMatrix();
  }
  
//draw boss function  
  void drawboss() {
    //draws the hit detection circle
   ellipse(x,y,150,150);
   fill(#1708FC);
   //health bar for the enemy 
   rect(400,570,bosshealth,20);
   fill(255);
   textSize(15);
   text("Boss Health",370,575);
   //draws the gif for the enemy 
        if (bosslevel == true) {
   
            if (frameCount % frameSkip == 0) {
              framesmovement++;
            }
            // check to see if framess equal to banana.length
            if (framesmovement >= boss_.length) {
  
              //set frames back to 0frames = 0
              framesmovement = 0;
            }
            //draw the image 
            image(boss_[framesmovement], x, y);
          }
  //handles movement for the enemy   
   x = x -1;
   if(x<250){
     x = x - 1;
     x = 600;
   }
    // draws the bullets from the boss level
    if (random(0, 100) > 90 && bulletPos.y > height) {//you cant fire unless the previous bullet is off the screen
      //reset the bullet posiition and vel just for the example
    //  bulletPos = new PVector(600, 350);//just example starting position and speeds
      bulletPos = new PVector(x,y);//just example starting position and speeds
      bulletVel = new PVector(-11, random(-20, -35));
    }
    //doing all the bullet stuff together   
    bulletVel.y += 1.4;//adding gravity which I am just using a number 1.4
    bulletPos.add(bulletVel);
  
    drawBullet(bulletPos, bulletVel, bulletSiz, bullet);
  
  // checks to if the boss's bullets are deteting the player
    if (detectHit(bulletPos, 30, pos, 100)) {
       textSize(25);
      playerhealth = playerhealth - 1;
      //addExplosion(location, new PVector(100,100), 5);//this is only for this example
    }
    
    
  }
  
  // start screen fucntion with all features developed
  void startScreen() {
    // sets the background gif
    background(frame_[framesmovement]);
  
    // SETTINg up the gif 
    if (frameCount % frameSkip == 0) {
      framesmovement++;
    }
  
    // check to see if framess equal to banana.length
    if (framesmovement >= frame_.length) {
  
      //set frames back to 0frames = 0
      framesmovement = 0;
    }
  
    //play button
    strokeWeight(0);
    fill(255, 0, 0);
    ellipse(425, 120, ellipseSize2, ellipseSize2);
    fill(255, 255, 255);
    textSize(20);
    text("Start Game", 375, 120);
  
    //instructions button
    strokeWeight(0);
    fill(42, 42, 235);
    ellipse(425, 400, ellipseSize, ellipseSize);
    fill(252, 255, 255);
    textSize(20);
    text("Instructions", 368, 405);
  
    // making the mute button
    image(Play, 55, 60, 100, 100);
    image(Mute, 720, 60, 100, 100);
  }
  
  // reset function in place if health bar width == 0 than initate this function
  void reset() {
    background(over_[framesmovement]);
  
    // SETTINg up the gif 
    if (frameCount % frameSkip == 0) {
      framesmovement++;
    }
  
    // check to see if framess equal to banana.length
    if (framesmovement >= over_.length) {
  
      //set frames back to 0frames = 0
      framesmovement = 0;
    }
  
    //printing final socre 
    textSize(75);
    strokeWeight(5);
    tree = tree+1;
    fill(sin(tree)*293, sin(tree)*199 + 250, cos(tree+5)*125);
    text("Score:"+score, 20, 250);
  }
  
  void keyPressed() {
    if (keyCode == LEFT) {
      vel.set(-speed, 0);
    } else if (keyCode == RIGHT) {
      vel.set(speed, 0);
    }
  }
  void keyReleased() {
    if (keyCode == LEFT || keyCode == RIGHT) {
      vel.set(0, vel.y);
    }
  }
  // draw function    
  void draw() {
    if (state==0) { // state = 0 draw start screen
      startScreen(); // calling start screen fucntion
    }
  
    if (state==1) { // if  state = 1 than go to instructions
      instructions();
    }
  
    if (state == 2) { // play state all the game variables/ functions are under here
      // boolean statement that declares which map is going to be played 
      if (map1 == true) {
        background(Platforn_1);
      }
      if (map2 == true) {
        background(Platform_2);
      }
      //background for level 2
      if (leveltwo == true) {
    background(back2_[framesmovement]);
  
    // SETTINg up the gif 
    if (frameCount % frameSkip == 0) {
      framesmovement++;
    }
  
    // check to see if framess equal to banana.length
    if (framesmovement >= back2_.length) {
  
      //set frames back to 0frames = 0
      framesmovement = 0;
    }
      }
       //boss level backgrond
       if (levelthree == true) {
        background(backlev3);
      }

      //boss level backgrond
       if (bosslevel == true) {
        background(backboss);
      }
      // drawing the health bar
      // setting up time variable 
      fill(255, 0, 0);
      rect(400, 15, playerhealth, 25);
      fill(255);
      textSize(20);
      text("Health", 350, 18);
      //creating health bar image
      // printing score and coin gif 
      text("Score: "+score, 695, 25);
      //print lives
      text("Lives "+ lives,35,25);
  
      // draw explosions
  
      //you need this to go through and draw each explosion, I automatically handle the animation and even rtemoving the explosion when done from the list
      for (int i = 0; i < explosions.size(); i++) {
        explosions.get(i).draw();
      }
      //print (pos);
      pCol = okCol;//
      //for each of the circles
      for (int i = 0; i < numCircles; i++) {
        //use a random number to spawn in circles
        // randomization of the apparence of circles in the beginning of the game
         if(score >= 0){
           if(score>=0 && score<=2){
             textSize(35);
             fill(255,0,0);
             text("Level One",355,300);
           }
         if (random(0, 10000)> 9980 && bPos[i] == null){// contrls number of circles
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
         bVel[i] = new PVector(random(-8, -4), 0);
         bCol[i] = color(200, random(0, 120), random(0, 160));
         
         if (random(0,100) > 95){ // controls number of sheild / the less the number the more the shilds, vise versa 
         circleModes[i]=2;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
       }
         else if (random(0,100) > 50){ // controls squares for COINs 
         circleModes[i]=1;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));
         
       }
         else if (random(0,100) > 97){ // controls squares for health packs
         circleModes[i]=3;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));
         
       }
         else {
         circleModes[i]=0; // contrls circs
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
         
        }
     }
  }
         // level two
         if (score >= 15) {
         leveltwo = true; 
           if(score>=15 && score<=18){
             textSize(35);
             fill(255,0,0);
             text("Level Two",355,300);
           }
         if (random(0, 10000)> 9975 && bPos[i] == null) {// contrls number of circles
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
         bVel[i] = new PVector(random(-8, -4), 0);
         bCol[i] = color(200, random(0, 120), random(0, 160));
         
         if (random(0,100) > 96){ // controls number of sheild 
         circleModes[i]=2;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
      }
         else if (random(0,100) > 55){ // controls squares for COINs 
         circleModes[i]=1;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));
      }
         else if (random(0,100)> 97){ // controls squares for health packs
         circleModes[i]=3;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));
      }
         else if(random(0,100) > 70){ // contrls number for the the xtra enemy 
         circleModes[i]=4;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));// -bSiz[i].y/2 to lift us out of the floor;
      }
         else {
         circleModes[i]=0; // contrls circs
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
        }
      }
    }
         
         // level three
         if(score >= 30){
         levelthree = true;
          if(score>=30 && score<=34){
             textSize(35);
             fill(#1607F5);
             text("Level Three",355,300);
           }
         if (random(0, 10000)> 9970 && bPos[i] == null) {// contrls number of circles
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
         bVel[i] = new PVector(random(-8, -4), 0);
         bCol[i] = color(200, random(0, 120), random(0, 160));
         
         if (random(0,100) > 97){ // controls number of sheild 
         circleModes[i]=2;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
       }
         else if (random(0,100) > 60){ // controls squares for COINs 
         circleModes[i]=1;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));
       }
         else if (random(0,100)> 98){ // controls squares for health packs
         circleModes[i]=3;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));
       }
         else if(random(0,100) > 65){ // enemy # 2
         circleModes[i]=4;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));// -bSiz[i].y/2 to lift us out of the floor;
       }
         else if(random(0,100) > 50){ // enemy # 3 
         circleModes[i]=5;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor;
      }
         else {
         circleModes[i]=0; // enemy # 1
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
        }
      }
    }
    
             //boss level projectiles 
         if(score >= 45){
          if(score>=45 && score<=48){
             textSize(35);
             fill(#1607F5);
             text("Boss Level",355,300);
           }
         if (random(0, 10000)> 9995 && bPos[i] == null) {// contrls number of circles
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
         bVel[i] = new PVector(random(-8, -4), 0);
         bCol[i] = color(200, random(0, 120), random(0, 160));
         
         if (random(0,100) > 96){ // controls number of sheild 
         circleModes[i]=2;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor
       }
         else if (random(0,100) > 100){ // controls squares for COINs 
         circleModes[i]=1;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));
       }
         else if (random(0,100)> 100){ // controls squares for health packs
         circleModes[i]=3;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));
       }
         else if(random(0,100) > 100){ // enemy # 2
         circleModes[i]=4;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2-random(0,300));// -bSiz[i].y/2 to lift us out of the floor;
       }
         else if(random(0,100) > 100){ // enemy # 3 
         circleModes[i]=5;
         bPos[i] = new PVector(width+200, floor - bSiz[i].y/2);// -bSiz[i].y/2 to lift us out of the floor;
      }
        
      }
    }
    
        // drawing projectiles (enemy car gif)
        if (bPos[i] != null) {//if the bPos[i] vector exist, draw a circle there
          //update
          bPos[i].add(bVel[i]);
          //draw
          // circles 
          if (circleModes[i]==0) {
            
            if (frameCount % frameSkip == 0) {
              framesmovement++;
            }
            // check to see if framess equal to banana.length
            if (framesmovement >= Proj_.length) {
  
              //set frames back to 0frames = 0
              framesmovement = 0;
            }
            //draw the image 
            image(Proj_[framesmovement], bPos[i].x, bPos[i].y, bSiz[i].x, bSiz[i].y);
          }
  
          // enemy # 2
          if (circleModes[i]==4) {
            if (frameCount % frameSkip == 0) {
              framesmovement++;
            }
            // check to see if framess equal to banana.length
            if (framesmovement >= enemy_.length) {
  
              //set frames back to 0frames = 0
              framesmovement = 0;
            }
            //draw the image 
            image(enemy_[framesmovement], bPos[i].x, bPos[i].y, bSiz[i].x, bSiz[i].y);
          }
          // enemy # 3
          if (circleModes[i]==5) {
            if (frameCount % frameSkip == 0) {
              framesmovement++;
            }
            // check to see if framess equal to banana.length
            if (framesmovement >= enemy3_.length) {
  
              //set frames back to 0frames = 0
              framesmovement = 0;
            }
            //draw the image 
            image(enemy3_[framesmovement], bPos[i].x, bPos[i].y, bSiz[i].x, bSiz[i].y);
          }
          //
          // draws the coins 
          else if (circleModes[i]==1) {
            if (frameCount % frameSkip == 0) {
              framesmovement++;
            }
            // check to see if framess equal to banana.length
            if (framesmovement > COIN_.length-1) {
  
              //set frames back to 0frames = 0
              framesmovement = 0;
            }
            //draw the image 
            image(COIN_[framesmovement], bPos[i].x, bPos[i].y);
          }
  
          // draws the health packs but without the gifs
  
          else if (circleModes[i]==3) {
            image(healthpack, bPos[i].x, bPos[i].y, 100, 100);
            //rect(bPos[i].x, bPos[i].y, bSiz[i].x, bSiz[i].y);
          }
          // defense 
          else if (circleModes[i]==2) {
            fill(bCol[i]);
            if (frameCount % frameSkip == 0) {
              framesmovement++;
            }
            // check to see if framess equal to banana.length
            if (framesmovement >= Sheild_.length) {
  
              //set frames back to 0frames = 0
              framesmovement = 0;
            }
            //draw the image 
            image(Sheild_[framesmovement], bPos[i].x, bPos[i].y, bSiz[i].x, bSiz[i].y);
          }
          // checks the collision detection 
          // if touching the rectangles or sheilds initalize sheild 
          if (pos.dist(bPos[i])<(siz.x+bSiz[i].x)/2.) {
            //(dist(bPos,bSiz,Tpos.x,Tpos.y)<bSiz[i] .y/2);
            if (circleModes[i] == 2) {
              shieldTimer+=200; 
              sheildon = true;
              bPos[i]= null;
              continue;
            }
            // if the player hits the coins than the score is increased by one 
            if (circleModes[i]==1) {
              score = score + 1;
              Coins = new SoundFile(this, "Coin_Sound.mp3");
              Coins.play();
              bPos[i]= null;
              continue;
            }
            // if touching the health pack increase the health
            if (circleModes[i] == 3) {
              playerhealth = playerhealth + 2;
            }
            if (shieldTimer < 1 && circleModes[i] == 4) {
              playerhealth = playerhealth - 5;
             
            }
  
            if (shieldTimer < 1 && circleModes[i] == 5) {
              playerhealth = playerhealth - 8;
             
            }
            // if circlemode 1 is not activited take away one health and if health reaches 0 then state = 25
            else if (shieldTimer < 1) {
              pCol = hitCol;
              playerhealth = playerhealth - 1;
           
            }
          }
            
         if (playerhealth <= 1) {
            lives = lives - 1;
            playerhealth = 500;
          }
            
          if(lives <=1){
           state = 25;
         }
             
          if (bPos[i].x < -bSiz[i].x/2) {//-bSiz[i]/2 ensures the circle is off the screen
            bPos[i] = null;
          }
        }//end if pos not null
      }//end for
  
      // ___________________________________________________________________________________________________________________________________________
      //update player
      pos.add(vel);
  
      //check player for movement commands i.e if up arrow key is pressed than make the player jump
      if (keyPressed && keyCode== UP && canJump==true) {
        currentFrame=0;
        vel.set(vel.x, jumpSpeed);
        frameMode=1; //1 for jumping 
        canJump=false;
      } else if (pos.y > floor-siz.y/2) {
  
        canJump=true; //reset the jump conditition 
        frameMode=0; //reset player animation to running
        pos.y=floor-siz.y/2; //reset the player height
        vel.y=0;
      } else if (canJump==false) {
        vel.add(acc);
      }
  
      // making bullets and hit detecting them
     if(leveltwo == true){ 
        mouse.set(mouseX, mouseY);
        //tDir = PVector.sub(mouse, tPos);
        tDir = PVector.sub(mouse, pos);
        tDir.limit(40);
        //rect(
        for (int i = 0; i <TbPos.length; i++) {
          if (TbPos[i] == null) {
            continue;
          }
          TbPos[i].add(TbVel[i]); 
          //make sure the ball does not leave the screen
          if (TbPos[i].y > height || TbPos[i].y < 0) {
            TbVel[i].y*=-1;
            //vel.rotate(PI); //rotate uses radian measures
          } else {
            TbVel[i].add(Tacc); //update each velocity with gravity
          }
          ellipse(TbPos[i].x, TbPos[i].y, 30, 30);
          for (int j=0; j<bPos.length; j++) {
            if (bPos[j]==null) {
              continue;
            }
            if (detectHit(TbPos[i], 30, bPos[j], 100) && circleModes[j]==0) {
              location = new PVector(bPos[j].x, bPos[j].y);
              addExplosion(location, new PVector(100, 100), 5);//this is only for this example
              if (TbPos[i] == null) {
                continue;
              }
              bPos[j] = null;
              continue;
              // checks hit dtection between the player bullets and circle mode 4 enemy 
            } else if ((detectHit(TbPos[i], 30, bPos[j], 100) && circleModes[j]==4)) {
              location = new PVector(bPos[j].x, bPos[j].y);
              addExplosion(location, new PVector(100, 100), 5);//this is only for this example
              bPos[j] = null;
              continue;
              //detects hit betwenne the player bullets and enemey projectiles
            } else if ((detectHit(TbPos[i], 30, bPos[j], 100) && circleModes[j]==5)) {
              //new pVector made to just pass into the parameters of the draw explosion function
              location = new PVector(bPos[j].x, bPos[j].y);
              addExplosion(location, new PVector(100, 100), 5);
              bPos[j] = null;
              continue;
            }
       }
         //pvector created to pass the boss's location and player bullets into the detect hit function
             bosslocation = new PVector(x, y);
           //  println ("bossloc"+TbPos[i]);//bosslocation);            
            if(detectHit(TbPos[i], 30, bosslocation, 300)){
             println("boss hit");
             bosshealth = bosshealth - 1;
             if(bosshealth<= 0){
               state = 5;
             } // end boss lvel
         } // detect hit player bullets and boss
     }//ends the bullet forlope 
  }//end the code which resiticts the bullets to be spawned at a ceritain location
      
      //drawing the player
      image(frames[frameMode][currentFrame], pos.x, pos.y, siz.x, siz.y);
      if (frameCount%frameSkip ==0) {
        currentFrame++;
      }
      if (currentFrame== frames[0].length) {
        currentFrame=0;
      }
      image(frames[frameMode][currentFrame], pos.x, pos.y, siz.x, siz.y);
  
      if (shieldTimer>0) {
        noStroke();
        fill(shieldCol);
        if (frameCount % frameSkip == 0) {
          framesmovement++;
        }
        // check to see if framess equal to banana.length
        if (framesmovement >= SheildOn_.length) {
  
          //set frames back to 0frames = 0
          framesmovement = 0;
        }
  
        //draw the image 
        image(SheildOn_[framesmovement], pos.x, pos.y, siz.x*1.2, siz.y*1.2);
        //ellipse(pos.x,pos.y,siz.x*1.2,siz.y*1.2);
        shieldTimer--;
      }//end the drawing gif of the sheild
      fill(shieldCol);
      rect(15, height/2, 30, shieldTimer, 16);
    
    //draws the boss
      if (score>= 45){
         bosslevel = true;
         drawboss();
      }//end if drawboss at this score
    }// ends play state 
    // restar/ end state
  //resets the game is the player health has gone down ) 
    if (state == 25) {
      reset();
    }//end this if to call restart state
  //takes the player to the win state if they succesfully beat the boss
    if(state == 5){
      winstate();
    }//end state 5
  }//end draw