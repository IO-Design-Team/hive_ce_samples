class Contact {
  const Contact({
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.relationship,
  });

  final String name;
  final int age;
  final String phoneNumber;
  final Relationship relationship;
}

enum Relationship { family, friend }

const relationships = <Relationship, String>{
  Relationship.family: 'Family',
  Relationship.friend: 'Friend',
};
