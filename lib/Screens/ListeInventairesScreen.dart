
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/Inventaire.dart';
import 'package:inventaire_mobile/Screens/AfficherLignesInventaire.dart';
import 'package:inventaire_mobile/Screens/CloturerInventaireScreen.dart';
import 'package:inventaire_mobile/Screens/SelectionnerArticlesScreen.dart';
import 'package:inventaire_mobile/Screens/ComptagePhysiqueScreen.dart';
import 'package:inventaire_mobile/Screens/LoginScreen.dart';
class ListeInventairesScreen extends StatefulWidget {
  @override
  State<ListeInventairesScreen> createState() => _ListeInventairesScreenState();
}

class _ListeInventairesScreenState extends State<ListeInventairesScreen> {
  final InventaireController _inventaireController = InventaireController();
  List<Inventaire> _inventaires = [];
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
          title: Text("Liste des inventaires"),
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Row(
          children: [
            Expanded(
              child: Container(
                //width: 500,
                child: ListView.builder(
                  itemCount: _inventaires.length,
                  itemBuilder: (context, index) {
                    Inventaire i = _inventaires[index];
                    bool isClotured = i.cloture == 1;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Expanded(child: Text("Numéro")),
                              Expanded(child: Text("Date")),
                              Expanded(child: Text("P_Vente")),
                              Expanded(child: Text("Depot")),
                            ],
                          ),
                          subtitle: Row(
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
                                visible: isClotured,
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectionnerArticleScreen(inventaire: i),
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
                        ),
                      ],
                    );
                  },
                ),

              ),
            ),
          ],
        ),



    );
  }
}

