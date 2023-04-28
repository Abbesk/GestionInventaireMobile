import 'Article.dart';


class LigneInventaire {
  LigneInventaire({
      this.article,
    required this.NumInv,
    required this.dateInv,
    required this.codeart,
    required this.desart,
    required this.qtes,
    required this.stockinv,
    required this.ecartinv,
    required this.PUART,

    required this.famille,
    required this.libellefourn,

    required this.nordre,

    required this.codedep,
    required this.libdep,
    required this.codepv,
    required this.libpv,
    required this.eecart,
    required this.secart,

  });
   late final Article? article;
  late final String NumInv;
  late final String dateInv;
  late final String codeart;
  late final String desart;
  late final double qtes;
  late final double? stockinv;
  late final double? ecartinv;
  late final double PUART;

  late final String famille;
  late final String libellefourn;

  late final String nordre;


  late final String codedep;
  late final String libdep;
  late final String codepv;
  late final String libpv;
  late final double? eecart;
  late final double? secart;


  LigneInventaire.fromJson(Map<String, dynamic> json){

    NumInv = json['NumInv'];
    dateInv = json['dateInv'];
    codeart = json['codeart'];
    desart = json['desart'];
    qtes = json['qtes'];
    stockinv = json['stockinv'];
    ecartinv = json['ecartinv'];
    PUART = json['PUART'];

    famille = json['famille'];
    libellefourn = json['libellefourn'];

    nordre = json['nordre'];


    codedep = json['codedep'];
    libdep = json['libdep'];
    codepv = json['codepv'];
    libpv = json['libpv'];
    eecart = json['eecart'];
    secart = json['secart'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Article'] = article?.toJson();
    _data['NumInv'] = NumInv;
    _data['dateInv'] = dateInv;
    _data['codeart'] = codeart;
    _data['desart'] = desart;
    _data['qtes'] = qtes;
    _data['stockinv'] = stockinv;
    _data['ecartinv'] = ecartinv;
    _data['PUART'] = PUART;
    _data['famille'] = famille;
    _data['libellefourn'] = libellefourn;
    _data['nordre'] = nordre;
    _data['codedep'] = codedep;
    _data['libdep'] = libdep;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    _data['eecart'] = eecart;
    _data['secart'] = secart;

    return _data;
  }
}

