import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:todo/hive/hive_registrar.g.dart';
import 'package:todo/new_todo_dialog.dart';
import 'package:todo/todo.dart';
import 'package:todo/todo_list.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapters();
  await Hive.openBox('settings');
  await Hive.openBox<Todo>('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'OpenSans'),
      home: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: const TodoMainScreen(),
        ),
      ),
    );
  }
}

class TodoMainScreen extends StatelessWidget {
  const TodoMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder(
            stream: Hive.box('settings').watch(key: 'reversed'),
            builder: (context, snapshot) =>
                _buildWithBox(context, Hive.box('settings')),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const NewTodoDialog();
            },
          );
        },
      ),
    );
  }

  Widget _buildWithBox(BuildContext context, Box settings) {
    final reversed = settings.get('reversed', defaultValue: true) as bool;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Hive To-Do', style: TextStyle(fontSize: 40)),
            const SizedBox(width: 20),
            IconButton(
              icon: Icon(
                reversed ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 32,
              ),
              onPressed: () {
                settings.put('reversed', !reversed);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          kIsWeb
              ? 'Refresh this tab to test persistence.'
              : 'Restart the app to test persistence.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: StreamBuilder(
            stream: Hive.box<Todo>('todos').watch(),
            builder: (context, snapshot) {
              var keys = Hive.box<Todo>('todos').keys.toList();
              if (reversed) {
                keys = keys.reversed.toList();
              }
              return TodoList(keys);
            },
          ),
        ),
      ],
    );
  }
}
