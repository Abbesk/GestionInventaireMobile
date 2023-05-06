
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
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
import 'AuthentifierScreen.dart';
import 'choisirSocieteScreen.dart';
import 'package:get/get.dart';



class ComptagePhysiqueScreen extends StatefulWidget {
  final  Inventaire inventaire;

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
  String? _libdep;

  String? _libpv;

  String? _dateinv;


  AuthController _authController = AuthController();


  @override
  void initState() {
    _tmpLignesDepot =widget.inventaire.depot?.tmp_LignesDepot ?? [];
    super.initState();
    _numinv = widget.inventaire.numinv;
    _codepv = widget.inventaire.codepv;
    _codedep = widget.inventaire.codedep;
    _libpv=widget.inventaire.libpv;
    _libdep= widget.inventaire.libdep;

    _dateinv= widget.inventaire.dateinv.toString();


  }
  void updateQuantity(TMPLigneDepot ligne, double newQuantity) {
    setState(() {
      _tmpLignesDepot[_tmpLignesDepot.indexOf(ligne)].qteInventaire = newQuantity;

    });
  }
  void updateCommentaire(TMPLigneDepot ligne, String commentaire) {
    setState(() {
      _tmpLignesDepot[_tmpLignesDepot.indexOf(ligne)].commentaire = commentaire;

    });
  }
  Future<String?> scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000',
        'Cancel',
        true,
        ScanMode.BARCODE
    );

    if (barcode != null) {
      TMPLigneDepot? matchingLigne = _tmpLignesDepot.firstWhere(
            (ligne) => ligne.libelle == barcode,

      );

      if (matchingLigne == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'Aucun article n\'est trouvé pour le code à barre scanné'),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        bool isNewQuantity = true; // Default choice
        TextEditingController quantityController = TextEditingController(
          text: matchingLigne.qteInventaire.toString(),
        );
        TextEditingController justificationController = TextEditingController(
          text: matchingLigne.commentaire ?? '',
        ); // Initialize with matchingLigne's commentaire if available
        bool isValidQuantity = false;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Actualiser la ligne'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile(
                        title: Text('Donner une nouvelle quantité'),
                        value: true,
                        groupValue: isNewQuantity,
                        onChanged: (value) {
                          setState(() {
                            isNewQuantity = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Modifier la justification'),
                        value: false,
                        groupValue: isNewQuantity,
                        onChanged: (value) {
                          setState(() {
                            isNewQuantity = value!;
                          });
                        },
                      ),
                      if (isNewQuantity)
                        TextField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Quantité',
                            errorText: isValidQuantity
                                ? null
                                : 'Entrez un entier >=0',
                          ),
                          onChanged: (value) {
                            setState(() {
                              isValidQuantity =
                                  double.tryParse(value) != null &&
                                      double.parse(value) >= 0;
                            });
                          },
                        ),
                      if (!isNewQuantity)
                        TextField(
                          controller: justificationController,
                          decoration: InputDecoration(
                            labelText: 'Justification',
                          ),
                          maxLines: null,
                        ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Annuler'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Valider'),
                      onPressed: isNewQuantity
                          ? (isValidQuantity
                          ? () {
                        updateQuantity(
                          matchingLigne,
                          double.parse(quantityController.text),
                        );
                        matchingLigne.qteInventaire =
                            double.parse(quantityController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ComptagePhysiqueScreen(
                                    inventaire: widget.inventaire),
                          ),
                        );
                      }
                          : null)
                          : () {
                        // Handle justification submission
                        updateCommentaire(
                            matchingLigne, justificationController.text);
                        matchingLigne.commentaire =
                            justificationController.text;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ComptagePhysiqueScreen(
                                    inventaire: widget.inventaire),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            );
          },
        );
      }
    }
  }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[900],
            title: Text("Inventaire " + _numinv.toString()),
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
                  )
                    ..show();
                },
              ),

              Consumer<ThemeModel>(
                builder: (context, themeNotifier, child) {
                  return IconButton(

                    icon: Icon(
                      themeNotifier.isDark ? Icons.nightlight_round : Icons
                          .wb_sunny,
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
                        MaterialPageRoute(
                            builder: (context) => ListeInventairesScreen()),);
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
                        MaterialPageRoute(builder: (context) =>
                            ListeInventairesNonCloturesScreen()),);
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
                        MaterialPageRoute(
                            builder: (context) => CreateInventaireScreen()),);
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
                        MaterialPageRoute(
                            builder: (context) => ChoisirSocieteScreen()),);
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
                                DateFormat('dd/MM/yy').format(
                                    DateTime.parse(_dateinv!)),
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
                                _codepv! + "-" + _libpv!,
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
                                _codedep! + "-" + _libdep!,
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
                    Container(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code),
                            SizedBox(width: 8.0),
                            Text('Scanner code à barre'),
                          ],
                        ),
                        onPressed: () async {
                          String? barcode = await scanBarcode();
                        },
                      ),
                    )
                    ,


                    SizedBox(height: 16.0),
                    Center(
                      child: Text(
                        'Saisir les quantités pour les articles',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                dataRowHeight: 50.0,
                                headingRowHeight: 60.0,
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
                                      'Code article',
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
                                      'Quantité physique',
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
                                        StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return TextFormField(
                                              initialValue: ligne.qteInventaire
                                                  .toString(),
                                              keyboardType: TextInputType
                                                  .number,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  print(
                                                      'kaaaaaaaaaaaaaariiiiiiiim');
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    ligne.qteInventaire = 0;
                                                  } else {
                                                    double parsedValue = double
                                                        .tryParse(value) ?? 0;
                                                    ligne.qteInventaire =
                                                    (parsedValue >= 0
                                                        ? parsedValue
                                                        : 0) as double?;
                                                  }
                                                });
                                              },
                                              style: TextStyle(fontSize: 14.0),
                                            );
                                          },
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
                        );
                      },
                    ),

                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.bottomSlide,
                          title: 'Confirmation',
                          desc: 'Voulez-vous vraiment enregistrer les modifications ?',
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
                              await _inventaireRepository.SaisiComptage(
                                widget.inventaire.numinv!,
                                inventaire,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ListeInventairesNonCloturesScreen(),
                                ),
                              );
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.bottomSlide,
                                title: 'Succès',
                                desc: 'Les modifications sont enregistrées  avec succès',
                                btnOkText: 'OK',
                                btnOkOnPress: () {},
                              ).show();
                            } catch (e) {
                              print(e);
                            }
                          },
                        ).show();
                      },
                      child: Text('Enregistrer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[900],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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



