import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/UserSoc.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesNonCloturesScreen.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChoisirSocieteScreen extends StatefulWidget {
  @override
  State<ChoisirSocieteScreen> createState() => _ChoisirSocieteScreen();
}
class _ChoisirSocieteScreen extends State<ChoisirSocieteScreen> {
  final InventaireController _inventaireController = InventaireController();
  final AuthController _authController = AuthController();
  List<UserSoc> _societes = [];
  bool _isLoading = false;
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    _fetchSocietes();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        prefs = value;
      });
    });

  }
  _fetchSocietes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<UserSoc> societes = await _inventaireController.fetchUserSocs();
      setState(() {
        _isLoading = false;
        _societes = societes;
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
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text("Choisir une société"),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _societes.length,
          itemBuilder: (context, index) {
            UserSoc article = _societes[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, // set the box color to white
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[700], // set the circle color to dark grey
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(
                      Icons.home_work_sharp, // replace with the building icon or any other icon you want
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      article.societe,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16.0,
                    ),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[700],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          String soc = article.societe; // or use your own logic to get the selected 'soc' value
                          try {
                            await _authController.choisirSociete(soc);
                            await prefs.setString('soc', soc);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListeInventairesNonCloturesScreen(),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            // handle error response here
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );


  }
}

