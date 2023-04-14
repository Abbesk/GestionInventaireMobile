import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Screens/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:provider/provider.dart';

import 'Screens/aa.dart';
import 'Screens/themes/app_theme.dart';
import 'Screens/themes/theme_model.dart';

void main() {
  Get.put(AuthController());
  runApp(
      ChangeNotifierProvider(
          create: (_) => ThemeModel(),
          child: Consumer<ThemeModel>(
              builder: (context, ThemeModel themeNotifier, child) {
                return MaterialApp(
                  home: LoginPage(),
                  theme: themeNotifier.isDark ? AppTheme.dark : AppTheme.light,
                  debugShowCheckedModeBanner: false,
                );
              }
          )
      )
  );
}