import 'package:inventaire_mobile/Models/Depot.dart';

class PointVente {
  PointVente({


    required this.Code,
     this.Libelle,

     this.Responsable,

     this.depots
  });
  late  List<dynamic>? depots;
  late final String Code;
  late  String? Libelle;

    String? Responsable;


  PointVente.fromJson(Map<String, dynamic> json){
    depots = List.castFrom<dynamic, dynamic>(json['Depots']);
    Code = json['Code'];
    Libelle = json['Libelle'];
    Responsable = json['Responsable'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Depots'] = depots?.map((e)=>e.toJson()).toList();
    _data['Code'] = Code;
    _data['Libelle'] = Libelle;
    _data['Responsable'] = Responsable;

    return _data;
  }
}