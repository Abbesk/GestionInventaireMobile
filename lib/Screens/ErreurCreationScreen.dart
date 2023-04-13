import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForbiddenScreen extends StatelessWidget {
  ForbiddenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Impossible de créer l'inventaire.Veuiller Vérifier s'il y a déja un inventaire non cloturé pour le depot selectionné"),
      ),
    );
  }
}






