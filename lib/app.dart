import 'package:flutter/material.dart';

class LagClothingApp extends StatelessWidget {
  const LagClothingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lag Clothing',
     home: Scaffold(
      body: Center(
        child: Text('Lag Clothing!'),
      ),
    )
    );
  }
}