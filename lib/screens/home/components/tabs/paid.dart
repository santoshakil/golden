import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../home.dart';
import 'components/user_list.dart';

class Paid extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> data;

  const Paid({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KUserList(
      type: TabType.paid,
      data: data,
    );
  }
}
