import 'dart:io';

void main() {
  int size = 5; // starting size of the square

  while (true) {
    // clear console
    print("\x1B[2J\x1B[0;0H");
    drawSquare(size);

    print("\nPress '+' to make it bigger, '-' to make it smaller, or 'q' to quit:");
    String? input = stdin.readLineSync();

    if (input == '+') {
      size++;
    } else if (input == '-') {
      if (size > 1) size--;
    } else if (input == 'q') {
      print("Exiting...");
      break;
    }
  }
}

void drawSquare(int size) {
  for (int i = 0; i < size; i++) {
    print('* ' * size);
  }
}
