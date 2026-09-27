import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class UndoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box('sketch'),
      builder: (context, box) {
        return IconButton(
          icon: Icon(Icons.undo),
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
