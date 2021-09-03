import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import '../../helpers/constants/constants.dart';

class UserProvider with ChangeNotifier {
  final key = GlobalKey<FormState>();
  double textFieldHeight = 35.0;

  TextEditingController name = TextEditingController(text: ''),
      userName = TextEditingController(text: ''),
      password = TextEditingController(text: ''),
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
        'userName': userName.text,
        'password': password.text,
        'address': address.text,
        'phone': phone.text,
        'speed': speed.text,
        'price': price.text,
        'lastPayment': '',
        'paid': 0.0,
        'time': DateTime.now().toIso8601String(),
      });
      print("User Added");
      Navigator.pop(context);
    } on Exception catch (e) {
      print("Failed to add user: $e");
      Navigator.pop(context);
    }

    name.clear();
    userName.clear();
    password.clear();
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
      await data.update({
        'lastPayment': thisMonth.toIso8601String(),
        'paid': !_paid
            ? double.tryParse(paymentAmount.text)
            : (_data['paid'] ?? 0) + double.tryParse(paymentAmount.text),
      });
      SVProgressHUD.dismiss();
      Navigator.pop(context);
      paymentAmount.clear();
    }
  }

  void reload() => notifyListeners();
}
