final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

boolean downPressed=false,leftPressed=false,rightPressed=false;
boolean downMove=false,rightMove=false,leftMove=false,move=false;

int groundhogX,groundhogY;
int groundhogDownX=1000,groundhogDownY=-1000;
int groundhogLeftX=1000,groundhogLeftY=-1000;
int groundhogRightX=1000,groundhogRightY=-1000;
int distance;
int a=0;
int soilMove=0;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg,soil0 ,soil1,soil2,soil3,soil4,soil5;
PImage life;
PImage stone1,stone2;
PImage groundhog,groundhogDown,groundhogRight,groundhogLeft;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");

  groundhog = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  life = loadImage("img/life.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  groundhogX=320;groundhogY=80;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT-soilMove);

		// Soil
    for(int i=0;i<8;i++){
      for(int r=0;r<4;r++){
        image(soil0,i*80,160+r*80-soilMove);
      }
    }
    for(int i=0;i<8;i++){
      for(int r=0;r<4;r++){
        image(soil1,i*80,480+r*80-soilMove);
      }
    }
    for(int i=0,r=0;i<8;i++,r++){
        image(stone1,i*80,160+r*80-soilMove);
    }
    for(int i=0;i<8;i++){
      for(int r=0;r<4;r++){
        image(soil2,i*80,800+r*80-soilMove);
      }
    }
   
    for(int i=0;i<8;i++){
      for(int r=0;r<4;r++){
        image(soil3,i*80,1120+r*80-soilMove);
      }
    }
    for(int r=0;r<8;r++){
      for(int i=0;i<8;i++){
        if(i==1||i==2||i==5||i==6){
          if(r==0||r==3||r==4||r==7){
            image(stone1,i*80,800+r*80-soilMove);
          }
        }
      }
    }
    for(int r=0;r<8;r++){
      for(int i=0;i<8;i++){
        if(i==0||i==3||i==4||i==7){
          if(r==1||r==2||r==5||r==6){
            image(stone1,i*80,800+r*80-soilMove);
          }
        }
      }
    }
    for(int i=0;i<8;i++){
      for(int r=0;r<4;r++){
        image(soil4,i*80,1440+r*80-soilMove);
      }
    }
    for(int i=0;i<8;i++){
      for(int r=0;r<4;r++){
        image(soil5,i*80,1760+r*80-soilMove);
      }
    }
    for(int s=0;s<14;s++){
      for(int i=0,r=7;i<8;i++,r--){
        if(s==13||s==12||s==10||s==9||s==7||s==6||s==4||s==3||s==1||s==0){
          image(stone1,-80*s+560+i*80,1440+r*80-soilMove);
        }
      }
    }
    for(int s=0;s<14;s++){
      for(int i=0,r=7;i<8;i++,r--){
        if(s==12||s==9||s==6||s==3||s==0){
          image(stone2,-80*s+560+i*80,1440+r*80-soilMove);
        }
      }
    }
    
		// Player
    image(groundhog,groundhogX,groundhogY);
      image(groundhogDown,groundhogDownX,groundhogDownY);
      image(groundhogLeft,groundhogLeftX,groundhogLeftY);
      image(groundhogRight,groundhogRightX,groundhogRightY);
     if(a<20){
      
      if(move){
        if(downPressed){        
         distance+=5;
         soilMove+=5;
          println(a);
         if(distance==80){
            move = false;
            groundhogY = groundhogDownY;
            groundhogX = groundhogDownX;
            groundhogDownX = 1000;
            distance = 0;
            a++;
            downPressed = false;
         
        }        
         }
      if(leftPressed){
          groundhogLeftX-=5;
          groundhogLeftX=max(groundhogLeftX,0);
          distance+=5;
          if(distance==80){
            move = false;
            groundhogY = groundhogLeftY;
            groundhogX = groundhogLeftX;
            groundhogLeftX = 1000;
            distance = 0;
            leftPressed = false;
          }    
         }
       if(rightPressed){
            groundhogRightX+=5;
            groundhogRightX=min(groundhogRightX,560);
            distance+=5;
            if(distance==80){
              move = false;
              groundhogY = groundhogRightY;
              groundhogX = groundhogRightX;
              groundhogRightX = 1000;
              distance = 0;
              rightPressed=false;
            }
          }        
         }
     }else{
     
      if(move){
      if(downPressed){        
          groundhogDownY+=5;
          groundhogDownY=min(groundhogDownY,400);
          distance+=5;
          if(distance==80){
            move = false;
            groundhogY = groundhogDownY;
            groundhogX = groundhogDownX;
            groundhogDownX = 1000;
            distance = 0;
            downPressed = false;
          }        
         }
      if(leftPressed){
          groundhogLeftX-=5;
          groundhogLeftX=max(groundhogLeftX,0);
          distance+=5;
          if(distance==80){
            move = false;
            groundhogY = groundhogLeftY;
            groundhogX = groundhogLeftX;
            groundhogLeftX = 1000;
            distance = 0;
            leftPressed = false;
          }    
         }
       if(rightPressed){
            groundhogRightX+=5;
            groundhogRightX=min(groundhogRightX,560);
            distance+=5;
            if(distance==80){
              move = false;
              groundhogY = groundhogRightY;
              groundhogX = groundhogRightX;
              groundhogRightX = 1000;
              distance = 0;
              rightPressed=false;
            }
          }
        }
     }
		// Health UI
    for(int i=0;i<playerHealth;i++){
      image(life,10+i*70,10);
    }
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
    if(key==CODED){
    switch(keyCode){
      case DOWN:
        if(move==false){
          groundhogDownY = groundhogY;
          groundhogDownX = groundhogX;
          groundhogX=1000;
          downPressed=true;
          move = true;
          
                }
      break;
      case RIGHT:
        if(move==false){
          groundhogRightY = groundhogY;
          groundhogRightX = groundhogX;
          groundhogX=1000;
          rightPressed=true;
          move = true;
        }
      break;
      case LEFT:
        if(move==false){
          groundhogLeftY = groundhogY;
          groundhogLeftX = groundhogX;
          groundhogX=1000;
          leftPressed=true;
          move = true;
        }
      break;
    }
  }
}

void keyReleased(){
  
}
