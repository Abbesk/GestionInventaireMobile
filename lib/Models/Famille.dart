class Famille {
  Famille({

    required this.code,
    required this.libelle,


  });
  late final List<dynamic> Articles;
  late final String code;
  late final String libelle;
  late final String? achat;
  late final String? vente;
  late final int dispo;
  late final String sav;
  late final String immeuble;
  late final Null position;
  late final String? codepv;
  late final String? libpv;
  late final String favoris;

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