import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/Depot.dart';
import 'package:inventaire_mobile/Models/UserPV.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/AuthController.dart';
import '../Models/Inventaire.dart';
import '../Models/PointVente.dart';
import 'ListeInventairesNonCloturesScreen.dart';
import 'AuthentifierScreen.dart';
import 'choisirSocieteScreen.dart';

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
  List<UserPV> _pvs = [];
  UserPV? _selectedPV;
  Depot? _selectedDep ;
  bool _isLoading = true;
  Future<String?> _getUserSoc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? societe=  prefs.getString('soc');
    return societe;}

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
      _deps = _deps.where((dep) => dep.codepv == _selectedPV?.codepv).toList();
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
        title: Text("Nouveau inventaire"),
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
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey[900], // Set the background color
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    FutureBuilder<String?>(
                      future: _getUserSoc(),
                      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          String? soc = snapshot.data;
                          return Text(
                            'Inventaire pour la société $soc',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return Text('Erreur lors de la récupération de la société');
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/2682/2682065.png',
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.list,
                      color: Colors.blueGrey[900],
                      size: 12.0,
                    ),
                  ),
                ),
                title: Text(
                  'Liste des inventaires clôturés',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to the main page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListeInventairesScreen()),);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.list_alt,
                  color: Colors.white,
                ),
                title: Text(
                  'Liste des inventaires non clôturés',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to the cancelled orders page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListeInventairesNonCloturesScreen()),);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                title: Text(
                  'Créer un inventaire',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to the validated orders page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateInventaireScreen()),);
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.account_balance_sharp,
                  color: Colors.white,
                ),
                title: Text(
                  'Choisir société',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to the cancelled orders page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChoisirSocieteScreen()),);
                },
              ),

            ],
          ),
        ),
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
                    child: DropdownButton<UserPV>(
                      isExpanded: true,
                      value: _selectedPV,
                      onChanged: (UserPV? newValue) {
                        setState(() {
                          _selectedPV = newValue;
                          // Reset the selected depot when the point of sale changes
                          _deps = _deps.where((dep) => dep.codepv == _selectedPV?.codepv).toList();

                        });
                      },
                      items: [
                        DropdownMenuItem<UserPV>(
                          value: null,
                          child: Text('Choisir point de vente'),
                        ),
                        ..._pvs.map<DropdownMenuItem<UserPV>>((UserPV pv) {
                          return DropdownMenuItem<UserPV>(
                            value: pv,
                            child: Text(pv.libpv!),
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
                          .where((dep) => dep.codepv == _selectedPV?.codepv)
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
                      codepv: _selectedPV?.codepv,
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
                        MaterialPageRoute(builder: (context) => ListeInventairesNonCloturesScreen()),
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