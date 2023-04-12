import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';


import '../Models/Inventaire.dart';

class CreateInventaireScreen extends StatefulWidget {
  @override
  _CreateInventaireScreenState createState() => _CreateInventaireScreenState();
}

class _CreateInventaireScreenState extends State<CreateInventaireScreen> {
  final InventaireController _inventaireController = Get.find<
      InventaireController>();
  final TextEditingController _numinvController = TextEditingController();
  final TextEditingController _dateinvController = TextEditingController();
  final TextEditingController _nbrcomptageController = TextEditingController(
      text: '1');
  final TextEditingController _commentaireController = TextEditingController(
      text: 'Inventaire Physique');
  final TextEditingController _codepvController = TextEditingController();
  final TextEditingController _codedepController = TextEditingController();

  @override
  void dispose() {
    _numinvController.dispose();
    _dateinvController.dispose();
    _nbrcomptageController.dispose();
    _commentaireController.dispose();
    _codepvController.dispose();
    _codedepController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  Future<void> _initControllers() async {
    String nouveauIndex = await _inventaireController.getNouveauIndex();
    setState(() {
      _numinvController.text = nouveauIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Inventaire')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Numéro Inventaire'),
            TextField(
              controller: _numinvController,
            ),
            SizedBox(height: 16.0),
            Text('Date Inventaire'),
            TextField(
              controller: _dateinvController,
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                ).then((value) => _dateinvController.text = value.toString());
              },
            ),
            SizedBox(height: 16.0),
            Text('Nombre de Comptage'),
            TextField(
              controller: _nbrcomptageController,
              readOnly: true,
            ),
            SizedBox(height: 16.0),
            Text('Commentaire'),
            TextField(
              controller: _commentaireController,
              readOnly: true,
            ),
            SizedBox(height: 16.0),
            Text('Code Point de Vente'),
            TextField(
              controller: _codepvController,
            ),
            SizedBox(height: 16.0),
            Text('Code Dépôt'),
            TextField(
              controller: _codedepController,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Create'),
              onPressed: () {
                Inventaire inventaire = Inventaire(
                  pointVente: null,
                  lignesInventaire: null,
                  depot: null,
                  numinv: _numinvController.text,
                  dateinv: DateTime.parse(_dateinvController.text).toString(),
                  nbrcomptage: int.parse(_nbrcomptageController.text),
                  commentaire: _commentaireController.text,
                  cloture: '0',
                  datecloture: null,

                  DATEDMAJ: DateTime.now().toString(),
                  codepv: _codepvController.text,
                  libpv: '',
                  codedep: _codedepController.text,
                  libdep: '',
                );
                _inventaireController.CreerInventaire(inventaire);
              },
            ),
          ],
        ),
      ),
    );
  }
}