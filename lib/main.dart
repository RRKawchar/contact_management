import 'package:contact_management/src/core/theme/app_theme.dart';
import 'package:contact_management/src/core/utils/app_constants.dart';
import 'package:contact_management/src/features/contact/view/page/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appConstants,
      debugShowCheckedModeBanner: false,
      theme:lightTheme,
      themeMode: ThemeMode.light,
      home:ContactPage()
    );
  }
}

