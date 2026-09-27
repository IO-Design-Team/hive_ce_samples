import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:todo/todo.dart';

class TodoList extends StatelessWidget {
  final List<dynamic> keys;

  const TodoList(this.keys, {super.key});

  @override
  Widget build(BuildContext context) {
    if (keys.isEmpty) {
      return const Center(child: Text('Nothing to do... Great!'));
    } else {
      return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTodo(keys[index]);
        },
      );
    }
  }

  Widget _buildTodo(dynamic key) {
    final box = Hive.box<Todo>('todos');
    final todo = box.get(key)!;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  todo.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: todo.done ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  '${todo.created.hour}:${todo.created.minute}:'
                  '${todo.created.second}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              iconSize: 30,
              icon: Icon(todo.done ? Icons.clear : Icons.check),
              onPressed: () {
                box.put(key, todo.copyWith(done: !todo.done));
              },
            ),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.delete),
              onPressed: () {
                box.delete(key);
              },
            ),
          ],
        ),
      ),
    );
  }
}
