import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'themes/app_themes.dart';

class LagClothingApp extends StatelessWidget {
  const LagClothingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Lag Clothing',
      theme: AppTheme.darkTheme,

      routerConfig: AppRouter.router,
    );
  }
}
