import 'package:hive_ce/hive_ce.dart';
import 'package:todo/todo.dart';

@GenerateAdapters([AdapterSpec<Todo>()])
part 'hive_adapters.g.dart';
