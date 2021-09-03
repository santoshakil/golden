import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../components/buttons/default_button.dart';
import '../../../../../helpers/constants/constants.dart';
import '../../../../../helpers/size_config/size_config.dart';
import '../../../../../providers/user/users.dart';

class KUserCard extends StatelessWidget {
  const KUserCard({
    Key? key,
    required QueryDocumentSnapshot<Object?> user,
  })  : _user = user,
        super(key: key);

  final QueryDocumentSnapshot<Object?> _user;

  @override
  Widget build(BuildContext context) {
    var _p = Provider.of<UserProvider>(context);
    bool _paid = _user['lastPayment'] == thisMonth.toIso8601String();

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
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
        IconButton(
          icon: Icon(Icons.add_rounded),
          onPressed: () => showModal(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
              actionsPadding: const EdgeInsets.only(bottom: 10),
              content: TextField(
                controller: _p.paymentAmount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              actions: [
                DefaultButton(
                  text: 'Add Payment',
                  press: () async => await _p.addPayment(
                    context: context,
                    data: _user.reference,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
