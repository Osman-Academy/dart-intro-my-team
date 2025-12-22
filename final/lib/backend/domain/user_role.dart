enum UserRole {
  admin,
  developer,
  manager,
  tester,
  designer;

  static UserRole parse(String value) {
    return UserRole.values.firstWhere(
      (r) => r.name.toLowerCase() == value.toLowerCase(),
      orElse: () => UserRole.developer,
    );
  }

  String get value => name;
}
