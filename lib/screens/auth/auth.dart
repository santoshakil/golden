import 'package:flutter/material.dart';

import '../../helpers/size_config/size_config.dart' show ScreenSize;
import 'components/body.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SigninBody(),
      ),
    );
  }
}
