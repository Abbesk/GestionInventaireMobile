import 'package:inventaire_mobile/Models/TMPLigneDepot.dart';

import 'LigneDepot.dart';

class Depot {
  Depot({
     this.tmp_LignesDepot,
     this.lignesDepot,

     required this.Code,
     this.Libelle,

    this.Datec,

    this.TYPED,
    required this.codepv,
    this.libpv,
     this.inactif,

     this.SAISIQTENEG,
  });
    List<TMPLigneDepot>? tmp_LignesDepot;
    List<LigneDepot>? lignesDepot;
   late String? Code;
   String? Libelle;

   String? Datec;

   String? TYPED;
   String? codepv;
   String? libpv;
   String? inactif;

   String? SAISIQTENEG;

  Depot.fromJson(Map<String, dynamic> json){
    tmp_LignesDepot = List.from(json['TMPLignesDepot']).map((e)=>TMPLigneDepot.fromJson(e)).toList();

    lignesDepot = List.from(json['LignesDepot']).map((e)=>LigneDepot.fromJson(e)).toList();
    Code = json['Code'];
    Libelle = json['Libelle'];

    TYPED = null;
    codepv = json['codepv'];
    libpv = null;
    inactif = json['inactif'];

    SAISIQTENEG = json['SAISIQTENEG'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['TMPLignesDepot'] = tmp_LignesDepot?.map((e)=>e.toJson()).toList();

    _data['LignesDepot'] = lignesDepot?.map((e)=>e.toJson()).toList();

    _data['Code'] = Code;
    _data['Libelle'] = Libelle;

    _data['Datec'] = Datec;

    _data['TYPED'] = TYPED;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    _data['inactif'] = inactif;

    _data['SAISIQTENEG'] = SAISIQTENEG;
    return _data;
  }
}