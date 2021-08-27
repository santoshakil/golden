import 'package:flutter/material.dart'
    show BorderRadius, EdgeInsets, InputDecoration, OutlineInputBorder;
import 'package:intl/intl.dart' show DateFormat;

import '../size_config/size_config.dart';

final dateFormate = DateFormat('dd-MM-yyyy');
final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final nowTime = DateTime.now();
final today = DateTime(nowTime.year, nowTime.month, nowTime.day);
final thisMonth = DateTime(nowTime.year, nowTime.month, 1);
final thisYear = DateTime(nowTime.year, 1, 1);

//WebView User Agent
const String webViewUserAgent =
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36';

//SignUp Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp emailPhoneValidatorRegExp =
    RegExp(r"^([0-9]{9})|([A-Za-z0-9._%\+\-]+@[a-z0-9.\-]+\.[a-z]{2,3})$");

const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kInvaliedInfoError = 'Email or Password Invalied';
const String kFirstNameNullError = "Please Enter your first name";
const String kLastNameNullError = "Please Enter your last name";
const String kResturantNameNullError = "Please Enter your Resturant name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kInvaliedPhoneNumberError = "Please Enter valid phone number";
const String kAddressNullError = "Please Enter your address";
const String kCountryNullError = "Please Select your Country";
const String kStateNullError = "Please Select your State";

const String kProductNameError = "Please Enter Product Name";
const String kProductDesError = "Please Enter Product Description";
const String kProductWeightError = "Please Enter Product Weight";
const String kCompanyNameError = "Please Enter Company Name";
const String kBuyPriceError = "Please Enter Product Buy Price";
const String kSellPriceError = "Please Enter Product Sell Price";
const String kOfferPriceError = "Please Enter Product Offer Price";
const String kCouponNameError = "Please Enter Coupon Name";
const String kCouponCodeError = "Please Enter Coupon Code";
const String kMinRangeError = "Please Enter Minimum Range";
const String kOfferAmmountError = "Please Enter Offer Ammount";
const String kCouponTypeError = "Please Select Coupon Type";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
  );
}

const String baseLink = 'https://unistag.xyz/api/';

const String playStoreUrl = 'https://play.google.com/store/apps/details?id= ';
