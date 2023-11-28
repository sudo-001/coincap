import 'package:coincapp/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinCapp',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Color.fromRGBO(
          88,
          60,
          197,
          1.0,
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
