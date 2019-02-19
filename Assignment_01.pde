/*
Here is my first edit to the robot assignment.
*/

import javax.swing.JOptionPane;                     // for use of JOptionPane objects

float x = 640;                                      //  x position of the robot
float y = 170;                                      //  y position of the robot
float counter = 0;                                  //  used to time certain events
//int rClickCount = 10;                              
int dAntenna = 12;                                  //  controls diameter of antenna wave effect
int tAntenna = 200;                                 //  controls transparency of antenna wave effect

void setup() {
  size(640, 360);
  frameRate(15);                                    //  slowed the frame rate to better visualize certain effects
}

void draw() {
  background(50);
  backgroundNum();                                  //  matrix effect
  robot();                                          //  robot body parts
  eyeLights();                                      //  robots coloured eye effect
  greeting();                                       //  initial text that appears in the speech bubble
  roboWave();                                       //  antenna effect
  clicking();                                       //  most of the clicking behaviour is defined by this method
  counter += .1;                                    //  incrementing the counter to control the timing of ceratin effects
  println(x + ", " + y + ",   " + counter + "    " +  "   " + mouseX + ", " + mouseY); //  used for my own reference in the console
}                                                   //  end of draw() method

void robot() {                                      //  parent method containing the primary robot methods
  fill(150);
  stroke(0);
  strokeWeight(4);

  //----------------------------------------------------robot methods-----------------------------------------------//
  roboLegs();                                       //  robot leg elements and behaviour
  roboNeck();                                       //  robot neck elements and behaviour
  roboArms("l");                                    //  robot left (user-perspective) arm elements and behaviour
  roboBod();                                        //  robot body elements and behaviour
  roboHead();                                       //  robot head elements and behaviour
  roboArms("r");                                    //  robot right (user-perspective) arm elements and behaviour
  roboMove();                                       //  move the robot!
}                                                   //  end of robot() method

void backgroundNum() {                              //  background matrix-like effect
  for (float y = 0; y <= height; y += 10) {         //  iterates rows of ones and zeros
    for (float x = 0; x <= width; x += 10) {        //  iterates columns of ones and zeros
      fill(0, random(50, 255), 0);                  //  randomizing the green fill
      text(round(random(0, 1)), x, y);              //  randomizing the display of ones and zeros 
    }
  }
}                                                   //  end of backgroundNum() method

void roboHead() {
  if (x > width/2) {                                // robot head position while walking
    rect(x+48, y-115, 8, 30);                       //-----------------------//
    circle(x+52, y-115, 12);                        //  robot antenna parts  //
    rect(x+42, y-90, 20, 10);                       //-----------------------//
    fill(150);
    stroke(0);
    rect(x+17, y-80, width/9, width/9);             //  robot head rectangle
    fill(200);
    ellipse(x+53, y-25, 40, 15);                    //  robot mouth ellipse
  } else if ((x == width/2) && (counter < 40)) {    //  robot head position while at rest
    rect(x+49, y-115, 8, 30);                       //-----------------------//
    circle(x+53, y-115, 12);                        //  robot antenna parts  //
    rect(x+43, y-90, 20, 10);                       //-----------------------//
    fill(150);
    stroke(0);
    rect(x+18, y-80, width/9, width/9);             //  robot head rectangle
    mouthTalk();                                    //  robot mouth talking animation
  } else {                                          //  robot head position while at rest after convo() method ends
    rect(x+49, y-115, 8, 30);                       //-----------------------//
    circle(x+53, y-115, 12);                        //  robot antenna parts  //
    rect(x+43, y-90, 20, 10);                       //-----------------------//
    fill(150);
    stroke(0);    
    rect(x+18, y-80, width/9, width/9);             //  robot head rectangle
    fill(200);
    ellipse(x+53, y-25, 40, 15);                    //  robot mouth ellipse
  }
  fill(150);                                        //  reset gray value
}                                                   //  end of roboHead() method

void eyeLights() {                                  //  multi-coloured eye effect
  strokeWeight(2);
  if (x > width/2) {                                            //  while in motion
    for (float eyeY = y-70; eyeY < y-50; eyeY += 10) {          //  iterates two rows of squares
      for (float eyeX = x+25; eyeX < x+85; eyeX += 10) {        //  iterates six columns of squares
        fill(random(0, 255), random(0, 255), random(0, 255));   //  multi-coloured effect is generated through use of random() Processing method
        rect(eyeX, eyeY, 10, 10);                               //  individual square
      }
    }
  } else {                                                      //  while at rest
    for (float eyeY = y-70; eyeY < y-50; eyeY += 10) {          //  iterates two rows of squares
      for (float eyeX = x+24; eyeX < x+84; eyeX += 10) {        //  iterates six columns of squares
        fill(random(0, 255), random(0, 255), random(0, 255));   //  multi-coloured effect is generated through use of random() Processing method
        rect(eyeX, eyeY, 10, 10);                               //  individual square
      }
    }
  }
}                                                               //  end of eyeLights() method

void roboNeck() {                                               //  robot neck
  rect(x+35, y-20, width/18, width/18);
}                                                               //  end of roboNeck() method

void roboBod() {                                                //  robot body
  fill(150);
  rect(x, y, width/6, width/5.5);                               //  body rectangle
  strokeWeight(3);
  rect(x+15, y+39, 70, 60);                                     //  door rectangle

  for (float i = y+45; i < y+99; i += 18) {                     //  iterates vents on the door
    fill(100);
    strokeWeight(1);
    rect(x+20, i, 60, 13);
    strokeWeight(2);
    line(x+20, i, x+80, i);
  }
  strokeWeight(4);
  fill(0);
  textSize(22);
  text("jT5000", x+10, y+25);                                   //  jT5000 text on robot body
  fill(150);
  textSize(12);                                                 //  reset text size
}                                                               //  end of roboBod() method

void roboDoor() {                                               //  open door effect on body
  fill(0);
  rect(x+15, y+39, 70, 60);                                     //  black body cavity
  roboSoul();                                                   //  calling method to create roboSoul effect in body cavity  
  fill(150);
  strokeWeight(3);
  quad(x-30, y+10, x+17, y+39, x+17, y+97, x-30, y+70);         //  open door quadralateral

  for (float i = y+20; i < y+55; i += 17) {                     //  iterates 3 open door vents
    fill(125);
    noStroke();
    quad(x-25, i, x+12, i+23, x+12, i+35, x-25, i+13.5);        //  individual vent quadralateral
    strokeWeight(2);
  }
}                                                               //  end of roboDoor() method

void roboArms(String lOrR) {                                    //  method to define arm elements and behaviours. takes in parameter to differentiate arms

  //----------------------------------------------------------------left arm---------------------------------------------------//
  if (lOrR == "l") {                                            //  selecting the left (from user perspective) arm
    if (x % 2 == 0 && x > width/2) {                            //  condition for first position of moving arm effect
      circle(x, y+85, width/22);                                //  initial walking left hand position
      rect(x-7, y, width/28, height/5);                         //  initial walking left arm position
    } else if (x % 2 != 0 && x > width/2) {                     //  condition for second position of moving arm effect
      circle(x+4, y+85, width/22);                              //  second walking left hand position
      rect(x-5, y, width/28, height/5);                         //  second walking left arm position
    } else if (dist(mouseX, mouseY, x-50, y-30) <= width/44 && mousePressed) {  //  condition for third position - left arm bent down
      rect(x-60, y-5, 70, 20);                                  //  upper left arm extended
      rect(x-60, y-5, 20, 50);                                  //  lower left arm lowered
      noStroke();
      rect(x-57, y-2, 20, 15);                                  //  hiding lowered bent left elbow joint
      stroke(0);
      circle(x-50, y+45, width/22);                             //  left hand lowered
      tooSlow();                                                //  calling method to display text and mouth behaviour when hand is clicked
    } else {                                                    //  condition for fourth position - left arm bent up
      rect(x-60, y-5, 70, 20);                                  //  upper left arm extended
      rect(x-60, y-30, 20, 30);                                 //  lower left arm raised
      noStroke();
      rect(x-57, y-15, 15, 20);                                 //  hiding raised bent left elbow joint
      stroke(0);
      circle(x-50, y-30, width/22);                             //  left hand raised
    }
    fill(150);
    circle(x+5, y+5, width/22);                                 //  left shoulder
    
  //----------------------------------------------------------------right arm----------------------------------------------------//    
  } else if (lOrR == "r") {                                     //  selecting the right (from user perspective) arm
    if (x % 2 == 0 && x > width/2) {                            //  condition for first position of moving arm effect
      circle(x+103, y+85, width/22);                            //  initial walking right hand position
      rect(x+92, y, width/28, height/5);                        //  initial walking right arm position
    } else if (x % 2 != 0 && x >width/2) {                      //  condition for second position of moving arm effect
      circle(x+107, y+85, width/22);                            //  second walking right hand position
      rect(x+95, y, width/28, height/5);                        //  second walking right arm position
    } else if (dist(mouseX, mouseY, x+107, y+85) <= width/44 && mousePressed) {  //  condition for third position - right arm bent down
      quad(x+96, y, x+96+(width/28), y, x+115+(width/22), y+78, x+92+(width/22), y+78);  //  right arm shifted right
      circle(x+105+(width/22), y+80, width/22);                 //  right hand shifted right
      tooSlow();                                                //  calling method to display text and mouth behaviour when hand is clicked
    } else {                                                    //  condition for fourth position - right arm straight down
      circle(x+107, y+85, width/22);                            //  resting lowered right hand
      rect(x+96, y, width/28, height/5);                        //  resting lowered right arm
    }
    fill(150);
    circle(x+107, y+5, width/22);                               //  right shoulder
  }
}                                                               //  end of roboArms() method

void roboLegs() {                                               //  method to define leg elements and behaviours

  //----------------------------------------------------------------left leg--------------------------------------------//
  if (x % 2 == 0 && (x > width/2)) {                            //  condition for first position of moving leg effect
    triangle(x+31, y+130, x+13, y+150, x+48, y+150);            //  left foot
    rect(x+15, y+110, width/20, height/10);                     //  left leg rectangle
    strokeWeight(1);
    float i = y+106;                                            //  trying a while loop instead of a for loop
    while (i < y + 100 + height/8) {                            //  iterates lines on legs
      line(x+15, i, x+15+width/20, i);
      i += 10;
    } 
    strokeWeight(4);
  } else if (x % 2 != 0 && (x > width/2)) {                     //  condition for second position of moving leg effect
    triangle(x+31, y+125, x+13, y+145, x+48, y+145);            //  left foot
    rect(x+15, y+105, width/20, height/10);                     //  left leg rectangle
    strokeWeight(1);
    float i = y+101;                                            
    while (i < y + 100 + height/8) {                            //  iterates lines on legs
      line(x+15, i, x+15+width/20, i);
      i += 10;
    } 
    strokeWeight(4);
    
  //---------------------------------------------------------------condition for third position - when the left leg is clicked--------------------------------------------------//
  } else if (mouseX > (x+15) && mouseX < (x+15+width/20) && mouseY > (y+width/5.5) && mouseY < (y+120+height/10) && (round(counter) % 2 != 0) && (x <= width/2) && mousePressed) {
    triangle(x+31, y+125, x+13, y+145, x+48, y+145);            //  left foot
    rect(random(x+13, x+17), y+105, width/20, height/10);       //  left leg rectangle with randomized x value to create jittering effect
    strokeWeight(1);
    float i = y+101;                                            
    while (i < y + 100 + height/8) {                            //  iterates lines on legs
      line(x+15, i, x+15+width/20, i);
      i += 10;
    } 
    strokeWeight(4);
  } else {                                                      //  condition for fourth position of moving leg effect - left leg at rest
    triangle(x+31, y+130, x+13, y+150, x+48, y+150);            //  left foot
    rect(x+15, y+110, width/20, height/10);                     //  left leg rectangle
    strokeWeight(1);
    float i = y+106;                                            
    while (i < y + 100 + height/8) {                            //  iterates lines on legs
      line(x+15, i, x+15+width/20, i);
      i += 10;
    } 
    strokeWeight(4);
  } 

  //--------------------------------------------------------------right leg---------------------------------------------------//
  if ((x % 2 != 0) && (x > width/2)) {                          //  condition for first position of moving leg effect
    triangle(x+77, y+130, x+58, y+150, x+94, y+150);            //  right foot
    rect(x+60, y+110, width/20, height/10);                     //  right leg rectangle
    strokeWeight(1);
    float i = y+106;                                            
    while (i < y + 100 + height/8) {                            //  iterates lines on legs
      line(x+60, i, x+60+width/20, i);
      i += 10;
    } 
    strokeWeight(4);
  } else if ((x % 2 == 0) && (x > width/2)) {                   //  condition for second position of moving leg effect
    triangle(x+77, y+125, x+58, y+145, x+94, y+145);            //  right foot
    rect(x+60, y+105, width/20, height/10);                     //  right lef rectangle
    strokeWeight(1);
    float i = y+101;                                            
    while (i < y + 100 + height/8) {                            //  iterates lines on legs
      line(x+60, i, x+60+width/20, i);
      i += 10;
    } 
    strokeWeight(4);
    
  //---------------------------------------------------------------condition for third position - when the right leg is clicked-------------------------------------------------//    
  } else if (mouseX > (x+60) && mouseX < (x+60+width/20) && mouseY > (y+width/5.5) && mouseY < (y+120+height/10) && (round(counter) % 2 == 0) && (x <= width/2) && mousePressed) {
    triangle(x+77, y+125, x+58, y+145, x+94, y+145);            //  right foot
    rect(random(x+58, x+62), y+105, width/20, height/10);       //  right leg rectangle with randomized x value to create jittering effect
    strokeWeight(1);
    //tickling();
    float i = y+101;                                            
    while (i < y + 100 + height/8) {                            //  iterates lines on legs
      line(x+60, i, x+60+width/20, i);
      i += 10;
    } 
    strokeWeight(4);
  } else {                                                      //  condition for fourth position of moving legs effect - right leg at rest
    triangle(x+77, y+130, x+58, y+150, x+94, y+150);
    rect(x+60, y+110, width/20, height/10);
    strokeWeight(1);
    float i = y+106;                                            
    while (i < y + 100 + height/8) {                            //  iterates lines on legs
      line(x+60, i, x+60+width/20, i);
      i += 10;
    } 
    strokeWeight(4);
  }
}                                                               //  end of roboLegs() method

void roboMove() {                                               //  method to make the robot() move
  if (x > width/2) {                                            //  condition defining when robot should move. He will move as long as x value is greater than width/2    
    x -= 3;                                                     //  robot will move three pixels left every frame
  } else {                                                      //  if first condition is not met, i.e. x value is not greater than width/2
    x = width/2;                                                //  robot will come to a resting position where x value equals width/2
  }
}                                                               //  end of roboMove() method

void visorDown(float vis) {                                     //  method to close visor over robots eyes when clicked
  fill(150);
  strokeWeight(3);
  rect(x+vis, y-70, 59, 20);                                    //  visor rectangle
  strokeWeight(4);
  sleeping();                                                   //  calling method to create text bubble while visor is down
}                                                               //  end of visorDown() method

void roboSoul() {                                               //  method to create roboSoul effect
  fill(255, 10, 10);
  circle(x+50, y+69, random(5, 10));                            //---------------------//
  fill(random(100, 200), random(150, 200), 0, random(0, 255));  //   roboSoul effect   //
  circle(x+50, y+69, random(5, 50));                            //---------------------//  
}

void roboWave() {                                               //  method to create wave effect when antenna is clicked
  if (dist(mouseX, mouseY, x+52, y-115) <= 8 && counter > 40 && mousePressed && mouseButton==LEFT) {  //  condition defining clicking behaviour to create wave effect
    fill(random(150, 255));                                     //  lighting effect for antenna
    stroke(random(0, 255));                                     //  lighting effect for antenna
    rect(x+48, y-115, 8, 30);                                   //  antenna part
    rect(x+42, y-90, 20, 10);                                   //  antenna part
    circle(x+52, y-115, 12);                                    //  antenna part
    fill(255, 0, 0, tAntenna);                                  //  red colour of wave, with alpha defined by the variable tAntenna
    stroke(0, tAntenna);                                        //  stroke of wave, with alpha defined by the variable  tAntenna
    circle(x+52, y-115, dAntenna);                              //  the red wave radiating from top of antenna
    dAntenna += 20;                                             //  rate of growth of wave diameter via the variable dAntenna
    tAntenna -= 4;                                              //  rate of decrease of wave opacity via the variable tAntenna

    if (dAntenna >= width+200) {                                //  condition to reset initial values of dAntenna and tAntenna variables
      dAntenna = 12;                                            //  reset to initally initialized value
      tAntenna = 200;                                           //  reset to initally initialized value
    }
  }
}                                                               //  end of roboWave() method

void mouseReleased() {                                          //  method to reset values for roboWave() method if mouse is released
  dAntenna = 12;                                                //  reset to initally initialized value
  tAntenna = 200;                                               //  reset to initally initialized value
}                                                               //  end of mouseReleased() method

void textBubble() {                                             //  elements of the text bubble behind instances of text in the sketch
  fill(255);
  strokeWeight(4);
  triangle(150, 50, 150, 100, 300, 100);
  ellipse(125, 75, 200, 100);
  noStroke();
  triangle(150, 52, 150, 98, 298, 100);
}                                                               //  end of textBubble() method

void mouthTalk() {                                              //  method to animate robot mouth when speaking
  fill(random(100, 200));                                       //  talking animation via random grayscale fill
  ellipse(x+53, y-25, 40, 15);                                  //  mouth ellipse
}                                                               //  end of mouthTalk() method

void tooSlow() {                                                //  method to display text when robot hands are clicked
  textBubble();                                                 //  calling method for text bubble
  fill(0);                                            
  stroke(0);                                           
  textAlign(CENTER);                                    
  text("Too slow!", width/5, height/6.8+25);             
  textAlign(LEFT);                                              //  reset text alignment
  fill(150);                                                    //  reset gray fill value
  mouthTalk();                                                  //  calling method to animate mouth speaking
}                                                               //  end of tooSlow() method

void tickleFeet() {                                             //  method to display text when robot legs or feet are clicked
  textBubble();                                                 //  calling method for text bubble
  fill(0);                                            
  stroke(0);                                           
  textAlign(CENTER);                                    
  text("WHY WAS I PROGRAMMED\nWITH A tickleFeet() METHOD!!?", width/5, height/6.8+15);             
  textAlign(LEFT);                                              //  reset text alignment
  mouthTalk();                                                  //  calling method to animate mouth speaking 
  fill(150);                                                    //  reset gray fill value
}                                                               //  end of tickleFeet() method

void sleeping() {                                               //  method to display text when robot eyes are clicked
  if (counter > 40) {                                           //  condition for when method can be called
    textBubble();                                               //  calling method for text bubble
    fill(0);
    stroke(0);
    textAlign(CENTER);
    text("zzzzzzzzzzzzzzzzzzzzzzzz", width/5, height/6.8+25);
    textAlign(LEFT);                                            //  reset text alignment
    fill(150);                                                  //  reset gray fill value
  }
}                                                               //  end of sleeping() method

void greeting() {                                               //  method to create initial speech of robot
  if ((x == width/2) && (counter < 40)) {                       //  condition for timing of speech
    textBubble();                                               //  calling text bubble method
    fill(0);
    stroke(0);
    textAlign(CENTER);

    if (counter < 20) {                                         //  if/else if statements delimited by the counter variable
      text(
        "Greetings, puny human.\nI am javaTron 5000. A superior\nintelligence with no biological\nrival..."
        , width/5, height/6.8);
    } else if (counter < 25) {
      text("Do you dare test my power?", width/5, height/6.8 + 25);
    } else if (counter < 30) {
      text("Behold!\nMy near-limitless functionality!", width/5, height/6.8 + 10);
    } else if (counter < 35) {
      text("...", width/5, height/6.8 + 25);
    } else {
      text("... just click on some stuff.", width/5, height/6.8 + 25);
    }
  }
  textAlign(LEFT);
}                                                               //  end of greeting() method

void clicking() {                                               //  method to define most of the clicking behaviour, including all JOptionPane instances                 
  stroke(0);
  strokeWeight(4);

  if (mousePressed)                                             //  condition of mouse being pressed
  {
    if ((mouseX >= x+25) && (mouseX <= x+85) && (mouseY >= y-70) && (mouseY <= y-50))  //  mousePressed closes visor
    {
      visorDown(25);
      if (x <= width/2) 
      {
        visorDown(24);                                          //  adjustment to account for pixel shift when robot stops
        mouthTalk();
      }
    } 
    else if ((mouseX >= x+15) && (mouseX <= x+85) && (mouseY >= y+39) && (mouseY <= y+99)) { //  mousePressed opens door
      roboDoor();
    } 
    else if ((dist(mouseX, mouseY, x-50, y-30) <= width/44) && x <= width/2) {  // cover first "Bleep. Bloop." gap created by mousePressed in roboArms("l") method
      //do nothing                                              
      mouthTalk();
    } 
    else if (dist(mouseX, mouseY, x+107, y+85) <= width/44 && x <= width/2) {  //  cover second "Bleep. Bloop." gap created by mousePressed in roboArms("r") method
      //do nothing                   
    } 
    else if (dist(mouseX, mouseY, x+52, y-115) <= 8 && counter > 40) {  //  cover "Bleep. Bloop." gap created by mousePressed in roboAntenna() method
      //do nothing                   
    } 
    else if (mouseX > (x+15) && mouseX < (x+15+width/20) && mouseY > (y+width/5.5) && mouseY < (y+120+height/10) && x <= width/2) {  //  cover "Bleep. Bloop." gap created by left leg roboLegs() method
      //do nothing                   
      if (counter > 40) {
        tickleFeet();
      }
    } 
    else if (mouseX > (x+60) && mouseX < (x+60+width/20) && mouseY > (y+width/5.5) && mouseY < (y+120+height/10) && x <= width/2) {  //  cover "Bleep. Bloop." gap created by right leg roboLegs() method
      //do nothing                   
      if (counter > 40) {
        tickleFeet();
      }
    } 
  //----------------------------------------------deicision tree of JOptionPane dialog boxes when robot mouth is clicked---------------------------------------//
    else if ((mouseX > x+33) && (mouseX < x+73) && (mouseY > y-32.5) && (mouseY < y-17.5)) {  //  condition for click location. Beginning of conversation
      int ans1 = (JOptionPane.showConfirmDialog(null, 
        "Oh, you want to have a conversation?", 
        "Puny human attempts communication", 
        JOptionPane.YES_NO_OPTION));
        
      if (ans1 == 1) {                                                    //  answered no to above question
        JOptionPane.showMessageDialog(null, 
          "Typical. Fear is a common trait of humans.", 
          "Human behaves as expected", 
          JOptionPane.DEFAULT_OPTION);
      }      
      else {
        String inputName1 = JOptionPane.showInputDialog(null,             //  answered yes to above question
          "Very well.\n\n" + "Tell me your name:", 
          "Puny Human");

        if (inputName1.compareTo("javaTron 5000") == 0) {                 //  user inputs javaTron 5000 as their name
          JOptionPane.showMessageDialog(null, 
            "Your aspirations to greatness are admirable, but I\'m afraid your biological limitations are permanent.", 
            "This isn\'t a mirror", 
            JOptionPane.DEFAULT_OPTION);
        }    
        else if (inputName1.compareTo(" ") == 0 || inputName1.compareTo("  ") == 0 || inputName1.compareTo("   ") == 0) {  //  condition for user entering spaces as input (up to three)                                                                                                                          
          JOptionPane.showMessageDialog(null,   //  I tried to iterate this w/ an array to include more blank space possibilities, but I couldn't figure it out within the if/else if structure
            "If your name has no characters, I can\'t help you.", 
            "Very funny...",           
            JOptionPane.DEFAULT_OPTION);
        }    
        else if (inputName1.length() > 3) {                               //  asks uer to pick a number if their name is longer than three characters
          int ans2 = Integer.parseInt(JOptionPane.showInputDialog(null, 
            "Ha. Ha. Ha. What an inefficient and illogical name. Let me shorten it for you.\n\n Pick a number between 1 and " 
            + (round(inputName1.length()*.75)) + ":", "2"));  //*9 to make sure there are enough characters after the character
          
          char ans3 = 'A';
                                                            
                                                                          //  at the index selected by the user and saved in ans2
          if (ans2 > 0 && ans2 <= (round(inputName1.length())*.75)) {  //validation for ans2 input                                                   
                                                            
            ans3 = inputName1.charAt(ans2-1);                             // subtract one to adjust for 0 index in inputName1
          }
          else {
            ans3 = inputName1.charAt(0);                                  // set ans3 to the first letter of inputName1 if user input falls outside acceptable range
          }
          int ans4 = Integer.parseInt(JOptionPane.showInputDialog(null, 
            "I will start from \'" + ans3 + ".\'\n\nNow pick a number between 1 and "
            + (inputName1.length() - ans2) + ":", "2"));
          
          String inputName2;           
            
  //--------------there is a bug here throwing an error when certain numbers are input. didn't have time to figure it out------------------------//
            if (ans4 > 0 && ans4 < (inputName1.length() - ans2)) {        
              inputName2 = inputName1.substring(ans2 - 1, (ans2+ans4));
            }
            else {
              inputName2 = "Puny Human";
            }

          int ans5 = JOptionPane.showConfirmDialog(null,                  //  tells user their new name
            "Your new name is: " + inputName2 + ". " +
            "\n\nDo you accept this new name?", 
            "New name", 
            JOptionPane.YES_NO_OPTION);
            
            if (ans5 == 0) {                                              //  this if/else statement isn't really necessary, but including                                                            
              JOptionPane.showMessageDialog(null,                         //  it makes me feel like the joke is more fully realized... :)
              "javaTron 5000 name changes are permanent.", 
              "Human opinion irrelevant", 
              JOptionPane.DEFAULT_OPTION);
            }
            else {                                          
              JOptionPane.showMessageDialog(null, 
              "javaTron 5000 name changes are permanent.", 
              "Human opinion irrelevant", 
              JOptionPane.DEFAULT_OPTION);              
            }
        }    
        else {                                                            //  if the user inputs a name of three characters or less, the robot likes it
          JOptionPane.showMessageDialog(null, 
            "Efficient and simple. This is acceptable. Please return to your mundane human pursuits.", 
            "Acceptable name", 
            JOptionPane.DEFAULT_OPTION);
        }
      }
    } 
    else {                                                                               //  "Bleep. Bloop." clicking behaviour

      if (mouseX < 55 && mouseY < 30) {                                                  //  top left corner limit
        fill(255);
        ellipse(mouseX + (55 - mouseX), (mouseY - 15) + (15 - (mouseY - 15)), 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", (mouseX + (55 - mouseX)), (mouseY + (30 - mouseY) - 10));
        textAlign(LEFT);
      } 
      else if (mouseX > (width- 55) && mouseY < 30) {                                    //  top right corner limit
        fill(255);
        ellipse(mouseX + ((width - 55) - mouseX), (mouseY - 15) + (15 - (mouseY - 15)), 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", (mouseX + ((width - 55) - mouseX)), (mouseY + (30 - mouseY) - 10));
        textAlign(LEFT);
      } 
      else if (mouseX < 55 && mouseY > height) {                                         //  bottom left corner limit
        fill(255);
        ellipse(mouseX + (55 - mouseX), height - 15, 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", (mouseX + (55 - mouseX)), height - 10);
        textAlign(LEFT);
      } 
      else if (mouseX > (width- 55) && mouseY > height) {                                //  bottom right corner limit
        fill(255);
        ellipse(mouseX + ((width - 55) - mouseX), height - 15, 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", (mouseX + ((width - 55) - mouseX)), height - 10);
        textAlign(LEFT);
      } 
      else if (mouseX < 55) {                                                            //  left edge limit
        fill(255);
        ellipse(mouseX + (55 - mouseX), mouseY-15, 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", (mouseX + (55 - mouseX)), mouseY-10);
        textAlign(LEFT);
      } 
      else if (mouseX > (width - 55)) {                                                  //  right edge limit
        fill(255);
        ellipse(mouseX + ((width - 55) - mouseX), mouseY-15, 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", (mouseX + ((width - 55) - mouseX)), mouseY - 10);
        textAlign(LEFT);
      } 
      else if (mouseY < 30) {                                                            //  top edge limit
        fill(255);
        ellipse(mouseX, (mouseY - 15) + (15 - (mouseY - 15)), 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", mouseX, (mouseY + (30 - mouseY) - 10));
        textAlign(LEFT);
      } 
      else if (mouseY > height) {                                                        //  bottom edge limit
        fill(255);
        ellipse(mouseX, height - 15, 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", mouseX, height - 10);
        textAlign(LEFT);
      } 
      else {                                                                             //  no limit
        fill(255);
        ellipse(mouseX, mouseY-15, 110, 30);
        fill(0);
        textAlign(CENTER);
        text("Bleep. Bloop.", mouseX, mouseY-10);
        textAlign(LEFT);
      }
    }
  } 
  /*else if (mouseButton == RIGHT) {                                                    //  abandoned this as I didn't have time to finish. was trying to create a 
    textSize(500);                                                                      //  countdown to some event every time the right mouse button was clicked.
    text("BAAAAAHHH", 20, 20); 
    textSize(12);
  }*/  
}                                                                                       //  end of clicking() method
