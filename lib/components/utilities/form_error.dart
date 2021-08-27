import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/size_config/size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, bottom: 10.0),
      child: Column(
        children: List.generate(
          errors.length,
          (index) => formErrorText(error: errors[index]),
        ),
      ),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/cancel.svg",
          height: getProportionateScreenWidth(14),
          width: getProportionateScreenWidth(14),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        SizedBox(
          width: ScreenSize.width * 0.8,
          child: Text(
            error,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
