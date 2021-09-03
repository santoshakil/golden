import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../home.dart';
import 'components/user_list.dart';

class AllUsers extends StatelessWidget {
  final QuerySnapshot<Object?>? data;

  const AllUsers({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: KUserList(
        type: TabType.all,
        data: data,
      ),
    );
  }
}
