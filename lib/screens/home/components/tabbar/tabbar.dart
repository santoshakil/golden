import 'package:flutter/material.dart';

import '../../../../helpers/size_config/size_config.dart';
import '../../../../helpers/themes/themes.dart';

class KTabBar extends StatelessWidget {
  const KTabBar({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: ScreenSize.width,
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.black54,
        unselectedLabelColor: kPrimaryColor.withOpacity(0.7),
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.7),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.7),
        indicator: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        tabs: [
          TabItem(text: 'Due'),
          TabItem(text: 'Paid'),
          TabItem(text: 'All'),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String text;

  const TabItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w900),
      ),
    );
  }
}
