
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';


import '../Models/Depot.dart';
import '../Models/Inventaire.dart';
import '../Models/TMPLigneDepot.dart';
import 'aa.dart';



class CloturerInventaireScreen extends StatefulWidget {
  final Inventaire inventaire;

  CloturerInventaireScreen({required this.inventaire});

  @override
  _CloturerInventaireScreenState createState() => _CloturerInventaireScreenState();
}

class _CloturerInventaireScreenState extends State<CloturerInventaireScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InventaireController _inventaireRepository = InventaireController();
  late List<TMPLigneDepot> _tmpLignesDepot;
  String? _numinv;
  String? _codepv;
  String? _codedep;
AuthController _authController = AuthController();
  @override
  void initState() {
    super.initState();
    _numinv = widget.inventaire.numinv;
    _codepv = widget.inventaire.codepv;
    _codedep = widget.inventaire.codedep;
    _tmpLignesDepot = (widget.inventaire.depot?.tmp_LignesDepot ?? []) as List<TMPLigneDepot>;

  }


  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {


        final inventaire = Inventaire(
          numinv: _numinv!,
          codedep: _codedep!,
          codepv: _codepv!,

          depot: Depot(
            Code: _codedep!,
            codepv: _codepv!,
            tmp_LignesDepot: _tmpLignesDepot!,
          ),
        );
        await _inventaireRepository.CloturerInventaire(
          widget.inventaire.numinv!,
          inventaire,
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) => ListeInventairesScreen()));
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text("Cloturer l'inventaire"),
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _numinv,
                enabled: false,
                decoration: InputDecoration(labelText: 'Numéro inventaire'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Numéro Inventaire';
                  }
                  return null;
                },
                onSaved: (value) => _numinv = value!,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _codepv,
                enabled: false,
                decoration: InputDecoration(labelText: 'Point de vente'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Point de vente';
                  }
                  return null;
                },
                onSaved: (value) => _codepv = value!,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _codedep,
                decoration: InputDecoration(labelText: 'Depot'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Depot';
                  }
                  return null;
                },
                onSaved: (value) => _codedep = value!,
              ),
              SizedBox(height: 16.0),


// Texte "Lignes de dépôt"
              Text(
                'Liste des articles',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

// Tableau pour afficher les lignes de dépôt
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Famille')),
                      DataColumn(label: Text('Code Article')),
                      DataColumn(label: Text('Désignation')),
                      DataColumn(label: Text('Quantitée physique')),
                      DataColumn(label: Text('Justification')),
                    ],
                    rows: _tmpLignesDepot.map(
                          (ligne) => DataRow(
                        cells: [
                          DataCell(Text(ligne.famille!)),
                          DataCell(Text(ligne.codeart!)),
                          DataCell(Text(ligne.desart!)),
                          DataCell(
                            TextFormField(
                              readOnly: true, // set to readOnly so it cannot be edited
                              initialValue: ligne.qteInventaire.toString(),

                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),

                            ),
                          ),
                          DataCell(
                            TextFormField(
                              readOnly: true, // set to readOnly so it cannot be edited
                              initialValue: ligne.commentaire,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),


                            ),
                          ),
                        ],
                      ),
                    ).toList(),
                  ),
                ),
              ),




              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListeInventairesScreen(),
                    ),
                  );
                },
                child: Text('Enregistrer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
