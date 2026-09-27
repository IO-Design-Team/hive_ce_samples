enum Relationship {
  family('Family'),
  friend('Friend');

  final String label;

  const Relationship(this.label);
}

class Contact {
  final String name;
  final int age;
  final String phoneNumber;
  final Relationship relationship;

  const Contact({
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.relationship,
  });
}
