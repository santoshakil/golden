import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user/users.dart';
import '../tabs/all.dart';
import '../tabs/due.dart';
import '../tabs/paid.dart';

class KTabView extends StatelessWidget {
  const KTabView({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    var _p = Provider.of<UserProvider>(context);

    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: _p.users.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _data = snapshot.data;
          return TabBarView(
            controller: _tabController,
            children: [
              Due(data: _data),
              Paid(data: _data),
              AllUsers(data: _data),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
