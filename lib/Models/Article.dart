

class Article {
  Article({

    required this.code,
     required this.libelle,
      required this.puht,
     required this.fam,
    required this.codebarre


  });

  late final String code;
  late  String libelle;
  late  double puht ;
late String? codebarre;
  late  String fam;



  Article.fromJson(Map<String, dynamic> json){

    code = json['code'];
    libelle = json['libelle'];
    codebarre = json['codebarre'];

    fam = json['fam'];


    puht = json['puht'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['code'] = code;
    _data['libelle'] = libelle;
    _data['codebarre'] = codebarre;

    _data['fam'] = fam;


    _data['puht'] = puht;

    return _data;
  }
}