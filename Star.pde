//Jeffrey Andersen

class Star {
  float r; //radius
  float initialRadius;
  PVector pos; //position
  Tail tail;
  boolean showStar;
  float endpointDistance; //the distance to the origin from where the star began its life (if outward-bound) and/or where it will end (if inward-bound)

  Star() {
    r = random(minRadius, maxRadius);
    initialRadius = r;
    pos = new PVector(0, 0, random(averageSpeed - speedSpan / 2, averageSpeed + speedSpan / 2));
    while (pos.z == 1) {
      pos.z = random(averageSpeed - speedSpan / 2, averageSpeed + speedSpan / 2);
    }
    int tailLength = averageTailLength + int(random(-averageTailLengthVariance, averageTailLengthVariance));
    PVector initialPosition;
    if (pos.z < 1) {
      initialPosition = PVector.random2D().mult(sqrt(sq(width + r) + sq(height + r))); //star's heading is random
      endpointDistance = -random(min(-width, -height), 0);
    } else { //pos.z > 1
      initialPosition = PVector.random2D().mult(-random(min(-width, -height), 0)); //star's heading is random
      endpointDistance = initialPosition.mag();
    }
    pos.x = initialPosition.x;
    pos.y = initialPosition.y;
    tail = new Tail(tailLength, pos.z, r);
    showStar = true;
  }


  private void decay() {
    showStar = false;
    tail.decay(pos, r); //tails get updated even if not areTails in case tails are turned back on
    if (tail.tailEndIndex > tail.lastIndexToDraw) {
      this.reset();
    } else {
      pos.x *= pos.z;
      pos.y *= pos.z;
      r = initialRadius * sq(pos.dist(new PVector(0, 0, pos.z)));
    }
  }

  private void reset() {
    r = random(minRadius, maxRadius);
    initialRadius = r;
    pos.z = random(averageSpeed - speedSpan / 2, averageSpeed + speedSpan / 2);
    while (pos.z == 1) {
      pos.z = random(averageSpeed - speedSpan / 2, averageSpeed + speedSpan / 2);
    }
    int tailLength = averageTailLength + int(random(-averageTailLengthVariance, averageTailLengthVariance));
    PVector initialPosition;
    if (pos.z < 1) {
      initialPosition = PVector.random2D().mult(sqrt(sq(width + r) + sq(height + r))); //star's heading is random
      endpointDistance = -random(min(-width, -height), 0);
    } else { //pos.z > 1
      initialPosition = PVector.random2D().mult(-random(min(-width, -height), 0)); //star's heading is random
      endpointDistance = initialPosition.mag();
    }
    pos.x = initialPosition.x;
    pos.y = initialPosition.y;
    tail = new Tail(tailLength, pos.z, r);
    showStar = true;
  }

  private void updateHelper() {
    tail.update(pos, r); //tails get updated even if not areTails in case tails are turned back on
    pos.x *= pos.z;
    pos.y *= pos.z;
    r = initialRadius * sq(pos.dist(new PVector(0, 0, pos.z)));
  }

  void update() {
    if (pos.z < 1) { //star is moving inward
      if (tail.tailEndIndex < tail.tailSegmentsCoordinates.length) {
        if (pos.mag() < endpointDistance) { //if star has reached its end point
          this.decay();
        } else {
          this.updateHelper();
        }
      } else {
        if (pos.mag() < endpointDistance) { //if star has reached its end point
          this.decay();
        } else {
          this.updateHelper();
        }
      }
    } else { //if star is moving outward; pos.z > 1
      showStar = true;
      if (tail.tailEndIndex < tail.tailSegmentsCoordinates.length) {
        if (tail.tailSegmentsCoordinates[tail.tailEndIndex].x < -width / 2 || tail.tailSegmentsCoordinates[tail.tailEndIndex].x > width / 2 || tail.tailSegmentsCoordinates[tail.tailEndIndex].y < -height / 2 || tail.tailSegmentsCoordinates[tail.tailEndIndex].y > height / 2) {
          this.reset();
        } else {
          this.updateHelper();
        }
      } else {
        if (pos.x < -width / 2 - r || pos.x > width / 2 + r || pos.y < -height / 2 - r || pos.y > height / 2 + r) {
          this.reset();
        } else {
          this.updateHelper();
        }
      }
    }
  }


  void show() {
    if (areTails) {
      tail.show();
    }
    if (showStar) {
      fill(255); //future consideration: allow for customizing star color
      noStroke();
      circle(pos.x, pos.y, r * 2); //drawn on top of (after) the tail
    }
  }
}
