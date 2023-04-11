import 'Famille.dart';
import 'Fournisseur.dart';

class Article {
  Article({
    this.fournisseur,
    this.famille,
    required this.code,
    required this.libelle,
    required this.unite,
    required this.nbrunite,
    this.type,
    required this.fam,
    this.fourn,
    this.image,
    this.chemin,
    required this.tauxtva,
    required this.fodec,
    this.tauxmajo,
    required this.remmax,
    required this.qtes,
    required this.stockinitial,
    required this.stockmin,
    required this.stockmax,
    required this.dateachat,
    required this.DREMISE,
    required this.prixbrut,
    required this.prixnet,
    required this.marge,
    required this.margepv2,
    required this.margepv3,
    required this.datevente,
    required this.prix1,
    required this.prix2,
    required this.prix3,
    required this.prix4,
    this.CONFIG,
    this.lieustock,
    this.gestionstock,
    this.libellef,
    this.libellefourn,
    this.avecconfig,
    this.observation,
    this.budget,
    required this.prixachini,
    this.libelleAr,
    required this.prixdevice,
    this.nomenclature,
    required this.PrixPub,
    required this.longeur,
    required this.largeur,
    required this.epaisseur,
    this.Bois,
    this.serie,
    this.TYCODBAR,
    this.codebarre,
    required this.gtaillecoul,
    required this.hauteur,
    required this.stkinitexer,
    required this.nbreptfid,
    required this.affectptfid,
    required this.datprom1,
    required this.datprom2,
    required this.remfidel,
    this.NGP,
    required this.cours,
    required this.tariffrs,
    required this.datetarif,
    this.devise,
    this.pxcomp,
    this.cvlong,
    this.cvlarg,
    this.codefini,
    this.libfini,
    this.typeart,
    this.reforigine,
    required this.puht,
    this.avance,
    required this.datecreate,
    this.abrev,
    this.abrevpart1,
    this.abrevpart2,
    required this.dispo,
    required this.position,
    this.import,
    this.typeartg,
    required this.kmmax,
    required this.kmeff,
    required this.duregarant,
    this.codefrs,
    this.rsfrs,
    required this.dernmajprix1,
    required this.dernmajprix2,
    required this.dernmajprix3,
    this.lib1,
    this.lib2,
    this.lib3,
    this.lib4,
    required this.nbcart,
    this.numlot,
    this.qtecart,
    this.qtesac,
    this.unitegarantie,
    this.usera,
    this.userm,
    this.users,
    required this.datemaj,
    required this.dureealerte,
    required this.gestionlot,
    required this.artmouv,
    required this.pmp,
    required this.ventevrac,
    required this.prix1TTC,
    required this.prix2TTC,
    required this.prix3TTC,
    required this.genGPAO,
    required this.sav,
    required this.ftmodif,
    required this.prixsolde,
    required this.remisesolde,
    this.cgrilletaille,
    this.lgrilletaille,
    this.ctaille,
    this.taille,
    required this.libsousfam,
    this.ccoul,
    this.couleur,
    this.ccol,
    this.libcol,
    this.sousfamille,
    required this.cons,
    required this.tcomm,
    required this.Dtcons,
    required this.codesousfam,
    required this.PUHTA,
    required this.PUHTV,
    required this.codepv,
    required this.libpv,
    this.PrixMoyAchat,
    this.PrixMoyVente,
    required this.mtcomm,
    required this.Poid,
    required this.PoidNet,
    required this.colisage,
    required this.imagesize,
    required this.imagepath,
    this.imagedata,
    this.AveConsigne,
    this.comptec,
    this.sel,
  });
  late final Fournisseur? fournisseur;
  late final Famille? famille;
  late final String code;
  late final String libelle;
  late final String unite;
  late final int nbrunite;
  late final String? type;
  late final String fam;
  late final String? fourn;
  late final String? image;
  late final String? chemin;
  late final int tauxtva;
  late final int fodec;
  late final String? tauxmajo;
  late final int remmax;
  late final int qtes;
  late final int stockinitial;
  late final int stockmin;
  late final int stockmax;
  late final String dateachat;
  late final int? DREMISE;
  late final int? prixbrut;
  late final int? prixnet;
  late final int? marge;
  late final int margepv2;
  late final int margepv3;
  late final String datevente;
  late final int? prix1;
  late final int prix2;
  late final int prix3;
  late final int prix4;
  late final String? CONFIG;
  late final String? lieustock;
  late final String? gestionstock;
  late final String? libellef;
  late final String? libellefourn;
  late final String? avecconfig;
  late final String? observation;
  late final int? budget;
  late final int prixachini;
  late final String? libelleAr;
  late final int prixdevice;
  late final String? nomenclature;
  late final int PrixPub;
  late final int longeur;
  late final int largeur;
  late final int epaisseur;
  late final String? Bois;
  late final String? serie;
  late final String? TYCODBAR;
  late final String? codebarre;
  late final String gtaillecoul;
  late final int hauteur;
  late final int stkinitexer;
  late final int nbreptfid;
  late final String affectptfid;
  late final String datprom1;
  late final String datprom2;
  late final int remfidel;
  late final String? NGP;
  late final int cours;
  late final int tariffrs;
  late final String datetarif;
  late final String? devise;
  late final int? pxcomp;
  late final int? cvlong;
  late final int? cvlarg;
  late final String? codefini;
  late final String? libfini;
  late final String? typeart;
  late final String? reforigine;
  late final int puht;
  late final String? avance;
  late final String datecreate;
  late final Null abrev;
  late final Null abrevpart1;
  late final Null abrevpart2;
  late final int dispo;
  late final int position;
  late final String? import;
  late final String? typeartg;
  late final int kmmax;
  late final int kmeff;
  late final int duregarant;
  late final String? codefrs;
  late final String? rsfrs;
  late final String dernmajprix1;
  late final String dernmajprix2;
  late final String dernmajprix3;
  late final String? lib1;
  late final Null lib2;
  late final Null lib3;
  late final Null lib4;
  late final int nbcart;
  late final String? numlot;
  late final String? qtecart;
  late final String? qtesac;
  late final String? unitegarantie;
  late final String? usera;
  late final String? userm;
  late final String? users;
  late final String datemaj;
  late final String dureealerte;
  late final String gestionlot;
  late final String artmouv;
  late final int pmp;
  late final String ventevrac;
  late final int? prix1TTC;
  late final int prix2TTC;
  late final int prix3TTC;
  late final String genGPAO;
  late final String sav;
  late final String ftmodif;
  late final int prixsolde;
  late final int remisesolde;
  late final String? cgrilletaille;
  late final String? lgrilletaille;
  late final String? ctaille;
  late final String? taille;
  late final String libsousfam;
  late final String? ccoul;
  late final String? couleur;
  late final String? ccol;
  late final String? libcol;
  late final String? sousfamille;
  late final String cons;
  late final int tcomm;
  late final int Dtcons;
  late final String codesousfam;
  late final int PUHTA;
  late final int PUHTV;
  late final String codepv;
  late final String libpv;
  late final int? PrixMoyAchat;
  late final int? PrixMoyVente;
  late final int mtcomm;
  late final int Poid;
  late final int PoidNet;
  late final String colisage;
  late final int imagesize;
  late final String imagepath;
  late final Null imagedata;
  late final Null AveConsigne;
  late final Null comptec;
  late final Null sel;

  Article.fromJson(Map<String, dynamic> json){
    fournisseur = null;
    famille = null;
    code = json['code'];
    libelle = json['libelle'];
    unite = json['unite'];
    nbrunite = json['nbrunite'];
    type = null;
    fam = json['fam'];
    fourn = null;
    image = null;
    chemin = null;
    tauxtva = json['tauxtva'];
    fodec = json['fodec'];
    tauxmajo = null;
    remmax = json['remmax'];
    qtes = json['qtes'];
    stockinitial = json['stockinitial'];
    stockmin = json['stockmin'];
    stockmax = json['stockmax'];
    dateachat = json['dateachat'];
    DREMISE = json['DREMISE'];
    prixbrut = json['prixbrut'];
    prixnet = json['prixnet'];
    marge = json['marge'];
    margepv2 = json['margepv2'];
    margepv3 = json['margepv3'];
    datevente = json['datevente'];
    prix1 = json['prix1'];
    prix2 = json['prix2'];
    prix3 = json['prix3'];
    prix4 = json['prix4'];
    CONFIG = null;
    lieustock = null;
    gestionstock = null;
    libellef = null;
    libellefourn = null;
    avecconfig = null;
    observation = null;
    budget = null;
    prixachini = json['prixachini'];
    libelleAr = null;
    prixdevice = json['prixdevice'];
    nomenclature = null;
    PrixPub = json['PrixPub'];
    longeur = json['longeur'];
    largeur = json['largeur'];
    epaisseur = json['epaisseur'];
    Bois = null;
    serie = null;
    TYCODBAR = null;
    codebarre = null;
    gtaillecoul = json['gtaillecoul'];
    hauteur = json['hauteur'];
    stkinitexer = json['stkinitexer'];
    nbreptfid = json['nbreptfid'];
    affectptfid = json['affectptfid'];
    datprom1 = json['datprom1'];
    datprom2 = json['datprom2'];
    remfidel = json['remfidel'];
    NGP = null;
    cours = json['cours'];
    tariffrs = json['tariffrs'];
    datetarif = json['datetarif'];
    devise = null;
    pxcomp = null;
    cvlong = null;
    cvlarg = null;
    codefini = null;
    libfini = null;
    typeart = null;
    reforigine = null;
    puht = json['puht'];
    avance = null;
    datecreate = json['datecreate'];
    abrev = null;
    abrevpart1 = null;
    abrevpart2 = null;
    dispo = json['dispo'];
    position = json['position'];
    import = null;
    typeartg = null;
    kmmax = json['kmmax'];
    kmeff = json['kmeff'];
    duregarant = json['duregarant'];
    codefrs = null;
    rsfrs = null;
    dernmajprix1 = json['dernmajprix1'];
    dernmajprix2 = json['dernmajprix2'];
    dernmajprix3 = json['dernmajprix3'];
    lib1 = null;
    lib2 = null;
    lib3 = null;
    lib4 = null;
    nbcart = json['nbcart'];
    numlot = null;
    qtecart = null;
    qtesac = null;
    unitegarantie = null;
    usera = null;
    userm = null;
    users = null;
    datemaj = json['datemaj'];
    dureealerte = json['dureealerte'];
    gestionlot = json['gestionlot'];
    artmouv = json['artmouv'];
    pmp = json['pmp'];
    ventevrac = json['ventevrac'];
    prix1TTC = json['prix1TTC'];
    prix2TTC = json['prix2TTC'];
    prix3TTC = json['prix3TTC'];
    genGPAO = json['genGPAO'];
    sav = json['sav'];
    ftmodif = json['ftmodif'];
    prixsolde = json['prixsolde'];
    remisesolde = json['remisesolde'];
    cgrilletaille = null;
    lgrilletaille = null;
    ctaille = null;
    taille = null;
    libsousfam = json['libsousfam'];
    ccoul = null;
    couleur = null;
    ccol = null;
    libcol = null;
    sousfamille = null;
    cons = json['cons'];
    tcomm = json['tcomm'];
    Dtcons = json['Dtcons'];
    codesousfam = json['codesousfam'];
    PUHTA = json['PUHTA'];
    PUHTV = json['PUHTV'];
    codepv = json['codepv'];
    libpv = json['libpv'];
    PrixMoyAchat = null;
    PrixMoyVente = null;
    mtcomm = json['mtcomm'];
    Poid = json['Poid'];
    PoidNet = json['PoidNet'];
    colisage = json['colisage'];
    imagesize = json['imagesize'];
    imagepath = json['imagepath'];
    imagedata = null;
    AveConsigne = null;
    comptec = null;
    sel = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Fournisseur'] = fournisseur;
    _data['Famille'] = famille;
    _data['code'] = code;
    _data['libelle'] = libelle;
    _data['unite'] = unite;
    _data['nbrunite'] = nbrunite;
    _data['type'] = type;
    _data['fam'] = fam;
    _data['fourn'] = fourn;
    _data['image'] = image;
    _data['chemin'] = chemin;
    _data['tauxtva'] = tauxtva;
    _data['fodec'] = fodec;
    _data['tauxmajo'] = tauxmajo;
    _data['remmax'] = remmax;
    _data['qtes'] = qtes;
    _data['stockinitial'] = stockinitial;
    _data['stockmin'] = stockmin;
    _data['stockmax'] = stockmax;
    _data['dateachat'] = dateachat;
    _data['DREMISE'] = DREMISE;
    _data['prixbrut'] = prixbrut;
    _data['prixnet'] = prixnet;
    _data['marge'] = marge;
    _data['margepv2'] = margepv2;
    _data['margepv3'] = margepv3;
    _data['datevente'] = datevente;
    _data['prix1'] = prix1;
    _data['prix2'] = prix2;
    _data['prix3'] = prix3;
    _data['prix4'] = prix4;
    _data['CONFIG'] = CONFIG;
    _data['lieustock'] = lieustock;
    _data['gestionstock'] = gestionstock;
    _data['libellef'] = libellef;
    _data['libellefourn'] = libellefourn;
    _data['avecconfig'] = avecconfig;
    _data['observation'] = observation;
    _data['budget'] = budget;
    _data['prixachini'] = prixachini;
    _data['libelleAr'] = libelleAr;
    _data['prixdevice'] = prixdevice;
    _data['nomenclature'] = nomenclature;
    _data['PrixPub'] = PrixPub;
    _data['longeur'] = longeur;
    _data['largeur'] = largeur;
    _data['epaisseur'] = epaisseur;
    _data['Bois'] = Bois;
    _data['serie'] = serie;
    _data['TYCODBAR'] = TYCODBAR;
    _data['codebarre'] = codebarre;
    _data['gtaillecoul'] = gtaillecoul;
    _data['hauteur'] = hauteur;
    _data['stkinitexer'] = stkinitexer;
    _data['nbreptfid'] = nbreptfid;
    _data['affectptfid'] = affectptfid;
    _data['datprom1'] = datprom1;
    _data['datprom2'] = datprom2;
    _data['remfidel'] = remfidel;
    _data['NGP'] = NGP;
    _data['cours'] = cours;
    _data['tariffrs'] = tariffrs;
    _data['datetarif'] = datetarif;
    _data['devise'] = devise;
    _data['pxcomp'] = pxcomp;
    _data['cvlong'] = cvlong;
    _data['cvlarg'] = cvlarg;
    _data['codefini'] = codefini;
    _data['libfini'] = libfini;
    _data['typeart'] = typeart;
    _data['reforigine'] = reforigine;
    _data['puht'] = puht;
    _data['avance'] = avance;
    _data['datecreate'] = datecreate;
    _data['abrev'] = abrev;
    _data['abrevpart1'] = abrevpart1;
    _data['abrevpart2'] = abrevpart2;
    _data['dispo'] = dispo;
    _data['position'] = position;
    _data['import'] = import;
    _data['typeartg'] = typeartg;
    _data['kmmax'] = kmmax;
    _data['kmeff'] = kmeff;
    _data['duregarant'] = duregarant;
    _data['codefrs'] = codefrs;
    _data['rsfrs'] = rsfrs;
    _data['dernmajprix1'] = dernmajprix1;
    _data['dernmajprix2'] = dernmajprix2;
    _data['dernmajprix3'] = dernmajprix3;
    _data['lib1'] = lib1;
    _data['lib2'] = lib2;
    _data['lib3'] = lib3;
    _data['lib4'] = lib4;
    _data['nbcart'] = nbcart;
    _data['numlot'] = numlot;
    _data['qtecart'] = qtecart;
    _data['qtesac'] = qtesac;
    _data['unitegarantie'] = unitegarantie;
    _data['usera'] = usera;
    _data['userm'] = userm;
    _data['users'] = users;
    _data['datemaj'] = datemaj;
    _data['dureealerte'] = dureealerte;
    _data['gestionlot'] = gestionlot;
    _data['artmouv'] = artmouv;
    _data['pmp'] = pmp;
    _data['ventevrac'] = ventevrac;
    _data['prix1TTC'] = prix1TTC;
    _data['prix2TTC'] = prix2TTC;
    _data['prix3TTC'] = prix3TTC;
    _data['genGPAO'] = genGPAO;
    _data['sav'] = sav;
    _data['ftmodif'] = ftmodif;
    _data['prixsolde'] = prixsolde;
    _data['remisesolde'] = remisesolde;
    _data['cgrilletaille'] = cgrilletaille;
    _data['lgrilletaille'] = lgrilletaille;
    _data['ctaille'] = ctaille;
    _data['taille'] = taille;
    _data['libsousfam'] = libsousfam;
    _data['ccoul'] = ccoul;
    _data['couleur'] = couleur;
    _data['ccol'] = ccol;
    _data['libcol'] = libcol;
    _data['sousfamille'] = sousfamille;
    _data['cons'] = cons;
    _data['tcomm'] = tcomm;
    _data['Dtcons'] = Dtcons;
    _data['codesousfam'] = codesousfam;
    _data['PUHTA'] = PUHTA;
    _data['PUHTV'] = PUHTV;
    _data['codepv'] = codepv;
    _data['libpv'] = libpv;
    _data['PrixMoyAchat'] = PrixMoyAchat;
    _data['PrixMoyVente'] = PrixMoyVente;
    _data['mtcomm'] = mtcomm;
    _data['Poid'] = Poid;
    _data['PoidNet'] = PoidNet;
    _data['colisage'] = colisage;
    _data['imagesize'] = imagesize;
    _data['imagepath'] = imagepath;
    _data['imagedata'] = imagedata;
    _data['AveConsigne'] = AveConsigne;
    _data['comptec'] = comptec;
    _data['sel'] = sel;
    return _data;
  }
}