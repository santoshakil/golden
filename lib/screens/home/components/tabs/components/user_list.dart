import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../helpers/constants/constants.dart';

import '../../../home.dart';
import 'user_card.dart';

class KUserList extends StatelessWidget {
  const KUserList({
    Key? key,
    required this.type,
    required Stream<QuerySnapshot<Object?>> stream,
  })  : _stream = stream,
        super(key: key);

  final Stream<QuerySnapshot<Object?>> _stream;
  final TabType type;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: _stream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var _users = type == TabType.all
              ? snapshot.data!.docs.reversed.toList()
              : type == TabType.due
                  ? snapshot.data!.docs
                      .where((v) =>
                          v['lastPayment'] != thisMonth.toIso8601String())
                      .toList()
                      .reversed
                      .toList()
                  : snapshot.data!.docs
                      .where((v) =>
                          v['lastPayment'] == thisMonth.toIso8601String())
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
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
