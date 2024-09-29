import 'package:contact_management/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowDialogService {
  static warningMessage(dynamic message) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: kWaringColor,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1
    );
  }

  static successMessage(dynamic message) {
    Fluttertoast.showToast(
        msg: message,
        fontSize: 18,
        backgroundColor: kSuccessColor,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1
    );
  }

  static errorMessage(dynamic message) {
    Fluttertoast.showToast(
        msg: message,
        fontSize: 18,
        backgroundColor: kErrorColor,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1
    );
  }
}
