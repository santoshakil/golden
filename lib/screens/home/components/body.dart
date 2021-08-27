import 'package:flutter/material.dart';

import '../../../helpers/size_config/size_config.dart';
import 'tabbar/tabbar.dart';
import 'tabview/tabview.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: mainMin,
        children: [
          KTabBar(tabController: _tabController),
          Expanded(child: KTabView(tabController: _tabController))
        ],
      ),
    );
  }
}
