void main() {
  // 1. Sum all elements in a list
  List<int> numbers = [1, 2, 3, 4, 5];
  int sum = numbers.reduce((a, b) => a + b);
  print("Sum = $sum");

  // 2. Find the largest number in a list
  List<int> nums = [15, 8, 22, 5, 31];
  int maxNum = nums.reduce((a, b) => a > b ? a : b);
  print("Max number = $maxNum");

  // 3. Reverse a list
  List<String> words = ["one", "two", "three"];
  print("Reversed list: ${words.reversed.toList()}");

  // 4. Remove duplicates using Set
  List<int> listWithDuplicates = [1, 2, 2, 3, 3, 3, 4];
  Set<int> uniqueNumbers = listWithDuplicates.toSet();
  print("Unique numbers: $uniqueNumbers");

  // 5. Count how many times each number appears 
  List<int> items = [1, 2, 2, 3, 3, 3];
  Map<int, int> freq = {};
  for (var i in items) {
    freq[i] = (freq[i] ?? 0) + 1;
  }
  print("Frequencies: $freq");

  // 6. Find even numbers from a list
  List<int> list = [10, 15, 20, 25, 30];
  List<int> evens = list.where((e) => e % 2 == 0).toList();
  print("Even numbers: $evens");

  // 7. Merge two lists and sort
  List<int> a = [5, 1, 9];
  List<int> b = [3, 7, 2];
  List<int> merged = [...a, ...b];
  merged.sort();
  print("Merged and sorted: $merged");

  // 8. Map of students and grades — print all with grade > 80
  Map<String, int> grades = {
    "Alice": 90,
    "Bob": 75,
    "Charlie": 85,
    "David": 60
  };
  grades.forEach((name, score) {
    if (score > 80) print("$name passed with $score");
  });

  // 9. Find intersection of two sets
  Set<int> set1 = {1, 2, 3, 4};
  Set<int> set2 = {3, 4, 5, 6};
  Set<int> intersection = set1.intersection(set2);
  print("Intersection: $intersection");

  // 10. Create a map and update a value
  Map<String, int> stock = {"apple": 10, "banana": 5, "orange": 7};
  stock["banana"] = 12;
  print("Updated stock: $stock");
}
