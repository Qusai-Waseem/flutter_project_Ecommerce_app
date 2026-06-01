import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/sh_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShopProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Electronics Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}