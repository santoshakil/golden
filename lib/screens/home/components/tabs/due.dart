import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../home.dart';
import 'components/user_list.dart';

class Due extends StatelessWidget {
  final QuerySnapshot<Object?>? data;

  const Due({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KUserList(
      type: TabType.due,
      data: data,
    );
  }
}
