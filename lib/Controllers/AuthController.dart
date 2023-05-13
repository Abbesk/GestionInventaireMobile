import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
String baseURL="https://3204-102-109-204-239.ngrok-free.app/api/";


  Future<bool> login(String codeuser, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://3204-102-109-204-239.ngrok-free.app/api/Utilisateur/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'codeuser': codeuser, 'motpasse': password}),
      );
      if (response.statusCode == 200) {
        await storage.write(key: 'codeuser', value: codeuser);
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


      isLoggedIn.value = false;
      return false;
    }
  }

  Future<String> getRole() async {
    final token = (await storage.read(key: "jwt_token"))!.replaceAll('"', '');
    final response = await http.get(
      Uri.parse('https://3204-102-109-204-239.ngrok-free.app/api/Utilisateur/getRole'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Access-Control-Allow-Origin': '*', // This is the cross-origin header
      },);

    if (response.statusCode == 200) {
      // the API call was successful
      return json.decode(response.body);
    } else {
      // the API call failed
      throw Exception('Failed to load nouveau index');
    }
  }

  Future<void> signOut() async {
    isLoggedIn.value = false;
    await storage.delete(key: 'jwt_token');
  }

  Future<void> choisirSociete(String soc) async {

    final token = (await storage.read(key: "jwt_token"))?.replaceAll('"', '');
    final url = 'https://3204-102-109-204-239.ngrok-free.app/api/Utilisateur/ChoisirSociete?soc=';
    final encodedUrl = Uri.parse(url + soc); // added token to the url
    final response = await http.post(
      encodedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Access-Control-Allow-Origin': '*', // This is the cross-origin header
      },
    );
    if (response.statusCode == 200) {
      await storage.write(key: 'societe', value: soc);
    } else {
      print('Failed to fetch inventaires due to unexpected error. Reason: ');
    }
  }


  Future<void> logout() async {
    final response = await http.post(Uri.parse('https://3204-102-109-204-239.ngrok-free.app/api/Utilisateur/Logout'));

    if (response.statusCode == 200) {

    } else {
      print("erreur logout");
    }
  }


}
//final token = (await storage.read(key: "jwt_token"))