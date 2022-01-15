import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: unused_import
import 'package:livreurs_app/views/Login/loginScreen.dart';
import 'views/Login/mainLogin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('fr')],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _isLoggedIn ? MainI() : LogIn(),
      ),
    );
  }
}
