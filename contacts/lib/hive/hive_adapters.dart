import 'package:contacts_hive/contact.dart';
import 'package:hive_ce/hive_ce.dart';

@GenerateAdapters([AdapterSpec<Contact>(), AdapterSpec<Relationship>()])
part 'hive_adapters.g.dart';
