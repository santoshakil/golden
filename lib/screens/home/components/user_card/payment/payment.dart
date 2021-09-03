import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../components/buttons/default_button.dart';
import '../../../../../providers/user/users.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
    required QueryDocumentSnapshot<Object?> user,
  })  : _user = user,
        super(key: key);

  final QueryDocumentSnapshot<Object?> _user;

  @override
  Widget build(BuildContext context) {
    var _p = Provider.of<UserProvider>(context, listen: false);
    return IconButton(
      icon: Icon(Icons.add_rounded),
      onPressed: () => showModal(
        context: context,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
    );
  }
}
