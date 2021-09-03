import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../helpers/constants/constants.dart';
import '../../../../../../helpers/size_config/size_config.dart';
import 'payment/payment.dart';
import 'user/user.dart';

class KUserCard extends StatelessWidget {
  const KUserCard({
    Key? key,
    required QueryDocumentSnapshot<Object?> user,
  })  : _user = user,
        super(key: key);

  final QueryDocumentSnapshot<Object?> _user;

  @override
  Widget build(BuildContext context) {
    bool _paid = _user['lastPayment'] == thisMonth.toIso8601String();

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () => showModal(
            context: context,
            builder: (_) => UserDetails(user: _user),
          ),
          child: Container(
            width: ScreenSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _paid ? Colors.green[50] : Colors.red[50],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: crossStretch,
              mainAxisSize: mainMin,
              children: [
                Text('Name:     ' + _user['name'], maxLines: 1),
                Text('Phone:    ' + _user['phone'], maxLines: 1),
                Text('Price:    ' + _user['price'], maxLines: 1),
                _paid
                    ? Text(
                        'Payment:  ' + _user['paid'].toString() + ' Taka',
                        style: TextStyle(color: Colors.green),
                      )
                    : Text(
                        'Payment:  No Payment',
                        style: TextStyle(color: Colors.redAccent.shade400),
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address:  '),
                    SizedBox(
                      width: ScreenSize.width * 0.55,
                      child: Text(_user['address']),
                    ),
                  ],
                ),
                Text(
                  'Speed:    ' + _user['speed'] + ' Mbps',
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        PaymentButton(user: _user),
      ],
    );
  }
}
