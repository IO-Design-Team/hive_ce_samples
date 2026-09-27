import 'dart:ui';

import 'package:hive_ce/hive_ce.dart';
import 'package:sketchpad/colored_path.dart';

@GenerateAdapters([AdapterSpec<ColoredPath>(), AdapterSpec<Offset>()])
part 'hive_adapters.g.dart';
