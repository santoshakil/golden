import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../helpers/size_config/size_config.dart';
import 'components/create_user.dart';
import 'tabbar/tabbar.dart';
import 'tabview/tabview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
    ScreenSize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: mainMin,
            children: [
              KTabBar(tabController: _tabController),
              Expanded(child: KTabView(tabController: _tabController))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: () => showModal(
          context: context,
          builder: (_) => AlertDialog(
            scrollable: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: CreateUserField(),
          ),
        ),
      ),
    );
  }
}
