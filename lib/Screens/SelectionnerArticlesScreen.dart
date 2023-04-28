
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Models/Depot.dart';
import 'package:inventaire_mobile/Screens/CreateInventaireScreen.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Models/Inventaire.dart';
import 'package:inventaire_mobile/Models/LigneDepot.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Screens/themes/theme_model.dart';
import 'package:provider/provider.dart';
import 'ListeInventairesNonCloturesScreen.dart';
import 'AuthentifierScreen.dart';
import 'choisirSocieteScreen.dart';

class SelectionnerArticleScreen extends StatefulWidget {
  final Inventaire inventaire;

  SelectionnerArticleScreen({required this.inventaire});

  @override
  _SelectionnerArticleScreenState createState() => _SelectionnerArticleScreenState();
}

class _SelectionnerArticleScreenState extends State<SelectionnerArticleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InventaireController _inventaireRepository = InventaireController();
  final _countController = TextEditingController();
  late List<LigneDepot> _lignesdepot;
  String? _numinv;
  String? _codepv;
  String? _codedep;
  String? _libpv;
  String? _libdep;
  String? _dateinv;
  late List<LigneDepot> _filteredLignesDepot;
  late List<bool> _checkboxStates;
  int selectedLineCount = 0;
  AuthController _authController = AuthController();
  Future<String?> scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000',
        'Cancel',
        true,
        ScanMode.BARCODE
    );
    if (barcode != null) {
      LigneDepot? matchingLigne = _filteredLignesDepot.firstWhere(
            (ligne) => ligne.libelle == barcode,

      );
      if (matchingLigne != null) {
        if (matchingLigne.isSelected == 1) {
          await _showAlreadySelectedDialog(matchingLigne);
        } else {
          await _confirmSelection(matchingLigne);
        }
      }
    }

    return barcode;
  }
  Future<void> _showAlreadySelectedDialog(LigneDepot ligne) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('L article ${ligne.codeart} est déjà sélectionné '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous le conserver?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Conserver'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eleminer'),
              onPressed: () {
                setState(() {
                  ligne.isSelected = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmSelection(LigneDepot ligne) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Voulez vous ajouter cet article'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous'),
                Text('${ligne.libelle}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Oui'),
              onPressed: () {
                setState(() {
                  ligne.isSelected = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    _inventaireRepository.fetchInventaires();
    _countController.text = (widget.inventaire.depot?.lignesDepot?.length).toString();
    _numinv = widget.inventaire.numinv;
    _codepv = widget.inventaire.codepv;
    _codedep = widget.inventaire.codedep;
    _libdep =widget.inventaire.libdep;
    _libpv = widget.inventaire.libpv;
    _filteredLignesDepot =widget.inventaire.depot?.lignesDepot ?? [];
    _lignesdepot = widget.inventaire.depot?.lignesDepot ?? [];
    _dateinv= widget.inventaire.dateinv.toString();

    for (var ligne in _lignesdepot) {

      if (ligne.isSelected==1) {
        selectedLineCount++ ;
      }
    }
    _checkboxStates = List.filled(_filteredLignesDepot.length, false);
  }
  int getNumChecked() {
    // Count how many checkboxes are checked
    return _checkboxStates.where((state) => state).length;
  }
  void _updateLignesDepot(int index, bool value) {
    setState(() {
      _lignesdepot[index].isSelected = value ? 1 : 0;
      _filteredLignesDepot[index].isSelected = value ? 1 : 0;
      _checkboxStates[index] = value;
    });
  }
  int updateNombreSelectionne (){
    int countligne=0 ;
    for (var ligne in _lignesdepot) {
      if (ligne.isSelected==1) {
        countligne++;
      }
    }
    return countligne ;
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
            lignesDepot: _lignesdepot,
          ),
        );
        await _inventaireRepository.selectionnerArticles(
          widget.inventaire.numinv!,
          inventaire,
        );
        // Navigate to InventaireListScreen after successful form submission
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListeInventairesScreen(),
          ),
        );
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
            MaterialButton(
              child: Text('Scan Barcode'),
              onPressed: () async {
                String? barcode = await scanBarcode();
              },
            ),
            SizedBox(height: 16.0),

    // Liste des articles Text
              Center(
                child: Text(
                  'Liste des articles',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // DataTable to display depot lines
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 1,
                      dataTextStyle: TextStyle(fontSize: 16.0),
                      columns: [
                        DataColumn(label: Text('Famille')),
                        DataColumn(label: Text('Code Article')),
                        DataColumn(label: Text('Désignation Article')),
                        DataColumn(label: Text('Quantité')),

                        DataColumn(label: Text('')),
                      ],
                      rows: List<DataRow>.generate(
                        _filteredLignesDepot.length,
                            (index) {
                          final ligne = _lignesdepot[index];

                          return DataRow(
                            cells: [
                              DataCell(Text(ligne.famille!)),
                              DataCell(Text(ligne.codeart)),
                              DataCell(Text(ligne.desart)),
                              DataCell(Text(ligne.qteart.toString())),
                              DataCell(
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Checkbox(
                                      value: ligne.isSelected == 1,
                                      onChanged: (value) {
                                        _updateLignesDepot(index, value!);
                                        updateNombreSelectionne();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nombre de lignes sélectionnées: ${updateNombreSelectionne()}'), ],
              ),



              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListeInventairesNonCloturesScreen(),
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
    ),);
  }
}
