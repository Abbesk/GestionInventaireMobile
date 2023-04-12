
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/LigneInventaire.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';


import '../Models/Depot.dart';
import '../Models/Inventaire.dart';
import '../Models/TMPLigneDepot.dart';



class AfficherLignesInventaireScreen extends StatefulWidget {
  final Inventaire inventaire;

  AfficherLignesInventaireScreen({required this.inventaire});

  @override
  _AfficherLignesInventaireScreenState createState() => _AfficherLignesInventaireScreenState();
}

class _AfficherLignesInventaireScreenState extends State<AfficherLignesInventaireScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InventaireController _inventaireRepository = InventaireController();
  late List<LigneInventaire> _lignesInventaire;
  String? _numinv;
  String? _codepv;
  String? _codedep;

  @override
  void initState() {
    super.initState();
    _numinv = widget.inventaire.numinv;
    _codepv = widget.inventaire.codepv;
    _codedep = widget.inventaire.codedep;
    _lignesInventaire = (widget.inventaire.lignesInventaire ?? []) as List<LigneInventaire>;

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cloturer inventaire'),
        backgroundColor: Colors.lightBlueAccent,
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
                  primary: Colors.lightBlueAccent,
                  onPrimary: Colors.white,
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
