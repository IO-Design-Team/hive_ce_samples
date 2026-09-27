class Todo {
  final String name;
  final DateTime created;
  final bool done;

  const Todo({required this.name, required this.created, this.done = false});

  Todo copyWith({bool? done}) =>
      Todo(name: name, created: created, done: done ?? this.done);
}
