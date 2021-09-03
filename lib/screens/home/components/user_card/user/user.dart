import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

import '../../../../../components/buttons/default_button.dart';

String _deleteConfirmation = '';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required QueryDocumentSnapshot<Object?> user,
  })  : _user = user,
        super(key: key);

  final QueryDocumentSnapshot<Object?> _user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
      actionsPadding: const EdgeInsets.only(bottom: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              _user['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ),
          Divider(thickness: 1),
          Align(
            alignment: Alignment.center,
            child: Text(
              'This Month Payment: ' + _user['paid'].toString() + ' Taka',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _user['paid'] > 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
          Divider(thickness: 1),
          Text('User Name: ' + _user['userName'], maxLines: 1),
          Text('Password: ' + _user['password'], maxLines: 1),
          Divider(thickness: 1),
          Text('Phone: ' + _user['phone'], maxLines: 1),
          Text('Address: ' + _user['address']),
          Text(
            'Speed: ' + _user['speed'] + ' Mbps',
            maxLines: 1,
          ),
          Text('Price: ' + _user['price']),
          Divider(thickness: 1),
          SizedBox(height: 10),
          _DeleteUserButton(user: _user, ctx: context),
        ],
      ),
    );
  }
}

class _DeleteUserButton extends StatelessWidget {
  const _DeleteUserButton({
    Key? key,
    required QueryDocumentSnapshot<Object?> user,
    required this.ctx,
  })  : _user = user,
        super(key: key);

  final QueryDocumentSnapshot<Object?> _user;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: 'Delete User',
      press: () => showModal(
        context: context,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
          actionsPadding: const EdgeInsets.only(bottom: 10),
          title: Text(
            'Enter \'Yes\' to Delete this User',
            textAlign: TextAlign.center,
          ),
          content: TextFormField(
            onChanged: (v) => _deleteConfirmation = v,
            maxLines: 1,
          ),
          actions: [
            DefaultButton(
              text: 'Delete',
              press: () async {
                if (_deleteConfirmation.toLowerCase() == 'yes') {
                  SVProgressHUD.show();
                  await _user.reference.delete();
                  SVProgressHUD.dismiss();
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
