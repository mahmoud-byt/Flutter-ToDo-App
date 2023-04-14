import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfireproject/view/authintication/login.dart';
import 'package:flutterfireproject/view/layout/appLayout.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
    initialRoute: '/',
    theme: ThemeData(brightness: Brightness.dark),
  ));
}
