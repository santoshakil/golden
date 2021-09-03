import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/constants/constants.dart';
import '../../../home.dart';
import 'user_card.dart';

class KUserList extends StatelessWidget {
  const KUserList({
    Key? key,
    required this.type,
    required this.data,
  }) : super(key: key);

  final QuerySnapshot<Object?>? data;
  final TabType type;

  @override
  Widget build(BuildContext context) {
    var _users = type == TabType.all
        ? data!.docs.reversed.toList()
        : type == TabType.due
            ? data!.docs
                .where((v) => v['lastPayment'] != thisMonth.toIso8601String())
                .toList()
                .reversed
                .toList()
            : data!.docs
                .where((v) => v['lastPayment'] == thisMonth.toIso8601String())
                .toList()
                .reversed
                .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _users.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        var _user = _users[i];
        return KUserCard(user: _user, type: type);
      },
    );
  }
}
