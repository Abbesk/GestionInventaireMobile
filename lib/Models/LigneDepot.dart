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
    required this.qteres,
    required this.numfourn,
    required this.libfourn,
    required this.datderninv,

    required this.codepv,

     this.isSelected,

  });
  late final Article? article;
  late final String codedep;
  late final String codeart;
  late final String libelle;
  late final String desart;
  late final String famille;
  late final double? qteart;

  late final double? qteres;
  late final String? numfourn;
  late final String? libfourn;
  late final String? datderninv;

  late final String? codepv;

    int? isSelected;


  LigneDepot.fromJson(Map<String, dynamic> json){
    article = null;
    codedep = json['codedep'];
    codeart = json['codeart'];
    libelle = json['libelle'];
    desart = json['desart'];
    famille = json['famille'];
    qteart = json['qteart'];

    qteres = json['qteres'];
    numfourn = json['numfourn'];
    libfourn = json['libfourn'];
    datderninv = json['datderninv'];

    codepv = json['codepv'];

    isSelected = json['isSelected'];

  }



  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Article'] = article;
    _data['codedep'] = codedep;
    _data['codeart'] = codeart;
    _data['libelle'] = libelle;
    _data['desart'] = desart;
    _data['famille'] = famille;
    _data['qteart'] = qteart;
    _data['qteres'] = qteres;
    _data['numfourn'] = numfourn;
    _data['libfourn'] = libfourn;
    _data['datderninv'] = datderninv;
    _data['isSelected'] = isSelected;
    return _data;
  }
}
