

import 'dart:typed_data';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Models/Depot.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Models/Inventaire.dart';
import 'package:inventaire_mobile/Models/LigneDepot.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';





class SelectionnerArticleScreen extends StatefulWidget {
  final Inventaire inventaire;

  SelectionnerArticleScreen({required this.inventaire});

  @override
  _SelectionnerArticleScreenState createState() => _SelectionnerArticleScreenState();
}

class _SelectionnerArticleScreenState extends State<SelectionnerArticleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InventaireController _inventaireRepository = InventaireController();
  final _countController = TextEditingController();
  late List<LigneDepot> _lignesdepot;
  String? _numinv;
  String? _codepv;
  String? _codedep;
  late List<LigneDepot> _filteredLignesDepot;
  late List<bool> _checkboxStates;
  int selectedLineCount = 0;

  Future<String?> scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000',
        'Cancel',
        true,
        ScanMode.BARCODE
    );

    if (barcode != null) {
      LigneDepot? matchingLigne = _filteredLignesDepot.firstWhere(
            (ligne) => ligne.libelle == barcode,

      );

      // Show confirmation dialog if matching ligne is found
      if (matchingLigne != null) {
        if (matchingLigne.isSelected == 1) {
          await _showAlreadySelectedDialog(matchingLigne);
        } else {
          await _confirmSelection(matchingLigne);
        }
      }
    }

    return barcode;
  }
  Future<void> _showAlreadySelectedDialog(LigneDepot ligne) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('L article ${ligne.codeart} est déjà sélectionné '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous le conserver?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Conserver'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eleminer'),
              onPressed: () {
                setState(() {
                  ligne.isSelected = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmSelection(LigneDepot ligne) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Voulez vous ajouter cet article'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous'),
                Text('${ligne.libelle}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Oui'),
              onPressed: () {
                setState(() {
                  ligne.isSelected = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    _inventaireRepository.fetchInventaires();
    _countController.text = (widget.inventaire.depot?.lignesDepot?.length).toString();
    _numinv = widget.inventaire.numinv;
    _codepv = widget.inventaire.codepv;
    _codedep = widget.inventaire.codedep;

    _filteredLignesDepot =widget.inventaire.depot?.lignesDepot ?? [];
    _lignesdepot = widget.inventaire.depot?.lignesDepot ?? [];

    for (var ligne in _lignesdepot) {

      if (ligne.isSelected==1) {
        selectedLineCount++ ;
      }
    }
    _checkboxStates = List.filled(_filteredLignesDepot.length, false);
  }
  int getNumChecked() {
    // Count how many checkboxes are checked
    return _checkboxStates.where((state) => state).length;
  }
  void _updateLignesDepot(int index, bool value) {
    setState(() {
      _lignesdepot[index].isSelected = value ? 1 : 0;
      _filteredLignesDepot[index].isSelected = value ? 1 : 0;
      _checkboxStates[index] = value;
    });
  }
  int updateNombreSelectionne (){
    int countligne=0 ;
    for (var ligne in _lignesdepot) {
      if (ligne.isSelected==1) {
        countligne++;
      }
    }
    return countligne ;
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
            lignesDepot: _lignesdepot!,
          ),
        );
        await _inventaireRepository.selectionnerArticles(
          widget.inventaire.numinv!,
          inventaire,
        );
        // Navigate to InventaireListScreen after successful form submission
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListeInventairesScreen(),
          ),
        );
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
        title: Text('Selectionner les  articles pour inventaire   "' +_numinv.toString() +'"'),
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
              ),MaterialButton(
                child: Text('Scan Barcode'),
                onPressed: () async {
                  String? barcode = await scanBarcode();

                },
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
                enabled: false,
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
              TextField(
                enabled: false,
                controller: _countController,
                decoration: InputDecoration(labelText: "Nombre Total Des Articles"),
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              SizedBox(height: 16.0),


              Center(
                child: Text(
                  'Liste des articles',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

// Tableau pour afficher les lignes de dépôt
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Code Article')),
                      DataColumn(label: Text('Quantité')),
                      DataColumn(label: Text('Famille')),
                      DataColumn(label: Text('IsSelected')),
                    ],
                    rows: List<DataRow>.generate(
                      _filteredLignesDepot.length,
                          (index) {
                        final ligne = _lignesdepot[index];
                        final isChecked = _checkboxStates[index];
                        return DataRow(
                          cells: [
                            DataCell(Text(ligne.codeart!)),
                            DataCell(Text(ligne.qteart.toString())),
                            DataCell(Text(ligne.famille!)),
                            DataCell(
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return Checkbox(
                                    value: ligne.isSelected == 1,
                                    onChanged: (value) {
                                      _updateLignesDepot(index, value!);
                                      updateNombreSelectionne();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nombre de lignes sélectionnées: ${updateNombreSelectionne()}'), ],
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
