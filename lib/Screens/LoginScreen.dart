import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventaire_mobile/Screens/choisirSocieteScreen.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';




class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  bool _isCodeUserFocused = false;
  bool _isPasswordFocused = false;

  final AuthController authController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight:  MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade900,
                  Colors.green,
                  Colors.greenAccent,

                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment : CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36.0 , horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: [
                      Text(
                        "login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 46.0,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        "Welcome to the best Restaurant",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w300
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: _isCodeUserFocused ? Colors.white : Color(0xFFe7edeb),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: _isCodeUserFocused ? Colors.grey.withOpacity(0.5) : Colors.transparent,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: emailController,
                            keyboardType : TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: _isCodeUserFocused ? Colors.green.shade400 : Colors.white,
                                hintText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey[600],
                                )
                            ),
                            onTap: () {
                              setState(() {
                                _isCodeUserFocused = true;
                                _isPasswordFocused = false;
                              });
                            },
                            onSubmitted: (_) {
                              setState(() {
                                _isCodeUserFocused= true;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: _isPasswordFocused ? Colors.white : Color(0xFFe7edeb),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: _isPasswordFocused ? Colors.grey.withOpacity(0.5) : Colors.transparent,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child:
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:  _isPasswordFocused ? Colors.green.shade400: Colors.white,
                                hintText: "password",
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.grey[600],
                                )
                            ),
                            onTap: () {
                              setState(() {
                                _isPasswordFocused = true;
                                _isCodeUserFocused = false;
                              });
                            },
                            onSubmitted: (_) {
                              setState(() {
                                _isPasswordFocused = true;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
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
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.lightGreenAccent,
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              // increased padding for a larger button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Padding(padding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                "login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                            )
                            ,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
