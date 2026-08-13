import 'package:hive_ce/hive_ce.dart';

import '../contact.dart';

@GenerateAdapters([
  AdapterSpec<Contact>(),
  AdapterSpec<Relationship>(),
])
part 'hive_adapters.g.dart';
