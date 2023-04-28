import 'package:inventaire_mobile/Models/Depot.dart';

class PointVente {
  PointVente({


    required this.Code,
     this.Libelle,



  });

  late final String Code;
  late  String? Libelle;




  PointVente.fromJson(Map<String, dynamic> json){

    Code = json['Code'];
    Libelle = json['Libelle'];


  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Code'] = Code;
    _data['Libelle'] = Libelle;


    return _data;
  }
}