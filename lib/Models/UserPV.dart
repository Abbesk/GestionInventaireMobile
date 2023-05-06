class UserPV {
  UserPV({
    required this.codeuser,
    required this.codepv,
    required this.libpv,

  });
  late final String codeuser;
  late final String codepv;
  late final String? libpv;


  UserPV.fromJson(Map<String, dynamic> json){
    codeuser = json['codeuser'];
    codepv = json['codepv'];
    libpv = json['libpv'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['codeuser'] = codeuser;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    return _data;
  }
}