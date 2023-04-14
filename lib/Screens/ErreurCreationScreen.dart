import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';

import 'aa.dart';

class ForbiddenScreen extends StatelessWidget {
  ForbiddenScreen({Key? key}) : super(key: key);
AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text("Liste des inventaires"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authController.logout();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );// call the logout function and pass in the BuildContext of the current screen
            },
          ),
        ],
      ),
      body: Center(

        child: Text("Impossible de créer l'inventaire.Veuiller Vérifier s'il y a déja un inventaire non cloturé pour le depot selectionné"),
      ),
    );
  }
}






