import 'package:flutter/material.dart';

import '../../helpers/size_config/size_config.dart';
import '../../helpers/themes/themes.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        height: getProportionateScreenHeight(58),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: kPrimaryColor,
          ),
          onPressed: press as void Function()?,
          child: Text(
            text!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
