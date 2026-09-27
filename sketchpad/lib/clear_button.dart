import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box('sketch'),
      builder: (context, box) {
        return IconButton(
          icon: const Icon(Icons.delete),
          onPressed: box.length == 0
              ? null
              : () {
                  box.clear();
                },
        );
      },
    );
  }
}
