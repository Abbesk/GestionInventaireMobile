import 'Article.dart';

class TMPLigneDepot {
  TMPLigneDepot({
     this.article,
     this.famille,
     this.codeart,
     this.desart,
     this.qteart,
     this.lieustock,
     this.Datderninv,

     this.fourn,
     this.libellefourn,

     this.codedep,
     this.libelle,
     this.nordre,

     this.numinv,
     this.puht,
     this.isSelected,
     this.codepv,
     this.qteInventaire,
     this.commentaire,
  });
   Article? article;
   String? famille;
   String? codeart;
   String? desart;
   int? qteart;
   String? lieustock;
   String? Datderninv;

   String? fourn;
   String? libellefourn;

   String? codedep;
   String? libelle;
   String? nordre;
   String? numinv;
   int? puht;
   int? isSelected;
   String? codepv;
   int? qteInventaire;
   String? commentaire;

  TMPLigneDepot.fromJson(Map<String, dynamic> json){
    article = Article.fromJson(json['Article']);
    famille = json['famille'];
    codeart = json['codeart'];
    desart = json['desart'];
    qteart = json['qteart'];
    lieustock = json['lieustock'];
    Datderninv = json['Datderninv'];

    fourn = json['fourn'];
    libellefourn = json['libellefourn'];

    codedep = json['codedep'];
    libelle = json['libelle'];
    nordre = json['nordre'];

    numinv = json['numinv'];
    puht = json['puht'];
    isSelected = json['isSelected'];
    codepv = json['codepv'];
    qteInventaire = json['qteInventaire'];
    commentaire = json['commentaire'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Article'] = article?.toJson();
    _data['famille'] = famille;
    _data['codeart'] = codeart;
    _data['desart'] = desart;
    _data['qteart'] = qteart;
    _data['lieustock'] = lieustock;
    _data['Datderninv'] = Datderninv;

    _data['fourn'] = fourn;
    _data['libellefourn'] = libellefourn;

    _data['codedep'] = codedep;
    _data['libelle'] = libelle;
    _data['nordre'] = nordre;

    _data['numinv'] = numinv;
    _data['puht'] = puht;
    _data['isSelected'] = isSelected;
    _data['codepv'] = codepv;
    _data['qteInventaire'] = qteInventaire;
    _data['commentaire'] = commentaire;
    return _data;
  }
}
