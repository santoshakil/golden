import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/constants/constants.dart';
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
      stream: _p.usersStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _data = snapshot.data;

          var _allUsers = _data!.docs.reversed.toList();

          var _dueUsers = _data.docs
              .where((v) => v['lastPayment'] != thisMonth.toIso8601String())
              .toList()
              .reversed
              .toList();

          var _paidUsers = _data.docs
              .where((v) => v['lastPayment'] == thisMonth.toIso8601String())
              .toList()
              .reversed
              .toList();

          return TabBarView(
            controller: _tabController,
            children: [
              Due(data: _dueUsers),
              Paid(data: _paidUsers),
              AllUsers(data: _allUsers),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
