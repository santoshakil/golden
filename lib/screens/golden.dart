import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/themes/themes.dart';
import '../providers/providers.dart';
import 'auth/auth.dart';
import 'home/home.dart';

class Golden extends StatelessWidget {
  const Golden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _user = FirebaseAuth.instance.currentUser;

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: _user != null ? HomeScreen() : AuthScreen(),
      ),
    );
  }
}
