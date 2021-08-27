import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../components/buttons/default_button.dart';
import '../../../../../helpers/size_config/size_config.dart';
import '../../../../../providers/user/users.dart';

class CreateUserField extends StatelessWidget {
  const CreateUserField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _p = Provider.of<UserProvider>(context);

    return Form(
      key: _p.key,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: mainMin,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: _p.name,
                validator: _validator,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: 'User Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: _p.address,
                validator: _validator,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(labelText: 'Address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: _p.phone,
                validator: _validator,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: _p.speed,
                validator: _validator,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Speed'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: _p.price,
                validator: _validator,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DefaultButton(
                text: 'Add User',
                press: () async {
                  if (_p.key.currentState!.validate()) {
                    await _p.addUser(context);
                  } else {
                    _p.textFieldHeight = 50.0;
                    _p.reload();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validator(v) {
    if (v == null || v.isEmpty) {
      return 'This field can\'t be empty';
    }
  }
}
