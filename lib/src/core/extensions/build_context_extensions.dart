
import 'package:flutter/cupertino.dart';

extension BuildContextExtensions on BuildContext{
  void unFocus()=> FocusScope.of(this).unfocus();

  double get screenHeight=> MediaQuery.of(this).size.height;
  double get screenWidth=> MediaQuery.of(this).size.width;
}