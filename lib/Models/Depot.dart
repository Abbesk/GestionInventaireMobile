import 'LigneDepot.dart';

class Depot {
  Depot({
    required this.tmp_LignesDepot,
    required this.lignesDepot,
    required this.InventaireCourant,
    required this.Code,
    required this.Libelle,
    this.Adresse,
    this.Responsable,
    this.Datec,
    this.TEL,
    this.FAX,
    this.EMAIL,
    this.TYPED,
    required this.codepv,
    this.libpv,
    required this.inactif,
    required this.sel,
    required this.SAISIQTENEG,
  });
  late final List<dynamic> tmp_LignesDepot;
  late final List<LigneDepot> lignesDepot;
  late final List<dynamic> InventaireCourant;
  late final String Code;
  late final String Libelle;
  late final Null Adresse;
  late final Null Responsable;
  late final String? Datec;
  late final Null TEL;
  late final Null FAX;
  late final Null EMAIL;
  late final String? TYPED;
  late final String codepv;
  late final String? libpv;
  late final String inactif;
  late final int sel;
  late final String SAISIQTENEG;

  Depot.fromJson(Map<String, dynamic> json){
    tmp_LignesDepot = List.castFrom<dynamic, dynamic>(json['TMPLignesDepot']);
    lignesDepot = List.from(json['LignesDepot']).map((e)=>LigneDepot.fromJson(e)).toList();
    InventaireCourant = List.castFrom<dynamic, dynamic>(json['InventaireCourant']);
    Code = json['Code'];
    Libelle = json['Libelle'];
    Adresse = null;
    Responsable = null;
    Datec = null;
    TEL = null;
    FAX = null;
    EMAIL = null;
    TYPED = null;
    codepv = json['codepv'];
    libpv = null;
    inactif = json['inactif'];
    sel = json['sel'];
    SAISIQTENEG = json['SAISIQTENEG'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['TMPLignesDepot'] = tmp_LignesDepot;
    _data['LignesDepot'] = lignesDepot.map((e)=>e.toJson()).toList();
    _data['InventaireCourant'] = InventaireCourant;
    _data['Code'] = Code;
    _data['Libelle'] = Libelle;
    _data['Adresse'] = Adresse;
    _data['Responsable'] = Responsable;
    _data['Datec'] = Datec;
    _data['TEL'] = TEL;
    _data['FAX'] = FAX;
    _data['EMAIL'] = EMAIL;
    _data['TYPED'] = TYPED;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    _data['inactif'] = inactif;
    _data['sel'] = sel;
    _data['SAISIQTENEG'] = SAISIQTENEG;
    return _data;
  }
}
