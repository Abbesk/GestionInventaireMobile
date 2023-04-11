import 'package:inventaire_mobile/Models/Depot.dart';

class PointVente {
  PointVente({
    required this.depots,
    required this.inventairesPhysiques,
    required this.Code,
    required this.Libelle,
    required this.Adresse,
    required this.Responsable,
    required this.Datec,
    required this.TEL,
    required this.FAX,
    required this.EMAIL,
    required this.typepv,
    required this.multidepot,
    required this.validtrsauto,
    required this.tauxmarge,
    required this.codetrs,
    required this.rstrs,
    this.PFA,
    this.SFA,
    this.IFA,
    required this.AIFA,
    this.PFC,
    this.SFC,
    this.IFC,
    required this.AIFC,
    this.PBL,
    this.SBL,
    this.IBL,
    required this.AIBL,
    this.PBS,
    this.SBS,
    this.IBS,
    required this.AIBS,
    required this.banque,
    required this.rib,
    this.PFRC,
    this.SFRC,
    this.IFRC,
    required this.AIFRC,
    this.PDEV,
    this.SDEV,
    this.AIDEV,
    this.IDEV,
    required this.solde,
    this.PBE,
    this.SBE,
    this.IBE,
    this.AIBE,
    this.PBC,
    this.SBC,
    this.IBC,
    this.AIBC,
    this.PBCF,
    this.SBCF,
    this.IBCF,
    this.AIBCF,
    this.PED,
    this.SED,
    this.IED,
    this.AIED,
    this.PFBE,
    this.SFBE,
    this.IFBE,
    this.AIFBE,
    required this.IPPV,
    required this.VUSER,
    required this.matf,
    this.Pwd,
    required this.PortConn,
    this.User,
  });
  late final List<dynamic> depots;
  late final List<dynamic> inventairesPhysiques;
  late final String Code;
  late final String Libelle;
  late final String Adresse;
  late final String Responsable;
  late final String Datec;
  late final String TEL;
  late final String FAX;
  late final String EMAIL;
  late final String typepv;
  late final String multidepot;
  late final String validtrsauto;
  late final int tauxmarge;
  late final String codetrs;
  late final String rstrs;
  late final Null PFA;
  late final Null SFA;
  late final Null IFA;
  late final String AIFA;
  late final Null PFC;
  late final Null SFC;
  late final Null IFC;
  late final String AIFC;
  late final Null PBL;
  late final Null SBL;
  late final Null IBL;
  late final String AIBL;
  late final Null PBS;
  late final Null SBS;
  late final Null IBS;
  late final String AIBS;
  late final String banque;
  late final String rib;
  late final Null PFRC;
  late final Null SFRC;
  late final Null IFRC;
  late final String AIFRC;
  late final Null PDEV;
  late final Null SDEV;
  late final Null AIDEV;
  late final Null IDEV;
  late final int solde;
  late final Null PBE;
  late final Null SBE;
  late final Null IBE;
  late final Null AIBE;
  late final Null PBC;
  late final Null SBC;
  late final Null IBC;
  late final Null AIBC;
  late final Null PBCF;
  late final Null SBCF;
  late final Null IBCF;
  late final Null AIBCF;
  late final Null PED;
  late final Null SED;
  late final Null IED;
  late final Null AIED;
  late final Null PFBE;
  late final Null SFBE;
  late final Null IFBE;
  late final Null AIFBE;
  late final String IPPV;
  late final String VUSER;
  late final String matf;
  late final Null Pwd;
  late final String PortConn;
  late final Null User;

  PointVente.fromJson(Map<String, dynamic> json){
    depots = List.castFrom<dynamic, dynamic>(json['Depots']);
    inventairesPhysiques = List.castFrom<dynamic, dynamic>(json['InventairesPhysiques']);
    Code = json['Code'];
    Libelle = json['Libelle'];
    Adresse = json['Adresse'];
    Responsable = json['Responsable'];
    Datec = json['Datec'];
    TEL = json['TEL'];
    FAX = json['FAX'];
    EMAIL = json['EMAIL'];
    typepv = json['typepv'];
    multidepot = json['multidepot'];
    validtrsauto = json['validtrsauto'];
    tauxmarge = json['tauxmarge'];
    codetrs = json['codetrs'];
    rstrs = json['rstrs'];
    PFA = null;
    SFA = null;
    IFA = null;
    AIFA = json['AIFA'];
    PFC = null;
    SFC = null;
    IFC = null;
    AIFC = json['AIFC'];
    PBL = null;
    SBL = null;
    IBL = null;
    AIBL = json['AIBL'];
    PBS = null;
    SBS = null;
    IBS = null;
    AIBS = json['AIBS'];
    banque = json['banque'];
    rib = json['rib'];
    PFRC = null;
    SFRC = null;
    IFRC = null;
    AIFRC = json['AIFRC'];
    PDEV = null;
    SDEV = null;
    AIDEV = null;
    IDEV = null;
    solde = json['solde'];
    PBE = null;
    SBE = null;
    IBE = null;
    AIBE = null;
    PBC = null;
    SBC = null;
    IBC = null;
    AIBC = null;
    PBCF = null;
    SBCF = null;
    IBCF = null;
    AIBCF = null;
    PED = null;
    SED = null;
    IED = null;
    AIED = null;
    PFBE = null;
    SFBE = null;
    IFBE = null;
    AIFBE = null;
    IPPV = json['IP_PV'];
    VUSER = json['VUSER'];
    matf = json['matf'];
    Pwd = null;
    PortConn = json['Port_conn'];
    User = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Depots'] = depots.map((e)=>e.toJson()).toList();
    _data['InventairesPhysiques'] = inventairesPhysiques;
    _data['Code'] = Code;
    _data['Libelle'] = Libelle;
    _data['Adresse'] = Adresse;
    _data['Responsable'] = Responsable;
    _data['Datec'] = Datec;
    _data['TEL'] = TEL;
    _data['FAX'] = FAX;
    _data['EMAIL'] = EMAIL;
    _data['typepv'] = typepv;
    _data['multidepot'] = multidepot;
    _data['validtrsauto'] = validtrsauto;
    _data['tauxmarge'] = tauxmarge;
    _data['codetrs'] = codetrs;
    _data['rstrs'] = rstrs;
    _data['PFA'] = PFA;
    _data['SFA'] = SFA;
    _data['IFA'] = IFA;
    _data['AIFA'] = AIFA;
    _data['PFC'] = PFC;
    _data['SFC'] = SFC;
    _data['IFC'] = IFC;
    _data['AIFC'] = AIFC;
    _data['PBL'] = PBL;
    _data['SBL'] = SBL;
    _data['IBL'] = IBL;
    _data['AIBL'] = AIBL;
    _data['PBS'] = PBS;
    _data['SBS'] = SBS;
    _data['IBS'] = IBS;
    _data['AIBS'] = AIBS;
    _data['banque'] = banque;
    _data['rib'] = rib;
    _data['PFRC'] = PFRC;
    _data['SFRC'] = SFRC;
    _data['IFRC'] = IFRC;
    _data['AIFRC'] = AIFRC;
    _data['PDEV'] = PDEV;
    _data['SDEV'] = SDEV;
    _data['AIDEV'] = AIDEV;
    _data['IDEV'] = IDEV;
    _data['solde'] = solde;
    _data['PBE'] = PBE;
    _data['SBE'] = SBE;
    _data['IBE'] = IBE;
    _data['AIBE'] = AIBE;
    _data['PBC'] = PBC;
    _data['SBC'] = SBC;
    _data['IBC'] = IBC;
    _data['AIBC'] = AIBC;
    _data['PBCF'] = PBCF;
    _data['SBCF'] = SBCF;
    _data['IBCF'] = IBCF;
    _data['AIBCF'] = AIBCF;
    _data['PED'] = PED;
    _data['SED'] = SED;
    _data['IED'] = IED;
    _data['AIED'] = AIED;
    _data['PFBE'] = PFBE;
    _data['SFBE'] = SFBE;
    _data['IFBE'] = IFBE;
    _data['AIFBE'] = AIFBE;
    _data['IP_PV'] = IPPV;
    _data['VUSER'] = VUSER;
    _data['matf'] = matf;
    _data['Pwd'] = Pwd;
    _data['Port_conn'] = PortConn;
    _data['User'] = User;
    return _data;
  }
}