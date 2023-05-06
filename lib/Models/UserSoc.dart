class UserSoc {
  UserSoc({
    required this.CODEUSER,
    required this.societe,
    required this.rsoc,

  });
  late final String CODEUSER;
  late final String societe;
  late final String? rsoc;


  UserSoc.fromJson(Map<String, dynamic> json){
    CODEUSER = json['CODEUSER'];
    societe = json['societe'];
    rsoc = json['rsoc'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CODEUSER'] = CODEUSER;
    _data['societe'] = societe;
    _data['rsoc'] = rsoc;

    return _data;
  }
}