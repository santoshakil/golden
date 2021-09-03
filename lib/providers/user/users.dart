import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import '../../helpers/constants/constants.dart';

class UserProvider with ChangeNotifier {
  final key = GlobalKey<FormState>();
  double textFieldHeight = 35.0;

  TextEditingController name = TextEditingController(text: ''),
      address = TextEditingController(text: ''),
      phone = TextEditingController(text: ''),
      speed = TextEditingController(text: ''),
      price = TextEditingController(text: ''),
      paymentAmount = TextEditingController(text: '');

  Stream<QuerySnapshot<Map<String, dynamic>>> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  Future<void> addUser(context) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.add({
        'name': name.text,
        'address': address.text,
        'phone': phone.text,
        'speed': speed.text,
        'price': price.text,
        'lastPayment': '',
        'paid': 0.0,
        'time': DateTime.now(),
      });
      print("User Added");
      Navigator.pop(context);
    } on Exception catch (e) {
      print("Failed to add user: $e");
    }

    name.clear();
    address.clear();
    phone.clear();
    speed.clear();
    price.clear();
    textFieldHeight = 35.0;
  }

  Future<void> addPayment({
    required DocumentReference data,
    required BuildContext context,
  }) async {
    if (paymentAmount.text.isNotEmpty) {
      SVProgressHUD.show();
      var _data = await data.get();
      bool _paid = _data['lastPayment'] == thisMonth.toIso8601String();
      await data
          .collection(thisMonth.toIso8601String())
          .doc()
          .set({'paid': paymentAmount.text, 'time': DateTime.now()});
      await data.update({
        'lastPayment': thisMonth.toIso8601String(),
        'paid': !_paid
            ? paymentAmount.text
            : (_data['paid'] ?? 0) + double.tryParse(paymentAmount.text),
      });
      SVProgressHUD.dismiss();
      Navigator.pop(context);
      paymentAmount.clear();
    }
  }

  void reload() => notifyListeners();
}
