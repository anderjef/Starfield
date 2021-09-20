//Jeffrey Andersen

class Tail {
  PVector[] tailSegmentsCoordinates; //tail segment coordinates closest to the star's position are found at the end (largest indicies) of the array
  float z; //depth
  float starRadius;
  int tailEndIndex; //index of last initialized tail segment coordinates in tailSegmentsCoordinates (because stars generate their tail after spawning) or tailSegmentsCoordinates.length if tail is currently empty
  int lastIndexToDraw;

  Tail(int tailLength, float starZ, float starR) {
    tailSegmentsCoordinates = new PVector[tailLength];
    for (PVector tailSegmentCoordinates : tailSegmentsCoordinates) {
      tailSegmentCoordinates = new PVector();
    }
    tailEndIndex = tailSegmentsCoordinates.length;
    z = starZ;
    starRadius = starR;
    lastIndexToDraw = tailSegmentsCoordinates.length - 1;
  }

  void decay(PVector starPosition, float _starRadius) {
    lastIndexToDraw--;
    if (tailEndIndex > 0) {
      tailEndIndex--;
    }
    for (int i = tailEndIndex; i < tailSegmentsCoordinates.length - 1; i++) {
      tailSegmentsCoordinates[i] = tailSegmentsCoordinates[i + 1];
    }
    tailSegmentsCoordinates[tailSegmentsCoordinates.length - 1] = starPosition.copy();
    starRadius = _starRadius;
  }

  void update(PVector starPosition, float _starRadius) {
    lastIndexToDraw = tailSegmentsCoordinates.length - 1; //reset
    if (tailEndIndex > 0) {
      tailEndIndex--;
    }
    for (int i = tailEndIndex; i < tailSegmentsCoordinates.length - 1; i++) {
      tailSegmentsCoordinates[i] = tailSegmentsCoordinates[i + 1];
    }
    tailSegmentsCoordinates[tailSegmentsCoordinates.length - 1] = starPosition.copy();
    starRadius = _starRadius;
  }

  void show() {
    if (tailEndIndex < tailSegmentsCoordinates.length) {
      noStroke();
      fill(255); //future consideration: allow for customizing tail color
      float deltaX = (tailSegmentsCoordinates[tailEndIndex].y == 0 ? 0 : starRadius * cos(-tailSegmentsCoordinates[tailEndIndex].x / tailSegmentsCoordinates[tailEndIndex].y)); //uses the slope of the line perpendicular to the line going from the star's position to the origin (which crosses through every point along the star's tail)
      float deltaY = (tailSegmentsCoordinates[tailEndIndex].x == 0 ? 0 : starRadius * cos(tailSegmentsCoordinates[tailEndIndex].y / tailSegmentsCoordinates[tailEndIndex].x)); //uses the slope of the line going from the star's position to the origin (which crosses through every point along the star's tail)
      triangle(tailSegmentsCoordinates[lastIndexToDraw].x * z + deltaX, tailSegmentsCoordinates[lastIndexToDraw].y * z + deltaY, tailSegmentsCoordinates[lastIndexToDraw].x * z - deltaX, tailSegmentsCoordinates[lastIndexToDraw].y * z - deltaY, tailSegmentsCoordinates[tailEndIndex].x, tailSegmentsCoordinates[tailEndIndex].y); //triangle alignment with the star (circle) isn't perfect, but is close enough (and perfect alignment may not be desirable anyways so as to highlight the distinguishment between the star and its tail)
    }
  }
}
