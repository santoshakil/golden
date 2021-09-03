import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'user_card.dart';

class KUserList extends StatelessWidget {
  const KUserList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<QueryDocumentSnapshot<Object?>> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (_, i) {
        var _user = data[i];
        return KUserCard(user: _user);
      },
    );
  }
}
