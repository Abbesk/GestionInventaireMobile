
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Models/Depot.dart';
import '../Models/Inventaire.dart';
import '../Models/TMPLigneDepot.dart';
import 'CreateInventaireScreen.dart';
import 'ListeInventairesNonCloturesScreen.dart';
import 'AuthentifierScreen.dart';
import 'choisirSocieteScreen.dart';



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
  String? _libdep ;
  String? _libpv;
  String? _dateinv;
AuthController _authController = AuthController();
  Future<String?> _getUserSoc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? societe=  prefs.getString('soc');
    return societe;}
  @override
  void initState() {
    super.initState();
    _numinv = widget.inventaire.numinv;
    _codepv = widget.inventaire.codepv;
    _codedep = widget.inventaire.codedep;
    _libdep=widget.inventaire.libdep;
    _libpv=widget.inventaire.libpv;
    _tmpLignesDepot = (widget.inventaire.depot?.tmp_LignesDepot ?? []) as List<TMPLigneDepot>;
    _dateinv= widget.inventaire.dateinv.toString();
  }



  Future<bool> showConfirmDialog() async {
    final result = await AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Confirmation',
      desc: 'Voulez-vous vraiment clôturer l\'inventaire ?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.of(context).pop(true);
      },
    ).show();
    return result ?? false;
  }

  Future<void> showSuccessDialog() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Succès',
      desc: 'L\'inventaire numéro'+_numinv.toString()+ 'a été clôturé avec succès !',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text("Clôturage"),
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

      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'N° Inventaire',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              letterSpacing: 1,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            _numinv!,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Colors.grey[650],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Date de création',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              letterSpacing: 1,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yy').format(DateTime.parse(_dateinv!)),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[650],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Point de vente ',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              letterSpacing: 1,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            _codepv!+"-"+_libpv!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Open Sans',
                              color: Colors.grey[650],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Dépôt',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              letterSpacing: 1,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            _codedep!+"-"+_libdep!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Open Sans',
                              color: Colors.grey[650],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
              ),




              SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.bottomSlide,
                      title: 'Confirmation',
                      desc: 'Voulez-vous vraiment clôturer l\'inventaire ?',
                      btnCancelText: 'Annuler',
                      btnOkText: 'Confirmer',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        try {
                          final inventaire = Inventaire(
                            numinv: _numinv!,
                            codedep: _codedep!,
                            codepv: _codepv!,
                            depot: Depot(
                              Code: _codedep!,
                              codepv: _codepv!,
                              tmp_LignesDepot: _tmpLignesDepot,
                            ),
                          );
                          await _inventaireRepository.CloturerInventaire(
                            widget.inventaire.numinv!,
                            inventaire,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListeInventairesScreen(),
                            ),
                          );
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            title: 'Succès',
                            desc: 'L\'inventaire numéro 1 a été clôturé avec succès.',
                            btnOkText: 'OK',
                            btnOkOnPress: () {},
                          ).show();
                        } catch (e) {
                          print(e);
                        }
                      },
                    ).show();
                  },
                  child: Text('Clôturer'),
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
