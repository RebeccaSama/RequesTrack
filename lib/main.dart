import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/modules/authenticate/login/views/login_view.dart';
import 'package:request_track/app/modules/student/home/views/home_view.dart';

import 'app/utils/init_preferences.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  Get.put(InitPreferences());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white, foregroundColor: Colors.black),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.black)),
          radioTheme: RadioThemeData(
              overlayColor: MaterialStateProperty.all(Colors.transparent))),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.white)),
          radioTheme: RadioThemeData(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              fillColor: MaterialStateProperty.all(Colors.blue))),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      themeMode: ThemeMode.light,
      home: LoginView(),
    );
  }
}

// - Adapter le message de s'inscrire à l'email ou le numéro de téléphone
