import 'dart:io';

void main() {
  double size = 200;

  while (true) {
    print('Current square size: $size');

    stdout.write('Press Enter to shrink or type "reset" to restore: ');
    String? input = stdin.readLineSync();

    if (input == 'reset') {
      size = 200;
      print('Square reset to 200.\n');
    } else {
      if (size > 50) {
        size -= 20;
      } else {
        print('Minimum size reached. Type "reset" to restore.\n');
      }
    }
  }
}
