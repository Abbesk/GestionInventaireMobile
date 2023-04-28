import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:44328/api/Utilisateur/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'codeuser': email, 'motpasse': password}),
      );
      if (response.statusCode == 200) {
        await storage.write(key: 'codeuser', value: email);
        final token = response.body;
        await storage.write(key: 'jwt_token', value: token);
        isLoggedIn.value = true;
        return true;
      } else {
        // Handle invalid credentials
        Get.snackbar(
          'Error',
          'Invalid email or password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoggedIn.value = false;
        return false;
      }
    } catch (e) {
      // Handle network errors

      isLoggedIn.value = false;
      return false;
    }
  }



  Future<void> signOut() async {
    isLoggedIn.value = false;
    await storage.delete(key: 'jwt_token');
  }

  Future<void> choisirSociete(String soc) async {

    final token = (await storage.read(key: "jwt_token"))?.replaceAll('"', '');
    final url = 'http://localhost:44328/Api/Utilisateur/ChoisirSociete?soc=';
    final encodedUrl = Uri.parse(url + soc!); // added token to the url
    final response = await http.post(
      encodedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Access-Control-Allow-Origin': '*', // This is the cross-origin header
      },
    );
    if (response.statusCode == 200) {
      // handle successful response
    } else {
      print('Failed to fetch inventaires due to unexpected error. Reason: ');
    }
  }


  Future<void> logout() async {
    final response = await http.post(Uri.parse('http://localhost:44328/Api/Utilisateur/Logout'));

    if (response.statusCode == 200) {

    } else {
      print("erreur logout");
    }
  }


}
//final token = (await storage.read(key: "jwt_token"))