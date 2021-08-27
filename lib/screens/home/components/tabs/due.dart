import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user/users.dart';
import '../../home.dart';
import 'components/user_list.dart';

class Due extends StatelessWidget {
  const Due({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _p = Provider.of<UserProvider>(context);

    return KUserList(
      type: TabType.due,
      stream: _p.users.snapshots(),
    );
  }
}
