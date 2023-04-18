import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/Depot.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';

import '../Controllers/AuthController.dart';
import '../Models/Inventaire.dart';
import '../Models/PointVente.dart';
import 'aa.dart';

class CreateInventaireScreen extends StatefulWidget {
  @override
  _CreateInventaireScreenState createState() => _CreateInventaireScreenState();
}

class _CreateInventaireScreenState extends State<CreateInventaireScreen> {
  final AuthController _authController= AuthController() ;

  final InventaireController _inventaireController = InventaireController();
  final TextEditingController _numinvController = TextEditingController();
  final TextEditingController _dateinvController = TextEditingController();
  final TextEditingController _nbrcomptageController = TextEditingController(
      text: '1');
  final TextEditingController _commentaireController = TextEditingController(
      text: 'Inventaire Physique');
  final TextEditingController _codedepController = TextEditingController();
late  bool theme_d ;

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
    final themeNotifier = Provider.of<ThemeModel>(context, listen: false);
    theme_d = !themeNotifier.isDark;
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
      _dateinvController.text = DateTime.now().toString();

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
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text("Créer un nouveau inventaire"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.bottomSlide,
                title: 'Confirm Logout',
                desc: 'Are you sure you want to log out?',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  _authController.logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              )..show();
            },
          ),
          Consumer<ThemeModel>(
            builder: (context, themeNotifier, child) {
              return IconButton(
                icon: Icon(
                  themeNotifier.isDark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny,
                  color: Colors.white,
                ),
                onPressed: () {
                  themeNotifier.isDark = !themeNotifier.isDark;
                  setState(() {
                    theme_d = !themeNotifier.isDark;
                  });
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Numéro Inventaire',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _numinvController,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Date de l inventaire:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _dateinvController,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nombre de comptage:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _nbrcomptageController,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Commentaire: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _commentaireController,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: Visibility(
                    visible: _pvs.isNotEmpty,
                    child: DropdownButton<PointVente>(
                      isExpanded: true,
                      value: _selectedPV,
                      onChanged: (PointVente? newValue) {
                        setState(() {
                          _selectedPV = newValue;
                          // Reset the selected depot when the point of sale changes
                          _deps = _deps.where((dep) => dep.codepv == _selectedPV?.Code!).toList();

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
                ),
              ],
            ),
            SizedBox(height: 24.0),

      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [


        Expanded(
              child: Visibility(
                visible: _deps.isNotEmpty,

                  // set a fixed height for the dropdown
                  child: DropdownButton<Depot>(
                    isExpanded: true,
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
            ),
      ],
      ),
            SizedBox(height: 24.0),
            if (_selectedPV != null && _selectedDep != null)... [
              Center(
                child: ElevatedButton(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'Créer',
                        style: TextStyle(
                          color: !theme_d ? Colors.white : Colors.black
                        ),
                      ),
                    ),

                  ),
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                        size: 40.0,
                                      ),
                                      SizedBox(width: 10.0),
                                      Expanded(
                                        child: Text(
                                          "Erreur lors de la création de l'inventaire",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10.0),
                                  Text(
                                    "\nVeuillez vérifier s'il y a déjà un inventaire non clôturé pour le dépôt sélectionné.",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        child: Text(
                                          "Back",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
              )


            ]
          ],
        ),
      ),
    );
  }
}