import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:provider/provider.dart';
import 'Screens/AuthentifierScreen.dart';
import 'Screens/themes/app_theme.dart';
import 'Screens/themes/theme_model.dart';

void main() {
  Get.put(AuthController());
  Get.put(InventaireController());
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