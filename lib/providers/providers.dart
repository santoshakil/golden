import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'user/users.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => UserProvider()),
];
