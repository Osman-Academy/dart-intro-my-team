import 'dart:io';
import 'hw1/hw1.dart';
import 'hw2/hw2.dart';
import 'hw3/hw3.dart';

void main() {
  print("1 - HW1");
  print("2 - HW2");
  print("3 - HW3");
  stdout.write("Choose: ");
  String? choice = stdin.readLineSync();

  if (choice == "1") {
    runHW1();
  } else if (choice == "2") {
    runHW2();
  } else if (choice == "3") {
    runHW3();
  } else {
    print("Invalid option.");
  }
}
