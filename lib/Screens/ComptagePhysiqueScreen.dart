
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


import '../Models/Depot.dart';
import '../Models/Inventaire.dart';
import '../Models/TMPLigneDepot.dart';
import 'CreateInventaireScreen.dart';
import 'ListeInventairesNonCloturesScreen.dart';
import 'aa.dart';
import 'choisirSocieteScreen.dart';



class ComptagePhysiqueScreen extends StatefulWidget {
  final Inventaire inventaire;

  ComptagePhysiqueScreen({required this.inventaire});

  @override
  _ComptagePhysiqueScreenState createState() => _ComptagePhysiqueScreenState();
}

class _ComptagePhysiqueScreenState extends State<ComptagePhysiqueScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InventaireController _inventaireRepository = InventaireController();
  late List<TMPLigneDepot> _tmpLignesDepot;
  String? _numinv;
  String? _codepv;
  String? _codedep;
  String? _libdep ;
  String? _libpv ;
AuthController _authController = AuthController();
  @override
  void initState() {
    super.initState();
    _numinv = widget.inventaire.numinv;
    _codepv = widget.inventaire.codepv;
    _codedep = widget.inventaire.codedep;
    _libpv=widget.inventaire.libpv;
    _libdep= widget.inventaire.libdep;
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
        await _inventaireRepository.SaisiComptage(
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
        title: Text("Inventaire "+_numinv.toString()),
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

                icon: Icon(themeNotifier.isDark ? Icons.nightlight_round : Icons.wb_sunny,
                  color: themeNotifier.isDark ? Colors.white : Colors.white,
                ),
                onPressed: () {
                  themeNotifier.isDark = !themeNotifier.isDark;
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
                    Text(
                      'Inventaire',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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

      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Numéro Inventaire',
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       Center(
          //         child: TextField(
          //           textAlign: TextAlign.center,
          //           controller: _numinvController,
          //           enabled: false,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Numéro inventaire',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          letterSpacing: 2,
                          height: 1.5,
                          // add some padding
                        ),
                      ),
                      Text(
                        _numinv!,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Open Sans',
                          color: Colors.grey[400],
                          height: 1.5,
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
                        'Point de vente ',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          letterSpacing: 2,
                          height: 1.5,
                          // add some padding
                        ),
                      ),
                      Text(
                        _libpv!,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Open Sans',
                          color: Colors.grey[400],
                          height: 1.5,
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
                        'Dépôt',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          letterSpacing: 2,
                          height: 1.5,
                          // add some padding
                        ),
                      ),
                      Text(
                        _libdep!,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Open Sans',
                          color: Colors.grey[400],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),


// Texte "Lignes de dépôt"
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      dataRowHeight: 50.0, // Adjust the height of each row
                      headingRowHeight: 60.0, // Adjust the height of the heading row
                      columns: [
                        DataColumn(
                          label: Text(
                            'Famille',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Code Article',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Désignation',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Quantitée physique',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Justification',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: _tmpLignesDepot.map((ligne) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                ligne.famille!,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            DataCell(
                              Text(
                                ligne.codeart!,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            DataCell(
                              Text(
                                ligne.desart!,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            DataCell(
                              TextFormField(
                                initialValue: ligne.qteInventaire.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == null || value.isEmpty) {
                                      ligne.qteInventaire = 0;
                                    } else {
                                      double parsedValue = double.tryParse(value)!;
                                      if (parsedValue != null && parsedValue > 0) {
                                        ligne.qteInventaire = parsedValue;
                                      } else {
                                        ligne.qteInventaire = 0;
                                      }
                                    }
                                  });
                                },
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            DataCell(
                              TextFormField(
                                initialValue: ligne.commentaire,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ligne.commentaire = value;
                                  });
                                },
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
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
      ),
    );
  }
}
