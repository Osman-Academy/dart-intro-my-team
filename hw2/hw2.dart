import 'dart:io';

void runHW2() {
  double size = 150;
  double minSize = 40;
  bool running = true;

  print("Hw 2: Shrinking Square");

  while (running) {
    print("\nCurrent square size: $size");

    stdout.write("Press Enter to shrink, 'reset' to restore, or 'exit' to quit: ");
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      if (size > minSize) {
        size -= 15;
        print("Square got smaller!");
      } else {
        print("Minimum size reached ($minSize). Type 'reset' or 'exit'.");
      }
    } else if (input.toLowerCase() == "reset") {
      size = 150;
      print("Square reset to 150.");
    } else if (input.toLowerCase() == "exit") {
      print("Exiting program...");
      running = false;
    } else {
      print("Unknown command. Type 'reset' or 'exit'.");
    }
  }
}
