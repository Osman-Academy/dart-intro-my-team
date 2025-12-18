class Character{
  final String id;
  final String name;
  final String? house;
  final String? image;

  Character({
    required this.id,
    required this.name,
    this.house,
    this.image
  });
}

