
import 'LigneInventaire.dart';
import 'PointVente.dart';

class Inventaire {
  Inventaire({
    required this.pointVente,
    required this.lignesInventaire,
    required this.depot,
    required this.numinv,
    required this.dateinv,
    required this.nbrcomptage,
    required this.commentaire,
    required this.cloture,
    required this.datecloture,
    required this.utilisateur,

    required this.DATEDMAJ,
    required this.codepv,
    required this.libpv,
    required this.codedep,
    required this.libdep,
    this.numcloture,
    this.dateimp,
    this.typdec,
    this.declaration,
    this.typeapp,
    this.zone,
  });
  late final PointVente pointVente;
  late final List<LigneInventaire> lignesInventaire;
  late final Depot depot;
  late final String numinv;
  late final String dateinv;
  late final int nbrcomptage;
  late final String commentaire;
  late final String cloture;
  late final String datecloture;
  late final String utilisateur;

  late final String DATEDMAJ;
  late final String codepv;
  late final String libpv;
  late final String codedep;
  late final String libdep;
  late final Null numcloture;
  late final Null dateimp;
  late final Null typdec;
  late final Null declaration;
  late final Null typeapp;
  late final Null zone;

  Inventaire.fromJson(Map<String, dynamic> json){
    pointVente = PointVente.fromJson(json['PointVente']);
    lignesInventaire = List.from(json['LignesInventaire']).map((e)=>LigneInventaire.fromJson(e)).toList();
    depot = Depot.fromJson(json['Depot']);
    numinv = json['numinv'];
    dateinv = json['dateinv'];
    nbrcomptage = json['nbrcomptage'];
    commentaire = json['commentaire'];
    cloture = json['cloture'];
    datecloture = json['datecloture'];
    utilisateur = json['utilisateur'];

    DATEDMAJ = json['DATEDMAJ'];
    codepv = json['codepv'];
    libpv = json['libpv'];
    codedep = json['codedep'];
    libdep = json['libdep'];
    numcloture = null;
    dateimp = null;
    typdec = null;
    declaration = null;
    typeapp = null;
    zone = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PointVente'] = pointVente.toJson();
    _data['LignesInventaire'] = lignesInventaire.map((e)=>e.toJson()).toList();
    _data['Depot'] = depot.toJson();
    _data['numinv'] = numinv;
    _data['dateinv'] = dateinv;
    _data['nbrcomptage'] = nbrcomptage;
    _data['commentaire'] = commentaire;
    _data['cloture'] = cloture;
    _data['datecloture'] = datecloture;
    _data['utilisateur'] = utilisateur;

    _data['DATEDMAJ'] = DATEDMAJ;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    _data['codedep'] = codedep;
    _data['libdep'] = libdep;
    _data['numcloture'] = numcloture;
    _data['dateimp'] = dateimp;
    _data['typdec'] = typdec;
    _data['declaration'] = declaration;
    _data['typeapp'] = typeapp;
    _data['zone'] = zone;
    return _data;
  }
}