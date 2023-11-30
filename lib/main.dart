import 'dart:convert';

import 'package:coincapp/models/app_config.dart';
import 'package:coincapp/pages/home_page.dart';
import 'package:coincapp/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHttpService();
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String _configContent =
      await rootBundle.loadString("assets/config/mean.json");
  Map _configData = jsonDecode(_configContent);
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(
      COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"],
    ),
  );
}

void registerHttpService() {
  GetIt.instance.registerSingleton<HTTPService>(
    HTTPService(),
  );
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
