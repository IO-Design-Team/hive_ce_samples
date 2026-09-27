import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box('sketch'),
      builder: (context, box) {
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
