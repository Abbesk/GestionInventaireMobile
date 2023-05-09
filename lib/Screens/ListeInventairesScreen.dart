
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/Inventaire.dart';
import 'package:inventaire_mobile/Screens/AfficherLignesInventaire.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesNonCloturesScreen.dart';
import 'package:inventaire_mobile/Screens/AuthentifierScreen.dart';
import 'package:inventaire_mobile/Screens/choisirSocieteScreen.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'CreateInventaireScreen.dart';
class ListeInventairesScreen extends StatefulWidget {
  @override
  State<ListeInventairesScreen> createState() => _ListeInventairesScreenState();
}

class _ListeInventairesScreenState extends State<ListeInventairesScreen> {

  final InventaireController _inventaireController = InventaireController();
  final AuthController _authController= AuthController() ;
  List<Inventaire> _inventaires = [];
  late Inventaire i1 ;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchInvs();

  }

  _fetchInvs() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final List<Inventaire> inventaires = await _inventaireController.fetchInventaires();
      final List<Inventaire> filteredInventaires = inventaires.where((inventaire) => inventaire.cloture == "1").toList();
      setState(() {
        _isLoading = false;
        _inventaires = filteredInventaires;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          "Liste des inventaires clôturés",
          style: TextStyle(fontSize: 14),
        ),
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


      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _inventaires.length,
        itemBuilder: (context, index) {
          Inventaire i = _inventaires[index];
          bool isClotured=true;
          if(i.cloture == "0"){
            isClotured=false;
          }

          return ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // aligns children to the start of the row
              children: [
                Expanded(child: Text("Num")),
                SizedBox(width: 5),
                Expanded(child: Text("Date")),
                SizedBox(width: 5),
                Expanded(child: Text("PV")),
                SizedBox(width: 5),
                Expanded(child: Text("Depôt")),
              ],
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // aligns children to the start of the row
              children: [
                Expanded(child: Text(i.numinv!)),
                Expanded(
                  child: Text(
                    DateFormat('dd/MM/yy').format(DateTime.parse(i.dateinv!)),
                  ),
                ),

                Expanded(child: Text(i.libpv!)),
                Expanded(child: Text(i.libdep!)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: isClotured,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AfficherLignesInventaireScreen(inventaire: i),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text('Footer'),
        ),
      ),
    );



  }
}

