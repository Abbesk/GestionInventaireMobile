class Fournisseur {
  Fournisseur({
    required this.code,

  });
  late final String code;


  Fournisseur.fromJson(Map<String, dynamic> json){
    code = json['code'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;

    return _data;
  }
}