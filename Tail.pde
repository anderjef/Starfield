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
  
  void update(float starX, float starY, float starR) {
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
  
  void show() {
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
