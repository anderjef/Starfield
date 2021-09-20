//Jeffrey Andersen

//future consideration: draw stars according to how close their starting position is/was to the origin to improve realism
//future consideration: convert to 3D to improve realism

int averageTailLength = 60, averageTailLengthVariance = 0;
boolean areTails = true;
float minRadius = 32, maxRadius = 40; //minimum and maximum star radius at the star(s) spawn
float averageSpeed = 1.015, speedSpan = 0.03; //make averageSpeed more than speedSpan / 2 from 1 to ensure all stars move the same direction
int numStars = 100;
boolean generateStarTailsBeforeDisplay = false;

ArrayList<Star> stars = new ArrayList<Star>();

void setup() {
  size(1600, 1600, P2D); //specifying P2D was found to be faster than not
  minRadius /= sqrt(sq(width) * sq(height));
  maxRadius /= sqrt(sq(width) * sq(height));
  for (int i = 0; i < numStars; i++) {
    stars.add(new Star());
    if (generateStarTailsBeforeDisplay) {
      for (int j = 0; j < averageTailLength + averageTailLengthVariance; j++) { //simulate frames before the animation gets displayed to hide any small initialization bugs (as well as starting the animation with tails)
        stars.get(i).update();
      }
    }
  }
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  for (int i = stars.size() - 1; i < stars.size() - numStars; i--) { //if size has been reduced, remove some
    stars.remove(i);
  }
  for (int i = 0; i < numStars - stars.size(); i++) { //if size has been enlarged, add more
    stars.add(new Star());
    if (generateStarTailsBeforeDisplay) {
      for (int j = 0; j < averageTailLength + averageTailLengthVariance; j++) { //simulate frames before the star gets displayed to hide any small initialization bugs (as well as starting the animation with tails)
        stars.get(i).update();
      }
    }
  }
  for (Star s : stars) {
    s.update();
    s.show();
  }
}
