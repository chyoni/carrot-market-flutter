import 'package:carrotmarket/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CarrotMarketApp());
}

class CarrotMarketApp extends StatelessWidget {
  const CarrotMarketApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'CarrotMarket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
