import 'package:animated_text_kit/animated_text_kit.dart' as at;
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart'
    show SVProgressHUD;
import 'package:google_fonts/google_fonts.dart';

import '../../../apis/auth/auth.dart';
import '../../../components/buttons/default_button.dart';
import '../../../components/utilities/form_error.dart';
import '../../../helpers/constants/constants.dart';
import "../../../helpers/keyboard/keyboard.dart";
import '../../../helpers/size_config/size_config.dart';
import '../../../helpers/themes/themes.dart';

class SigninBody extends StatefulWidget {
  @override
  _SigninBodyState createState() => _SigninBodyState();
}

class _SigninBodyState extends State<SigninBody> {
  final _formKey = GlobalKey<FormState>();
  bool registered = true;
  String? _email, _password, _password2, _name, error;
  final List<String> errors = [];
  Duration _duration = Duration(milliseconds: 500);
  Cubic _curves = Curves.fastOutSlowIn;

  void addError(error) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError(error) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext ctx) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topGap(),
          headerText(),
          animate(nameFiled()),
          emailFiled(),
          passwordField(),
          animate(confirmPasswordField()),
          errors.isEmpty ? Container() : FormError(errors: errors),
          authButton(),
          signUpButton(),
          agrement(),
        ],
      ),
    );
  }

  AnimatedSwitcher topGap() {
    return AnimatedSwitcher(
      duration: _duration,
      switchInCurve: _curves,
      child: registered
          ? SizedBox(height: ScreenSize.height * 0.25)
          : SizedBox(height: 50.0),
    );
  }

  AnimatedSwitcher animate(Widget widget) {
    return AnimatedSwitcher(
      duration: _duration,
      switchInCurve: _curves,
      child: !registered ? widget : Container(),
    );
  }

  Container headerText() {
    return Container(
      padding: EdgeInsets.only(bottom: 40.0),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 40.0,
          color: kPrimaryColor,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontFamily: GoogleFonts.bitter(
            fontWeight: FontWeight.w900,
          ).fontFamily,
        ),
        child: at.AnimatedTextKit(
          displayFullTextOnTap: true,
          totalRepeatCount: 3,
          animatedTexts: [
            at.TypewriterAnimatedText('Golden Trade'),
          ],
        ),
      ),
    );
  }

  DefaultButton authButton() {
    return DefaultButton(
      text: registered ? 'SignIn' : 'Signup',
      press: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          Keyboard.hide(context);
          SVProgressHUD.show(status: 'Please wait');
          error = registered
              ? await Auth.signIn(_email, _password, context)
              : await Auth.signUp(
                  email: _email!,
                  password: _password!,
                  name: _name ?? '',
                  context: context,
                );
          if (error != null) {
            addError(error);
          }
        }
      },
    );
  }

  Padding signUpButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: TextButton(
        onPressed: () => setState(() => registered = !registered),
        child: Text(
          registered ? 'Create a new Account' : 'Already have an Account',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding emailFiled() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (v) => _email = v,
        onSaved: (v) => _email = v,
        validator: (v) {
          if (v!.isEmpty) {
            return kPhoneNumberNullError;
          } else if (!emailPhoneValidatorRegExp.hasMatch(v)) {
            return kInvaliedPhoneNumberError;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "Enter your Email",
          suffixIcon: Icon(
            Icons.phone_rounded,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Padding passwordField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: TextFormField(
        obscureText: true,
        onChanged: (v) => _password = v,
        onSaved: (v) => _password = v,
        validator: (v) {
          if (v!.isEmpty) {
            return kPassNullError;
          } else if (v != _password2) {
            if (!registered) {
              return kMatchPassError;
            }
          } else if (v.length < 8) {
            return kShortPassError;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          suffixIcon: Icon(
            Icons.security_rounded,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Padding confirmPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: TextFormField(
        obscureText: true,
        onChanged: (v) => _password2 = v,
        onSaved: (v) => _password2 = v,
        validator: (v) {
          if (v!.isEmpty) {
            return kPassNullError;
          } else if (v != _password) {
            return kMatchPassError;
          } else if (v.length < 8) {
            return kShortPassError;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Enter your password again",
          suffixIcon: Icon(
            Icons.security_rounded,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Padding nameFiled() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.name,
        onChanged: (v) => _name = v,
        onSaved: (v) => _name = v,
        validator: (v) {
          if (v!.isEmpty) {
            return kFirstNameNullError;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Name",
          hintText: "Enter your Name",
          suffixIcon: Icon(
            Icons.person_rounded,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Padding agrement() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 17.0),
      child: Text(
        'By registering, you accepts our Terms & Conditions and Privacy Policy',
        textAlign: TextAlign.center,
      ),
    );
  }
}
