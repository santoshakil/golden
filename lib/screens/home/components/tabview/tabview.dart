import 'package:flutter/material.dart';

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
    return TabBarView(
      controller: _tabController,
      children: [
        Due(),
        Paid(),
        AllUsers(),
      ],
    );
  }
}
