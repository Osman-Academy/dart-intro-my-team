import 'dart:math';

class Square {
  double side;

  Square(this.side);

  double get area => pow(side, 2).toDouble();

  void changeSide(double newSide) {
    print("Old side: $side → New side: $newSide");
    side = newSide;
    print("Updated area = ${area}");
  }
}

void main() {
  var sq = Square(4);
  print("Initial area = ${sq.area}");
  sq.changeSide(6);
  sq.changeSide(10);
}
