import 'dart:io';

import 'package:contact_management/src/core/theme/app_theme.dart';
import 'package:contact_management/src/core/utils/app_constants.dart';
import 'package:contact_management/src/features/contact/view/page/contact_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCnoTzOoAqHCGE2ezXyNzvYEFUwLqiaXCA",
        appId: "1:24090663699:android:7b88f749ee38fe9c1858e6",
        messagingSenderId: "24090663699",
        projectId: "contact-management-app-cce62",
    )
  ):
  await Firebase.initializeApp();

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

