class Famille {
  Famille({

    required this.code,
    required this.libelle,


  });

  late final String code;
  late  String? libelle;


  Famille.fromJson(Map<String, dynamic> json){

    code = json['code'];
    libelle = json['libelle'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['code'] = code;
    _data['libelle'] = libelle;

    return _data;
  }
}