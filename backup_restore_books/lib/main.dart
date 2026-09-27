import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

const favoritesBox = 'favorite_books';
const List<String> books = [
  'Harry Potter',
  'To Kill a Mockingbird',
  'The Hunger Games',
  'The Giver',
  'Brave New World',
  'Unwind',
  'World War Z',
  'The Lord of the Rings',
  'The Hobbit',
  'Moby Dick',
  'War and Peace',
  'Crime and Punishment',
  'The Adventures of Huckleberry Finn',
  'Catch-22',
  'The Sound and the Fury',
  'The Grapes of Wrath',
  'Heart of Darkness',
];

final messengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(favoritesBox);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box<String> favoriteBooksBox;

  @override
  void initState() {
    super.initState();
    favoriteBooksBox = Hive.box<String>(favoritesBox);
  }

  Widget getIcon(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }

  void onFavoritePress(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      favoriteBooksBox.delete(index);
      return;
    }
    favoriteBooksBox.put(index, books[index]);
  }

  void showMessage(String message) {
    messengerKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> createBackup() async {
    if (favoriteBooksBox.isEmpty) {
      showMessage('Pick a favorite book.');
      return;
    }

    final map = favoriteBooksBox.toMap().map(
      (key, value) => MapEntry(key.toString(), value),
    );
    final json = jsonEncode(map);
    final date = DateTime.now().toIso8601String().replaceAll(':', '-');

    final uri = await FilePicker.saveFile(
      fileName: 'favorite_books_$date.json',
      bytes: utf8.encode(json),
      mimeType: 'application/json',
    );
    if (uri == null) return;

    showMessage('Backup created.');
  }

  Future<void> restoreBackup() async {
    final file = await FilePicker.pickFile();
    if (file == null) return;

    final json = utf8.decode(await file.readAsBytes());
    final map = (jsonDecode(json) as Map<String, dynamic>).map(
      (key, value) => MapEntry(int.parse(key), value as String),
    );
    await favoriteBooksBox.clear();
    await favoriteBooksBox.putAll(map);

    showMessage('Backup restored.');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Books with Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      scaffoldMessengerKey: messengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Favorite Books w/ Hive'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.backup),
              tooltip: 'Backup',
              onPressed: createBackup,
            ),
            IconButton(
              icon: Icon(Icons.restore),
              tooltip: 'Restore',
              onPressed: restoreBackup,
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: favoriteBooksBox.listenable(),
          builder: (context, Box<String> box, _) {
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, listIndex) {
                return ListTile(
                  title: Text(books[listIndex]),
                  trailing: IconButton(
                    icon: getIcon(listIndex),
                    onPressed: () => onFavoritePress(listIndex),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
