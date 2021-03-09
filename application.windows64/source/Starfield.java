import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Starfield extends PApplet {

//Jeffrey Andersen

Star[] stars = new Star[256];
int tailLength = 16;
boolean isTailLengthVariance = true;
boolean areTails = true;

public void setup() {
  
  for (int i = 0; i < stars.length; ++i) {
    if (isTailLengthVariance) {
      stars[i] = new Star(areTails, tailLength + PApplet.parseInt(random(-tailLength, tailLength)));
    }
    else {
      stars[i] = new Star(areTails, tailLength);
    }
  }
}

public void draw() {
  background(0);
  translate(width / 2, height / 2);
  for (Star s : stars) {
    s.update();
    s.show();
  }
}
//Jeffrey Andersen

class Star {
  PVector pos = new PVector(); //polar coordinates may have been better
  float r; //radius
  int age = 2;
  Tail tail;
  
  Star(boolean areTails, int tailLength) {
    pos.x = random(-width / age, width / age);
    pos.y = random(-height / age, height / age);
    while (pos.x == 0) {
      pos.x = random(-width / age, width / age);
    }
    while (pos.y == 0) {
      pos.y = random(-height / age, height / age);
    }
    pos.z = random(1.003f, 1.03f);
    r = random(8, 10);
    tail = new Tail(areTails, tailLength, pos.z, r);
  }
  
  public void update() {
    tail.update(pos.x, pos.y, r);
    if (pos.x <= -width || pos.x >= width || pos.y <= -height || pos.y >= height) {
      if (age < 8) {
        age++;
      }
      pos.x = random(-width / age, width / age);
      pos.y = random(-height / age, height / age);
      while (pos.x == 0) {
        pos.x = random(-width / age, width / age);
      }
      while (pos.y == 0) {
        pos.y = random(-height / age, height / age);
      }
      pos.z = random(1.003f, 1.03f);
      r = random(8, 10);
      tail = new Tail(areTails, tailLength, pos.z, r);
    }
    else {
      pos.x *= pos.z;
      pos.y *= pos.z;
      r *= (pos.z * pos.z - 1) * 0.08f + 1;
    }
  }
  
  public void show() {
    tail.show();
    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, r, r);
  }
}
//Jeffrey Andersen

class Tail {
  float[] Xs;
  float[] Ys;
  float z; //depth
  float r; //radius
  int index;
  boolean isTail;
  
  Tail(boolean areTails, int tailLength, float starZ, float starR) {
    isTail = areTails;
    Xs = new float[tailLength];
    Ys = new float[tailLength];
    z = starZ;
    r = starR;
    index = Xs.length - 1;
  }
  
  public void update(float starX, float starY, float starR) {
    if (isTail) {
      if (index > 0) {
        index--;
      }
      for (int i = 0; i < Xs.length - 1; ++i) {
        Xs[i] = Xs[i + 1];
      }
      for (int i = 0; i < Ys.length - 1; ++i) {
        Ys[i] = Ys[i + 1];
      }
      Xs[Xs.length - 1] = starX;
      Ys[Ys.length - 1] = starY;
    }
  }
  
  public void show() {
    if (isTail) {
      if (this.Xs.length > 1) {
        //stroke(lerpColor(223, 255, 0));
        //strokeWeight(r);
        //stroke(223);
        noStroke();
        fill(255);
        float slope = -1 / (Ys[Ys.length - 1] * z / (Xs[Xs.length - 1] * z)); //the negative reciprocal of the slope from the star to the end of it's tail (which is equal to the slope from the star to the origin); note that the only axis-intercept is at the origin
        float deltaX = sqrt(r * r / 4 / (1 + slope * slope)); //r / 2 is the Pythagorean distance (c in c^2 = a^2 + b^2) (the distance to two of the points of the tail triangle), where a and b are related by the slope (slope-intecept form b = slope * a + intercept where b is representing the y-value and a is representing the x-value and the intercept equals zero because the line will always go through the origin)
        float deltaY = slope * deltaX;
        if (Xs[index] != 0 || Ys[index] != 0) {
          //line(Xs[index], Ys[index], Xs[Xs.length - 1] * z, Ys[Ys.length - 1] * z);
          triangle(Xs[Xs.length - 1] * z + deltaX, Ys[Ys.length - 1] * z + deltaY, Xs[Xs.length - 1] * z - deltaX, Ys[Ys.length - 1] * z - deltaY, Xs[index], Ys[index]); //I don't know why sometimes the triangle is too thin for its star, but I suppose it's good enough
        }
        else {
          for (int i = 0; i < Xs.length; ++i) {
            if (Xs[i] != 0 || Ys[i] != 0) {
              //line(Xs[i], Ys[i], Xs[Xs.length - 1] * z, Ys[Ys.length - 1] * z);
              triangle(Xs[Xs.length - 1] * z + deltaX, Ys[Ys.length - 1] * z + deltaY, Xs[Xs.length - 1] * z - deltaX, Ys[Ys.length - 1] * z - deltaY, Xs[i], Ys[i]); //I don't know why sometimes the triangle is too thin for its star, but I suppose it's good enough
              break;
            }
          }
        }
      }
    }
  }
}
  public void settings() {  size(1600, 1600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Starfield" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
