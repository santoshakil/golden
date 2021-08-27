import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../helpers/size_config/size_config.dart';
import 'components/body.dart';
import 'components/tabs/components/create_user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      body: SafeArea(child: HomeBody()),
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

enum TabType { due, paid, all }
