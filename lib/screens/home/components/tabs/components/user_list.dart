import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../home.dart';
import 'user_card.dart';

class KUserList extends StatelessWidget {
  const KUserList({
    Key? key,
    required this.type,
    required this.data,
  }) : super(key: key);

  final List<QueryDocumentSnapshot<Object?>> data;
  final TabType type;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        var _user = data[i];
        return KUserCard(user: _user, type: type);
      },
    );
  }
}
