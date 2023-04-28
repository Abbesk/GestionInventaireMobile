import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';

import '../Controllers/AuthController.dart';
import 'choisirSocieteScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    final AuthController authController = Get.find();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,

              actions: [
                IconButton(
                    icon: Icon(themeNotifier.isDark
                        ? Icons.nightlight_round
                        : Icons.wb_sunny, color: themeNotifier.isDark ? Colors.white : Colors.grey.shade900),
                    onPressed: () {
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    }
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.only(left: 20, right: 20, bottom: size.height * 0.2, top: size.height * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hello, \nWelcome Back", style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: size.width * 0.1,)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        SizedBox(height: 50,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username"
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password"
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 0.5, vertical: 5.0)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Theme.of(context).primaryColorLight),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            bool success = await authController.login(
                              emailController.text,
                              passwordController.text,
                            );
                            if (success) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChoisirSocieteScreen()),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Text(
                                "Se connecter",
                                style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: size.width * 0.05,),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30,),

                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}