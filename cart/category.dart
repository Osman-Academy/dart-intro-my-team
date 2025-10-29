class Category {
  final int id;
  final String name;
  final String? description;
  
  Category({
    required this.id,
    required this.name,
    this.description,
  });
  
  @override
  String toString() => 'Category(id: $id, name: $name)';
}

