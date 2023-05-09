class Utilisateur {
  Utilisateur({
    required this.codeuser,
    required this.nom,
    required this.motpasse,
    required this.type,
    required this.socutil,

  });
  late final String codeuser;
  late final String nom;
  late final String motpasse;
  late final String type;

  late final String socutil;

  Utilisateur.fromJson(Map<String, dynamic> json){
    codeuser = json['codeuser'];
    nom = json['nom'];
    motpasse = json['motpasse'];
    type = json['type'];
    socutil = json['socutil'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['codeuser'] = codeuser;
    _data['nom'] = nom;
    _data['motpasse'] = motpasse;
    _data['type'] = type;
    _data['socutil'] = socutil;

    return _data;
  }
}