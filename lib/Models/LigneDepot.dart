import 'Article.dart';

class LigneDepot {
  LigneDepot({
    this.article,
    required this.codedep,
    required this.codeart,
    required this.libelle,
    required this.desart,
    required this.famille,
    required this.qteart,
    required this.stockinitial,
    required this.stockmin,
    required this.stockmax,
    this.typearticle,
    required this.qteres,
    required this.numfourn,
    required this.libfourn,
    required this.datderninv,
    this.type,
    required this.artmouv,
    required this.lot,
    required this.codepv,
    required this.libpv,
    required this.lieustock,
    required this.sousfamille,
    required this.qtereap,
    required this.isSelected,
    this.numInventaireCourant,
  });
  late final Article? article;
  late final String codedep;
  late final String codeart;
  late final String libelle;
  late final String desart;
  late final String famille;
  late final int? qteart;
  late final int stockinitial;
  late final int stockmin;
  late final int stockmax;
  late final String? typearticle;
  late final int qteres;
  late final String numfourn;
  late final String libfourn;
  late final String datderninv;
  late final String? type;
  late final String artmouv;
  late final String lot;
  late final String codepv;
  late final String libpv;
  late final String lieustock;
  late final String sousfamille;
  late final int qtereap;
  late final int isSelected;
  late final Null numInventaireCourant;

  LigneDepot.fromJson(Map<String, dynamic> json){
    article = null;
    codedep = json['codedep'];
    codeart = json['codeart'];
    libelle = json['libelle'];
    desart = json['desart'];
    famille = json['famille'];
    qteart = json['qteart'];
    stockinitial = json['stockinitial'];
    stockmin = json['stockmin'];
    stockmax = json['stockmax'];
    typearticle = null;
    qteres = json['qteres'];
    numfourn = json['numfourn'];
    libfourn = json['libfourn'];
    datderninv = json['datderninv'];
    type = null;
    artmouv = json['artmouv'];
    lot = json['lot'];
    codepv = json['codepv'];
    libpv = json['libpv'];
    lieustock = json['lieustock'];
    sousfamille = json['sousfamille'];
    qtereap = json['qtereap'];
    isSelected = json['isSelected'];
    numInventaireCourant = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Article'] = Article;
    _data['codedep'] = codedep;
    _data['codeart'] = codeart;
    _data['libelle'] = libelle;
    _data['desart'] = desart;
    _data['famille'] = famille;
    _data['qteart'] = qteart;
    _data['stockinitial'] = stockinitial;
    _data['stockmin'] = stockmin;
    _data['stockmax'] = stockmax;
    _data['typearticle'] = typearticle;
    _data['qteres'] = qteres;
    _data['numfourn'] = numfourn;
    _data['libfourn'] = libfourn;
    _data['datderninv'] = datderninv;
    _data['type'] = type;
    _data['artmouv'] = artmouv;
    _data['lot'] = lot;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    _data['lieustock'] = lieustock;
    _data['sousfamille'] = sousfamille;
    _data['qtereap'] = qtereap;
    _data['isSelected'] = isSelected;
    _data['numInventaireCourant'] = numInventaireCourant;
    return _data;
  }
}
