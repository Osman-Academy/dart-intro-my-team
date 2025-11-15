void main() {
  print("=== Dart Test App ===");

  // 1. Test variables
  int age = 20;
  String name = "Mars";
  double score = 95.5;

  print("Name: $name");
  print("Age: $age");
  print("Score: $score");

  // 2. Test list
  List<String> fruits = ["Apple", "Banana", "Orange"];
  print("\nFruits List:");
  for (var f in fruits) {
    print("- $f");
  }

  // 3. Test map
  Map<String, dynamic> user = {
    "name": "Mars",
    "role": "Developer",
    "active": true
  };
  print("\nUser Info: $user");

  // 4. Test function
  int sum(int a, int b) => a + b;
  print("\n5 + 10 = ${sum(5, 10)}");

  // 5. Test class
  Person p = Person("Daniel", 22);
  p.sayHello();
}

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void sayHello() {
    print("\nHello! My name is $name. I am $age years old.");
  }
}
