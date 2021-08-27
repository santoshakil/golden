import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user/users.dart';
import '../../home.dart';
import 'components/user_list.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _p = Provider.of<UserProvider>(context);

    return SingleChildScrollView(
      child: KUserList(
        type: TabType.all,
        stream: _p.users.snapshots(),
      ),
    );
  }
}
