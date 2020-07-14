class Star {
  float x; //using polar coordinates may have been better
  float y;
  float z;
  float r;
  int age = 2;
  Tail tail;
  
  Star(boolean areTails, int tailLength) {
    x = random(-width / age, width / age);
    y = random(-height / age, height / age);
    while (x == 0) {
      x = random(-width / age, width / age);
    }
    while (y == 0) {
      y = random(-height / age, height / age);
    }
    z = random(1.003, 1.03);
    r = random(8, 10);
    tail = new Tail(areTails, tailLength, z, r);
  }
  
  void update() {
    tail.update(x, y, r);
    if (x <= -width || x >= width || y <= -height || y >= height) {
      if (age < 8) {
        age++;
      }
      x = random(-width / age, width / age);
      y = random(-height / age, height / age);
      while (x == 0) {
        x = random(-width / age, width / age);
      }
      while (y == 0) {
        y = random(-height / age, height / age);
      }
      z = random(1.003, 1.03); //<>//
      r = random(8, 10);
      tail = new Tail(areTails, tailLength, z, r);
    }
    else {
      x *= z;
      y *= z;
      r *= (z * z - 1) * 0.08 + 1;
    }
  }
  
  void show() {
    tail.show(); //<>//
    fill(255);
    noStroke();
    ellipse(x, y, r, r);
  }
}
