import 'Article.dart';

import 'LigneDepot.dart';
import 'PointVente.dart';

class LigneInventaire {
  LigneInventaire({
    required this.article,
    required this.NumInv,
    required this.dateInv,
    required this.codeart,
    required this.desart,
    required this.qtes,
    required this.stockinv,
    required this.ecartinv,
    required this.PUART,
    this.Remise,
    this.frs,
    required this.famille,
    required this.libellefourn,
    this.prixnet,
    this.numbe,
    required this.nordre,
    required this.lieustock,
    this.numordre,
    required this.codedep,
    required this.libdep,
    required this.codepv,
    required this.libpv,
    required this.eecart,
    required this.secart,
    this.dateexp,
    this.stockinvlot,
    required this.nligne,
  });
  late final Article article;
  late final String NumInv;
  late final String dateInv;
  late final String codeart;
  late final String desart;
  late final int qtes;
  late final int stockinv;
  late final int ecartinv;
  late final int PUART;
  late final Null Remise;
  late final Null frs;
  late final String famille;
  late final String libellefourn;
  late final Null prixnet;
  late final Null numbe;
  late final String nordre;
  late final String lieustock;
  late final Null numordre;
  late final String codedep;
  late final String libdep;
  late final String codepv;
  late final String libpv;
  late final int eecart;
  late final int secart;
  late final Null dateexp;
  late final Null stockinvlot;
  late final int nligne;

  LigneInventaire.fromJson(Map<String, dynamic> json){
    article = Article.fromJson(json['Article']);
    NumInv = json['NumInv'];
    dateInv = json['dateInv'];
    codeart = json['codeart'];
    desart = json['desart'];
    qtes = json['qtes'];
    stockinv = json['stockinv'];
    ecartinv = json['ecartinv'];
    PUART = json['PUART'];
    Remise = null;
    frs = null;
    famille = json['famille'];
    libellefourn = json['libellefourn'];
    prixnet = null;
    numbe = null;
    nordre = json['nordre'];
    lieustock = json['lieustock'];
    numordre = null;
    codedep = json['codedep'];
    libdep = json['libdep'];
    codepv = json['codepv'];
    libpv = json['libpv'];
    eecart = json['eecart'];
    secart = json['secart'];
    dateexp = null;
    stockinvlot = null;
    nligne = json['nligne'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Article'] = article.toJson();
    _data['NumInv'] = NumInv;
    _data['dateInv'] = dateInv;
    _data['codeart'] = codeart;
    _data['desart'] = desart;
    _data['qtes'] = qtes;
    _data['stockinv'] = stockinv;
    _data['ecartinv'] = ecartinv;
    _data['PUART'] = PUART;
    _data['Remise'] = Remise;
    _data['frs'] = frs;
    _data['famille'] = famille;
    _data['libellefourn'] = libellefourn;
    _data['prixnet'] = prixnet;
    _data['numbe'] = numbe;
    _data['nordre'] = nordre;
    _data['lieustock'] = lieustock;
    _data['numordre'] = numordre;
    _data['codedep'] = codedep;
    _data['libdep'] = libdep;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    _data['eecart'] = eecart;
    _data['secart'] = secart;
    _data['dateexp'] = dateexp;
    _data['stockinvlot'] = stockinvlot;
    _data['nligne'] = nligne;
    return _data;
  }
}

class Depot {
  Depot({
    required this.pointVente,
    required this.tmp_LignesDepot,
    required this.LignesDepot,
    required this.InventaireCourant,
    required this.Code,
    required this.Libelle,
    this.Adresse,
    this.Responsable,
    this.Datec,
    this.TEL,
    this.FAX,
    this.EMAIL,
    required this.TYPED,
    required this.codepv,
    required this.libpv,
    required this.inactif,
    required this.sel,
    required this.SAISIQTENEG,
  });
  late final PointVente pointVente;
  late final List<dynamic> tmp_LignesDepot;
  late final List<LigneDepot> LignesDepot;
  late final List<dynamic> InventaireCourant;
  late final String Code;
  late final String Libelle;
  late final Null Adresse;
  late final Null Responsable;
  late final Null Datec;
  late final Null TEL;
  late final Null FAX;
  late final Null EMAIL;
  late final String TYPED;
  late final String codepv;
  late final String libpv;
  late final String inactif;
  late final int sel;
  late final String SAISIQTENEG;

  Depot.fromJson(Map<String, dynamic> json){
    pointVente = PointVente.fromJson(json['PointVente']);
    tmp_LignesDepot = List.castFrom<dynamic, dynamic>(json['TMPLignesDepot']);
    LignesDepot = List.from(json['LignesDepot']).map((e)=>LigneDepot.fromJson(e)).toList();
    InventaireCourant = List.castFrom<dynamic, dynamic>(json['InventaireCourant']);
    Code = json['Code'];
    Libelle = json['Libelle'];
    Adresse = null;
    Responsable = null;
    Datec = null;
    TEL = null;
    FAX = null;
    EMAIL = null;
    TYPED = json['TYPED'];
    codepv = json['codepv'];
    libpv = json['libpv'];
    inactif = json['inactif'];
    sel = json['sel'];
    SAISIQTENEG = json['SAISIQTENEG'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PointVente'] = pointVente.toJson();
    _data['TMPLignesDepot'] = tmp_LignesDepot;
    _data['LignesDepot'] = LignesDepot.map((e)=>e.toJson()).toList();
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