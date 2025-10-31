import 'dart:io';
import 'dart:math';
import 'dart:async';

void clearScreen() {
  if (Platform.isWindows) {
    stdout.write('\x1B[2J\x1B[0;0H');
  } else {
    stdout.write('\x1B[2J\x1B[H');
  }
}

void drawSquare(double angle, int size) {
  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      double cx = size / 2;
      double cy = size / 2;

      double nx = cos(angle) * (x - cx) - sin(angle) * (y - cy) + cx;
      double ny = sin(angle) * (x - cx) + cos(angle) * (y - cy) + cy;

      if (nx.round() == x && ny.round() == y) {
        stdout.write("#");
      } else {
        stdout.write(" ");
      }
    }
    stdout.writeln();
  }
}

Future<void> main() async {
  const int minSize = 2;
  const int maxSize = 10;
  const double rotationSpeed = 0.1;
  const int frameDelay = 100;

  int size = maxSize;
  double angle = 0.0;
  bool shrinking = true;

  // Listen for a key press to stop
  stdin.echoMode = false;
  stdin.lineMode = false;
  bool stop = false;
  stdin.listen((_) {
    stop = true;
  });

  while (!stop) {
    clearScreen();
    drawSquare(angle, size);
    angle += rotationSpeed;

    // Shrink or grow
    if (shrinking) {
      size--;
      if (size <= minSize) shrinking = false;
    } else {
      size++;
      if (size >= maxSize) shrinking = true;
    }

    await Future.delayed(Duration(milliseconds: frameDelay));
  }

  // Reset terminal modes
  stdin.echoMode = true;
  stdin.lineMode = true;
  clearScreen();
  print("Animation stopped!");
}
