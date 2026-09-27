import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'colored_path.dart';
import 'drawing_screen.dart';
import 'hive/hive_registrar.g.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<ColoredPath>('sketch');

  runApp(const DrawApp());
}

class DrawApp extends StatelessWidget {
  const DrawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Sketchpad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'OpenSans'),
      home: const DrawingScreen(),
    );
  }
}
