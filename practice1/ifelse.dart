void main() {
  // 1. Even or odd
  int a = 7;
  print(a % 2 == 0 ? "Even" : "Odd");

  // 2. Positive, negative or zero
  int b = -3;
  if (b > 0) print("Positive");
  else if (b < 0) print("Negative");
  else print("Zero");

  // 3. Larger of two numbers
  int x = 12, y = 20;
  print(x > y ? x : y);

  // 4. Divisible by 3 and 5
  int n = 30;
  print(n % 3 == 0 && n % 5 == 0 ? "Divisible by 3 and 5" : "Not divisible");

  // 5. Age category
  int age = 17;
  if (age < 13) print("Child");
  else if (age < 18) print("Teenager");
  else print("Adult");

  // 6. Leap year
  int year = 2024;
  print((year % 4 == 0 && year % 100 != 0) || year % 400 == 0
      ? "Leap year"
      : "Not leap year");

  // 7. Sum from 1 to N
  int N = 10;
  int sum = 0;
  for (int i = 1; i <= N; i++) sum += i;
  print("Sum = $sum");

  // 8. Product from 1 to N
  int NN = 5;
  int product = 1;
  for (int i = 1; i <= NN; i++) product *= i;
  print("Product = $product");

  // 9. Numbers 1–100 divisible by 7
  print("Divisible by 7:");
  for (int i = 1; i <= 100; i++) {
    if (i % 7 == 0) print(i);
  }

  // 10. Count of even numbers 1–50
  int count = 0;
  for (int i = 1; i <= 50; i++) {
    if (i % 2 == 0) count++;
  }
  print("Even numbers: $count");

  // 11. Factorial of N
  int f = 6;
  int fact = 1;
  for (int i = 1; i <= f; i++) fact *= i;
  print("Factorial = $fact");

  // 12. Sum of digits
  int num = 1234;
  int s = 0;
  int temp = num;
  while (temp > 0) {
    s += temp % 10;
    temp ~/= 10;
  }
  print("Sum of digits = $s");

  // 13. Palindrome (number)
  String str = "1221";
  String rev = str.split('').reversed.join();
  print(str == rev ? "Palindrome" : "Not palindrome");

  // 14. Multiplication table 1–10
  for (int i = 1; i <= 10; i++) {
    for (int j = 1; j <= 10; j++) {
      print("$i × $j = ${i * j}");
    }
    print("----------");
  }

  // 15. Two-digit numbers with digit sum = 10
  print("Two-digit numbers where sum of digits = 10:");
  for (int i = 10; i <= 99; i++) {
    int d1 = i ~/ 10;
    int d2 = i % 10;
    if (d1 + d2 == 10) print(i);
  }

  // 16. Count numbers 1–100 divisible by 3 or 5
  int counter = 0;
  for (int i = 1; i <= 100; i++) {
    if (i % 3 == 0 || i % 5 == 0) counter++;
  }
  print("Numbers divisible by 3 or 5: $counter");

  // 17. Reverse a string
  String text = "Flutter";
  print("Reversed: ${text.split('').reversed.join()}");

  // 18. Count vowels
  String input = "education".toLowerCase();
  int vowels = 0;
  for (var ch in input.split('')) {
    if ("aeiou".contains(ch)) vowels++;
  }
  print("Vowels: $vowels");

  // 19. String palindrome
  String w = "level";
  String revw = w.split('').reversed.join();
  print(w == revw ? "Palindrome" : "Not palindrome");

  // 20. Password length check
  String pass = "mypassword";
  print(pass.length < 8 ? "Too short" : "Good length");
}
