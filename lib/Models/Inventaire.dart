import 'Depot.dart';
import 'LigneInventaire.dart';
import 'PointVente.dart';

class Inventaire {
  Inventaire({
     this.pointVente,
     this.lignesInventaire,
     this.depot,
     this.numinv,
     this.dateinv,
     this.nbrcomptage,
     this.commentaire,
     this.cloture,
     this.datecloture,
     this.utilisateur,

     this.DATEDMAJ,
     this.codepv,
     this.libpv,
     this.codedep,
     this.libdep,

  });
   PointVente? pointVente;
   List<LigneInventaire>? lignesInventaire;
   Depot? depot;
   String? numinv;
   String? dateinv;
   int? nbrcomptage;
   String? commentaire;
   String? cloture;
   String? datecloture;
   String? utilisateur;

   String? DATEDMAJ;
   String? codepv;
   String? libpv;
   String? codedep;
   String? libdep;


  Inventaire.fromJson(Map<String, dynamic> json){
    pointVente = PointVente.fromJson(json['PointVente']);
    lignesInventaire = List.from(json['LignesInventaire']).map((e)=>LigneInventaire.fromJson(e)).toList();
    depot = Depot.fromJson(json['Depot']);
    numinv = json['numinv'];
    dateinv = json['dateinv'];
    nbrcomptage = json['nbrcomptage'];
    commentaire = json['commentaire'];
    cloture = json['cloture'];
    datecloture = json['datecloture'];
    utilisateur = json['utilisateur'];

    DATEDMAJ = json['DATEDMAJ'];
    codepv = json['codepv'];
    libpv = json['libpv'];
    codedep = json['codedep'];
    libdep = json['libdep'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PointVente'] = pointVente?.toJson();
    _data['LignesInventaire'] = lignesInventaire?.map((e)=>e.toJson()).toList();
    _data['depot'] = depot?.toJson();
    _data['numinv'] = numinv;
    _data['dateinv'] = dateinv;
    _data['nbrcomptage'] = nbrcomptage;
    _data['commentaire'] = commentaire;
    _data['cloture'] = cloture;
    _data['datecloture'] = datecloture;
    _data['utilisateur'] = utilisateur;
    _data['DATEDMAJ'] = DATEDMAJ;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    _data['codedep'] = codedep;
    _data['libdep'] = libdep;

    return _data;
  }
}
