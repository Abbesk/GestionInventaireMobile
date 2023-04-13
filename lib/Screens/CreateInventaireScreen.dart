import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/Depot.dart';
import 'package:inventaire_mobile/Screens/ErreurCreationScreen.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Screens/SelectionnerArticlesScreen.dart';

import '../Models/Inventaire.dart';
import '../Models/PointVente.dart';

class CreateInventaireScreen extends StatefulWidget {
  @override
  _CreateInventaireScreenState createState() => _CreateInventaireScreenState();
}

class _CreateInventaireScreenState extends State<CreateInventaireScreen> {
  final InventaireController _inventaireController = InventaireController();
  final TextEditingController _numinvController = TextEditingController();
  final TextEditingController _dateinvController = TextEditingController();
  final TextEditingController _nbrcomptageController = TextEditingController(
      text: '1');
  final TextEditingController _commentaireController = TextEditingController(
      text: 'Inventaire Physique');
  final TextEditingController _codedepController = TextEditingController();

  List<Depot> _deps = [];
  List<PointVente> _pvs = [];
  PointVente? _selectedPV;
  Depot? _selectedDep ;
  bool _isLoading = true;

  @override
  void dispose() {
    _numinvController.dispose();
    _dateinvController.dispose();
    _nbrcomptageController.dispose();
    _commentaireController.dispose();
    _codedepController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initControllers();
  }
  void updateDepots() {
    setState(() {
      // Filter the list of available depots based on the selected point of sale
      _deps = _deps.where((dep) => dep.codepv == _selectedPV?.Code!).toList();
    });
  }

  Future<void> _initControllers() async {
    String nouveauIndex = await _inventaireController.getNouveauIndex();
    setState(() {
      _numinvController.text = nouveauIndex;
    });
    _pvs = await _inventaireController.getAllPVS();
    _deps=await _inventaireController.getAllDeps();
    setState(() {
      _isLoading = false;


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

            Expanded(
              child: Visibility(
                visible: _pvs.isNotEmpty,
                child: SizedBox(
                  height: 50, // set a fixed height for the dropdown
                  child: DropdownButton<PointVente>(
                    value: _selectedPV,
                    onChanged: (PointVente? newValue) {
                      setState(() {
                        _selectedPV = newValue;
                         // Reset the selected depot when the point of sale changes
                        _deps = _deps.where((dep) => dep.codepv == _selectedPV?.Code!).toList();
                        _selectedDep = _deps[0];


                      });
                    },
                    items: [
                      DropdownMenuItem<PointVente>(
                        value: null,
                        child: Text('Choisir point de vente'),
                      ),
                      ..._pvs.map<DropdownMenuItem<PointVente>>((PointVente pv) {
                        return DropdownMenuItem<PointVente>(
                          value: pv,
                          child: Text(pv.Libelle!),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                replacement: CircularProgressIndicator(), // show a loader while _pvs is empty
              ),
            ),

            SizedBox(height: 16.0),
            Text('Code Dépôt'),
            Expanded(
              child: Visibility(
                visible: _deps.isNotEmpty,
                child: SizedBox(
                  height: 30, // set a fixed height for the dropdown
                  child: DropdownButton<Depot>(
                    value: _selectedDep,
                    onChanged: (Depot? newValue) {
                      setState(() {
                        _selectedDep = newValue;
                      });
                    },
                    items: [
                      DropdownMenuItem<Depot>(
                        value: null,
                        child: Text('Choisir Depot'),
                      ),
                      ..._deps
                          .where((dep) => dep.codepv == _selectedPV?.Code!)
                          .map<DropdownMenuItem<Depot>>((Depot dep) {
                        return DropdownMenuItem<Depot>(
                          value: dep,
                          child: Text(dep.Libelle!),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                replacement: CircularProgressIndicator(),
              ),
            ),

            SizedBox(height: 16.0),
            if (_selectedPV != null && _selectedDep != null)... [
              ElevatedButton(
                child: Text('Create'),
                onPressed: () async {
                  Inventaire inventaire = Inventaire(
                    numinv: _numinvController.text,
                    dateinv: DateTime.parse(_dateinvController.text).toString(),
                    nbrcomptage: int.parse(_nbrcomptageController.text),
                    commentaire: _commentaireController.text,
                    cloture: '0',
                    DATEDMAJ: DateTime.now().toString(),
                    codepv: _selectedPV?.Code,
                    codedep: _selectedDep?.Code,
                  );
                  await _inventaireController.CreerInventaire(inventaire);
                  // Check the response and navigate to error screen if it's forbidden
                  if (_inventaireController.responseCode == 403) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForbiddenScreen()),
                    );
                  }
                  else{

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListeInventairesScreen()),
                    );
                  }
                },
              ),

            ]
          ],
        ),
      ),
    );
  }
}