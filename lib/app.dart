import 'package:flutter/material.dart';
import 'themes/app_themes.dart';


class LagClothingApp extends StatelessWidget {
  const LagClothingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lag Clothing',
      theme: AppTheme.darkTheme,
      home: const Scaffold(
      body: Center(
        child: Text('Lag Clothing!'),
      ),
    )
    );
  }
}