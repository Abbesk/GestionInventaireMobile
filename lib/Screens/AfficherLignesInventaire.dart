
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/LigneInventaire.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';



import '../Models/Inventaire.dart';
import 'CreateInventaireScreen.dart';
import 'ListeInventairesNonCloturesScreen.dart';
import 'aa.dart';
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
  String? _codepv;
  String? _codedep;
AuthController _authController = AuthController();
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
                      Icons.add,
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
                  Icons.cancel_outlined,
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
                  Icons.check_circle_outline_rounded,
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
                  Icons.cancel_outlined,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Container(
            alignment: Alignment.center,
            child: TextFormField(
              initialValue: _numinv,
              enabled: false,
              decoration: InputDecoration(labelText: 'Numéro inventaire'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Numéro Inventaire';
                }
                return null;
              },
            ),
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
                      DataColumn(label: Text('Lib')),
                      DataColumn(label: Text('Qte_S')),
                      DataColumn(label: Text('Ecart')),
                    ],
                    rows: _lignesInventaire.map(
                          (ligne) => DataRow(
                        cells: [
                          DataCell(Text(ligne.famille!)),
                          DataCell(Text(ligne.codeart!)),
                          DataCell(Text(ligne.desart!)),
                          DataCell(Text(ligne.qtes.toString()!)),
                          DataCell(Text(ligne.ecartinv.toString()!)),

                        ],
                      ),
                    ).toList(),
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
