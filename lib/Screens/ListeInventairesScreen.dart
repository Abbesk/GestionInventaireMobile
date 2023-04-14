
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/Inventaire.dart';
import 'package:inventaire_mobile/Screens/AfficherLignesInventaire.dart';
import 'package:inventaire_mobile/Screens/CloturerInventaireScreen.dart';
import 'package:inventaire_mobile/Screens/SelectionnerArticlesScreen.dart';
import 'package:inventaire_mobile/Screens/ComptagePhysiqueScreen.dart';
import 'package:inventaire_mobile/Screens/LoginScreen.dart';
import 'package:inventaire_mobile/Screens/aa.dart';
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
      final List<Inventaire> inventaires = await _inventaireController.fetchInventaires() ;
      setState(() {
        _isLoading = false;
        _inventaires = inventaires;
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
        title: Text("Liste des inventaires"),
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
                      'Historique',
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
                      Icons.home_filled,
                      color: Colors.blueGrey[900],
                      size: 12.0,
                    ),
                  ),
                ),
                title: Text(
                  'Page principale',
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
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  'Commandes validées',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to the validated orders page
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
                  'Commandes annulées',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to the cancelled orders page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListeInventairesScreen()),);
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
          bool isClotured = i.cloture == 1;
          return ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // aligns children to the start of the row
              children: [
                Expanded(child: Text("Numéro")),
                Expanded(child: Text("Date")),
                Expanded(child: Text("P_Vente")),
                Expanded(child: Text("Depot")),
              ],
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // aligns children to the start of the row
              children: [
                Expanded(child: Text(i.numinv!)),
                Expanded(child: Text(i.dateinv.toString()!)),
                Expanded(child: Text(i.libpv!)),
                Expanded(child: Text(i.libdep!)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: !isClotured,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      i1 = await _inventaireController.getInventaireById(i.numinv!) as Inventaire;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectionnerArticleScreen(inventaire: i1),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: isClotured,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComptagePhysiqueScreen(inventaire: i),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: isClotured,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CloturerInventaireScreen(inventaire: i),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: !isClotured,
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
    );
  }
}

