class UserSoc {
  UserSoc({
    required this.CODEUSER,
    required this.societe,
    required this.accee,
    required this.ecriture,
    required this.Projet,
    required this.seltmp,
    required this.acceclot,
    required this.rsoc,

  });
  late final String CODEUSER;
  late final String societe;
  late final String? accee;
  late final String? ecriture;
  late final String? Projet;
  late final String? seltmp;
  late final String? acceclot;
  late final String? rsoc;


  UserSoc.fromJson(Map<String, dynamic> json){
    CODEUSER = json['CODEUSER'];
    societe = json['societe'];
    accee = json['accee'];
    ecriture = json['ecriture'];
    Projet = json['Projet'];
    seltmp = json['seltmp'];
    acceclot = json['acceclot'];
    rsoc = json['rsoc'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CODEUSER'] = CODEUSER;
    _data['societe'] = societe;
    _data['accee'] = accee;
    _data['ecriture'] = ecriture;
    _data['Projet'] = Projet;
    _data['seltmp'] = seltmp;
    _data['acceclot'] = acceclot;
    _data['rsoc'] = rsoc;

    return _data;
  }
}