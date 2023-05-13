import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Models/LigneInventaire.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';
import '../Models/Inventaire.dart';
import 'CreateInventaireScreen.dart';
import 'ListeInventairesNonCloturesScreen.dart';
import 'AuthentifierScreen.dart';
import 'choisirSocieteScreen.dart';
class AfficherLignesInventaireScreen extends StatefulWidget {
  final Inventaire inventaire;

  AfficherLignesInventaireScreen({required this.inventaire});

  @override
  _AfficherLignesInventaireScreenState createState() => _AfficherLignesInventaireScreenState();
}
class _AfficherLignesInventaireScreenState extends State<AfficherLignesInventaireScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<LigneInventaire> _lignesInventaire;
  String? _numinv;
  String? _libpv;
  String? _libdep;
  String? _datecloture;
  String? _dateinv;

AuthController _authController = AuthController();
  @override
  void initState()  {
    super.initState();
    _numinv = widget.inventaire.numinv;
    _libdep=widget.inventaire.libdep;
    _libpv=widget.inventaire.libpv;
    _lignesInventaire = (widget.inventaire.lignesInventaire ?? []) as List<LigneInventaire>;
    _dateinv = widget.inventaire.dateinv.toString();
    _datecloture= widget.inventaire.datecloture.toString();
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
              _authController.logout();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );// call the logout function and pass in the BuildContext of the current screen
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
                      'inventaire',
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
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              letterSpacing: 2,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            _numinv!,
                            style: TextStyle(
                              fontSize: 14,
                                fontFamily: 'Montserrat',
                              letterSpacing: 2,
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
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              letterSpacing: 2,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(DateTime.parse(_dateinv!)),
                            style: TextStyle(
                              fontSize: 14,
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
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              letterSpacing: 2,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            _libpv!,
                            style: TextStyle(
                              fontSize: 14,
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
                            'Date de clôture',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              letterSpacing: 2,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(DateTime.parse(_datecloture!)),
                            style: TextStyle(
                              fontSize: 14,
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dépôt',
                      style: TextStyle(
                        fontSize: 14,
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
                        fontSize: 14,
                        fontFamily: 'Open Sans',
                        color: Colors.grey[650],
                        height: 1.5,
                      ),
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
                        DataColumn(label: Text('Code article ')),
                        DataColumn(label: Text('Libellé ')),
                        DataColumn(label: Text('Qte en stock')),
                        DataColumn(label: Text('Ecart')),
                      ],
                      rows: _lignesInventaire.map(
                            (ligne) => DataRow(
                          cells: [
                            DataCell(Text(ligne.famille)),
                            DataCell(Text(ligne.codeart)),
                            DataCell(Text(ligne.desart)),
                            DataCell(Text(ligne.qtes.toString())),
                            DataCell(Text(ligne.ecartinv.toString())),
                          ],
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}
