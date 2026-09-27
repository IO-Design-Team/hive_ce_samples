import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'colored_path.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<ColoredPath>('sketch');
    return StreamBuilder(
      stream: box.watch(),
      builder: (context, snapshot) {
        return IconButton(
          icon: const Icon(Icons.undo),
          onPressed: box.length == 0
              ? null
              : () {
                  box.deleteAt(box.length - 1);
                },
        );
      },
    );
  }
}
