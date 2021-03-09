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
    pos.z = random(1.003, 1.03);
    r = random(8, 10);
    tail = new Tail(areTails, tailLength, pos.z, r);
  }
  
  void update() {
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
      pos.z = random(1.003, 1.03); //<>//
      r = random(8, 10);
      tail = new Tail(areTails, tailLength, pos.z, r);
    }
    else {
      pos.x *= pos.z;
      pos.y *= pos.z;
      r *= (pos.z * pos.z - 1) * 0.08 + 1;
    }
  }
  
  void show() {
    tail.show(); //<>//
    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, r, r);
  }
}
