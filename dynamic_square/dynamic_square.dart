import 'dart:math';

class DynamicSquare {
  double size;

  DynamicSquare(this.size);

  void shrink() {
    size = max(0, size - 10);
    print('🔹 Square shrunk to size: $size');
  }

  void expand() {
    size += 10;
    print('🔹 Square expanded to size: $size');
  }
}

void main() {
  var square = DynamicSquare(100);

  print('Initial size: ${square.size}');
  square.shrink();
  square.expand();
}
