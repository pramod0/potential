class CANIndFillEezzReq {
  REQHEADER? rEQHEADER;
  REQBODY? rEQBODY;

  CANIndFillEezzReq({this.rEQHEADER, this.rEQBODY});

  CANIndFillEezzReq.fromJson(Map<String, dynamic> json) {
    rEQHEADER = json['REQ_HEADER'] != null
        ? REQHEADER.fromJson(json['REQ_HEADER'])
        : null;
    rEQBODY =
        json['REQ_BODY'] != null ? REQBODY.fromJson(json['REQ_BODY']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rEQHEADER != null) {
      data['REQ_HEADER'] = rEQHEADER!.toJson();
    }
    if (rEQBODY != null) {
      data['REQ_BODY'] = rEQBODY!.toJson();
    }
    return data;
  }
}

class REQHEADER {
  String? eNTITYID;
  String? uNIQUEID;
  String? rEQUESTTYPE;
  String? lOGUSERID;
  String? eNENCRPASSWORD;
  int? vERSIONNO;
  String? tIMESTAMP;

  REQHEADER(
      {this.eNTITYID,
      this.uNIQUEID,
      this.rEQUESTTYPE,
      this.lOGUSERID,
      this.eNENCRPASSWORD,
      this.vERSIONNO,
      this.tIMESTAMP});

  REQHEADER.fromJson(Map<String, dynamic> json) {
    eNTITYID = json['ENTITY_ID'];
    uNIQUEID = json['UNIQUE_ID'];
    rEQUESTTYPE = json['REQUEST_TYPE'];
    lOGUSERID = json['LOG_USER_ID'];
    eNENCRPASSWORD = json['EN_ENCR_PASSWORD'];
    vERSIONNO = json['VERSION_NO'];
    tIMESTAMP = json['TIMESTAMP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ENTITY_ID'] = eNTITYID;
    data['UNIQUE_ID'] = uNIQUEID;
    data['REQUEST_TYPE'] = rEQUESTTYPE;
    data['LOG_USER_ID'] = lOGUSERID;
    data['EN_ENCR_PASSWORD'] = eNENCRPASSWORD;
    data['VERSION_NO'] = vERSIONNO;
    data['TIMESTAMP'] = tIMESTAMP;
    return data;
  }
}

class REQBODY {
  String? rEQEVENT;
  String? cAN;
  String? rEGTYPE;
  String? pROOFUPLOADBYCAN;
  String? eNABLEONLINEACCESSFLAG;
  ENTITYEMAILDETAILS? eNTITYEMAILDETAILS;
  String? hOLDINGTYPE;
  String? iNVCATEGORY;
  String? tAXSTATUS;
  int? hOLDERCOUNT;
  HOLDERRECORDS? hOLDERRECORDS;
  ARNDETAILS? aRNDETAILS;
  BANKDETAILS? bANKDETAILS;
  NOMINEEDETAILS? nOMINEEDETAILS;

  REQBODY(
      {this.rEQEVENT,
      this.cAN,
      this.rEGTYPE,
      this.pROOFUPLOADBYCAN,
      this.eNABLEONLINEACCESSFLAG,
      this.eNTITYEMAILDETAILS,
      this.hOLDINGTYPE,
      this.iNVCATEGORY,
      this.tAXSTATUS,
      this.hOLDERCOUNT,
      this.hOLDERRECORDS,
      this.aRNDETAILS,
      this.bANKDETAILS,
      this.nOMINEEDETAILS});

  REQBODY.fromJson(Map<String, dynamic> json) {
    rEQEVENT = json['REQ_EVENT'];
    cAN = json['CAN'];
    rEGTYPE = json['REG_TYPE'];
    pROOFUPLOADBYCAN = json['PROOF_UPLOAD_BY_CAN'];
    eNABLEONLINEACCESSFLAG = json['ENABLE_ONLINE_ACCESS_FLAG'];
    eNTITYEMAILDETAILS = json['ENTITY_EMAIL_DETAILS'] != null
        ? ENTITYEMAILDETAILS.fromJson(json['ENTITY_EMAIL_DETAILS'])
        : null;
    hOLDINGTYPE = json['HOLDING_TYPE'];
    iNVCATEGORY = json['INV_CATEGORY'];
    tAXSTATUS = json['TAX_STATUS'];
    hOLDERCOUNT = json['HOLDER_COUNT'];
    hOLDERRECORDS = json['HOLDER_RECORDS'] != null
        ? HOLDERRECORDS.fromJson(json['HOLDER_RECORDS'])
        : null;
    aRNDETAILS = json['ARN_DETAILS'] != null
        ? ARNDETAILS.fromJson(json['ARN_DETAILS'])
        : null;
    bANKDETAILS = json['BANK_DETAILS'] != null
        ? BANKDETAILS.fromJson(json['BANK_DETAILS'])
        : null;
    nOMINEEDETAILS = json['NOMINEE_DETAILS'] != null
        ? NOMINEEDETAILS.fromJson(json['NOMINEE_DETAILS'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['REQ_EVENT'] = rEQEVENT;
    data['CAN'] = cAN;
    data['REG_TYPE'] = rEGTYPE;
    data['PROOF_UPLOAD_BY_CAN'] = pROOFUPLOADBYCAN;
    data['ENABLE_ONLINE_ACCESS_FLAG'] = eNABLEONLINEACCESSFLAG;
    if (eNTITYEMAILDETAILS != null) {
      data['ENTITY_EMAIL_DETAILS'] = eNTITYEMAILDETAILS!.toJson();
    }
    data['HOLDING_TYPE'] = hOLDINGTYPE;
    data['INV_CATEGORY'] = iNVCATEGORY;
    data['TAX_STATUS'] = tAXSTATUS;
    data['HOLDER_COUNT'] = hOLDERCOUNT;
    if (hOLDERRECORDS != null) {
      data['HOLDER_RECORDS'] = hOLDERRECORDS!.toJson();
    }
    if (aRNDETAILS != null) {
      data['ARN_DETAILS'] = aRNDETAILS!.toJson();
    }
    if (bANKDETAILS != null) {
      data['BANK_DETAILS'] = bANKDETAILS!.toJson();
    }
    if (nOMINEEDETAILS != null) {
      data['NOMINEE_DETAILS'] = nOMINEEDETAILS!.toJson();
    }
    return data;
  }
}

class ENTITYEMAILDETAILS {
  List<String>? eMAILID;

  ENTITYEMAILDETAILS({this.eMAILID});

  ENTITYEMAILDETAILS.fromJson(Map<String, dynamic> json) {
    eMAILID = json['EMAIL_ID'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EMAIL_ID'] = eMAILID;
    return data;
  }
}

class HOLDERRECORDS {
  HOLDERRECORD? hOLDERRECORD;

  HOLDERRECORDS({this.hOLDERRECORD});

  HOLDERRECORDS.fromJson(Map<String, dynamic> json) {
    hOLDERRECORD = json['HOLDER_RECORD'] != null
        ? HOLDERRECORD.fromJson(json['HOLDER_RECORD'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hOLDERRECORD != null) {
      data['HOLDER_RECORD'] = hOLDERRECORD!.toJson();
    }
    return data;
  }
}

class HOLDERRECORD {
  String? hOLDERTYPE;
  String? nAME;
  String? dOB;
  String? pANEXEMPTFLAG;
  String? pANPEKRNNO;
  String? aADHAARNO;
  String? rELATIONSHIP;
  String? rELPROOF;
  CONTACTDETAIL? cONTACTDETAIL;
  OTHERDETAIL? oTHERDETAIL;
  FATCADETAIL? fATCADETAIL;

  HOLDERRECORD(
      {this.hOLDERTYPE,
      this.nAME,
      this.dOB,
      this.pANEXEMPTFLAG,
      this.pANPEKRNNO,
      this.aADHAARNO,
      this.rELATIONSHIP,
      this.rELPROOF,
      this.cONTACTDETAIL,
      this.oTHERDETAIL,
      this.fATCADETAIL});

  HOLDERRECORD.fromJson(Map<String, dynamic> json) {
    hOLDERTYPE = json['HOLDER_TYPE'];
    nAME = json['NAME'];
    dOB = json['DOB'];
    pANEXEMPTFLAG = json['PAN_EXEMPT_FLAG'];
    pANPEKRNNO = json['PAN_PEKRN_NO'];
    aADHAARNO = json['AADHAAR_NO'];
    rELATIONSHIP = json['RELATIONSHIP'];
    rELPROOF = json['REL_PROOF'];
    cONTACTDETAIL = json['CONTACT_DETAIL'] != null
        ? CONTACTDETAIL.fromJson(json['CONTACT_DETAIL'])
        : null;
    oTHERDETAIL = json['OTHER_DETAIL'] != null
        ? OTHERDETAIL.fromJson(json['OTHER_DETAIL'])
        : null;
    fATCADETAIL = json['FATCA_DETAIL'] != null
        ? FATCADETAIL.fromJson(json['FATCA_DETAIL'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['HOLDER_TYPE'] = hOLDERTYPE;
    data['NAME'] = nAME;
    data['DOB'] = dOB;
    data['PAN_EXEMPT_FLAG'] = pANEXEMPTFLAG;
    data['PAN_PEKRN_NO'] = pANPEKRNNO;
    data['AADHAAR_NO'] = aADHAARNO;
    data['RELATIONSHIP'] = rELATIONSHIP;
    data['REL_PROOF'] = rELPROOF;
    if (cONTACTDETAIL != null) {
      data['CONTACT_DETAIL'] = cONTACTDETAIL!.toJson();
    }
    if (oTHERDETAIL != null) {
      data['OTHER_DETAIL'] = oTHERDETAIL!.toJson();
    }
    if (fATCADETAIL != null) {
      data['FATCA_DETAIL'] = fATCADETAIL!.toJson();
    }
    return data;
  }
}

class CONTACTDETAIL {
  String? rESISD;
  String? rESSTD;
  String? rESPHONENO;
  String? mOBISDCODE;
  String? pRIMOBNO;
  String? pRIMOBBELONGSTO;
  String? aLTMOBNO;
  String? oFFISD;
  String? oFFSTD;
  String? oFFPHONENO;
  String? pRIEMAIL;
  String? pRIEMAILBELONGSTO;
  String? aLTEMAIL;

  CONTACTDETAIL(
      {this.rESISD,
      this.rESSTD,
      this.rESPHONENO,
      this.mOBISDCODE,
      this.pRIMOBNO,
      this.pRIMOBBELONGSTO,
      this.aLTMOBNO,
      this.oFFISD,
      this.oFFSTD,
      this.oFFPHONENO,
      this.pRIEMAIL,
      this.pRIEMAILBELONGSTO,
      this.aLTEMAIL});

  CONTACTDETAIL.fromJson(Map<String, dynamic> json) {
    rESISD = json['RES_ISD'];
    rESSTD = json['RES_STD'];
    rESPHONENO = json['RES_PHONE_NO'];
    mOBISDCODE = json['MOB_ISD_CODE'];
    pRIMOBNO = json['PRI_MOB_NO'];
    pRIMOBBELONGSTO = json['PRI_MOB_BELONGSTO'];
    aLTMOBNO = json['ALT_MOB_NO'];
    oFFISD = json['OFF_ISD'];
    oFFSTD = json['OFF_STD'];
    oFFPHONENO = json['OFF_PHONE_NO'];
    pRIEMAIL = json['PRI_EMAIL'];
    pRIEMAILBELONGSTO = json['PRI_EMAIL_BELONGSTO'];
    aLTEMAIL = json['ALT_EMAIL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RES_ISD'] = rESISD;
    data['RES_STD'] = rESSTD;
    data['RES_PHONE_NO'] = rESPHONENO;
    data['MOB_ISD_CODE'] = mOBISDCODE;
    data['PRI_MOB_NO'] = pRIMOBNO;
    data['PRI_MOB_BELONGSTO'] = pRIMOBBELONGSTO;
    data['ALT_MOB_NO'] = aLTMOBNO;
    data['OFF_ISD'] = oFFISD;
    data['OFF_STD'] = oFFSTD;
    data['OFF_PHONE_NO'] = oFFPHONENO;
    data['PRI_EMAIL'] = pRIEMAIL;
    data['PRI_EMAIL_BELONGSTO'] = pRIEMAILBELONGSTO;
    data['ALT_EMAIL'] = aLTEMAIL;
    return data;
  }
}

class OTHERDETAIL {
  String? gROSSINCOME;
  String? nETWORTH;
  String? nETDATE;
  String? sOURCEOFWEALTH;
  String? sOURCEOFWEALTHOTH;
  String? kRAADDRTYPE;
  String? oCCUPATION;
  String? oCCUPATIONOTH;
  String? pEP;
  String? aNYOTHINFO;

  OTHERDETAIL(
      {this.gROSSINCOME,
      this.nETWORTH,
      this.nETDATE,
      this.sOURCEOFWEALTH,
      this.sOURCEOFWEALTHOTH,
      this.kRAADDRTYPE,
      this.oCCUPATION,
      this.oCCUPATIONOTH,
      this.pEP,
      this.aNYOTHINFO});

  OTHERDETAIL.fromJson(Map<String, dynamic> json) {
    gROSSINCOME = json['GROSS_INCOME'];
    nETWORTH = json['NET_WORTH'];
    nETDATE = json['NET_DATE'];
    sOURCEOFWEALTH = json['SOURCE_OF_WEALTH'];
    sOURCEOFWEALTHOTH = json['SOURCE_OF_WEALTH_OTH'];
    kRAADDRTYPE = json['KRA_ADDR_TYPE'];
    oCCUPATION = json['OCCUPATION'];
    oCCUPATIONOTH = json['OCCUPATION_OTH'];
    pEP = json['PEP'];
    aNYOTHINFO = json['ANY_OTH_INFO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GROSS_INCOME'] = gROSSINCOME;
    data['NET_WORTH'] = nETWORTH;
    data['NET_DATE'] = nETDATE;
    data['SOURCE_OF_WEALTH'] = sOURCEOFWEALTH;
    data['SOURCE_OF_WEALTH_OTH'] = sOURCEOFWEALTHOTH;
    data['KRA_ADDR_TYPE'] = kRAADDRTYPE;
    data['OCCUPATION'] = oCCUPATION;
    data['OCCUPATION_OTH'] = oCCUPATIONOTH;
    data['PEP'] = pEP;
    data['ANY_OTH_INFO'] = aNYOTHINFO;
    return data;
  }
}

class FATCADETAIL {
  String? bIRTHCITY;
  String? bIRTHCOUNTRY;
  String? bIRTHCOUNTRYOTH;
  String? cITIZENSHIP;
  String? cITIZENSHIPOTH;
  String? nATIONALITY;
  String? nATIONALITYOTH;
  String? tAXRESFLAG;
  TAXSRECORDS? tAXSRECORDS;

  FATCADETAIL(
      {this.bIRTHCITY,
      this.bIRTHCOUNTRY,
      this.bIRTHCOUNTRYOTH,
      this.cITIZENSHIP,
      this.cITIZENSHIPOTH,
      this.nATIONALITY,
      this.nATIONALITYOTH,
      this.tAXRESFLAG,
      this.tAXSRECORDS});

  FATCADETAIL.fromJson(Map<String, dynamic> json) {
    bIRTHCITY = json['BIRTH_CITY'];
    bIRTHCOUNTRY = json['BIRTH_COUNTRY'];
    bIRTHCOUNTRYOTH = json['BIRTH_COUNTRY_OTH'];
    cITIZENSHIP = json['CITIZENSHIP'];
    cITIZENSHIPOTH = json['CITIZENSHIP_OTH'];
    nATIONALITY = json['NATIONALITY'];
    nATIONALITYOTH = json['NATIONALITY_OTH'];
    tAXRESFLAG = json['TAX_RES_FLAG'];
    tAXSRECORDS = json['TAXS_RECORDS'] != null
        ? TAXSRECORDS.fromJson(json['TAXS_RECORDS'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BIRTH_CITY'] = bIRTHCITY;
    data['BIRTH_COUNTRY'] = bIRTHCOUNTRY;
    data['BIRTH_COUNTRY_OTH'] = bIRTHCOUNTRYOTH;
    data['CITIZENSHIP'] = cITIZENSHIP;
    data['CITIZENSHIP_OTH'] = cITIZENSHIPOTH;
    data['NATIONALITY'] = nATIONALITY;
    data['NATIONALITY_OTH'] = nATIONALITYOTH;
    data['TAX_RES_FLAG'] = tAXRESFLAG;
    if (tAXSRECORDS != null) {
      data['TAXS_RECORDS'] = tAXSRECORDS!.toJson();
    }
    return data;
  }
}

class TAXSRECORDS {
  TAXRECORD? tAXRECORD;

  TAXSRECORDS({this.tAXRECORD});

  TAXSRECORDS.fromJson(Map<String, dynamic> json) {
    tAXRECORD = json['TAX_RECORD'] != null
        ? TAXRECORD.fromJson(json['TAX_RECORD'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tAXRECORD != null) {
      data['TAX_RECORD'] = tAXRECORD!.toJson();
    }
    return data;
  }
}

class TAXRECORD {
  int? sEQNUM;
  String? tAXCOUNTRY;
  String? tAXCOUNTRYOTH;
  String? tAXREFNO;
  String? iDENTITYPE;
  String? iDENTITYPEOTH;

  TAXRECORD(
      {this.sEQNUM,
      this.tAXCOUNTRY,
      this.tAXCOUNTRYOTH,
      this.tAXREFNO,
      this.iDENTITYPE,
      this.iDENTITYPEOTH});

  TAXRECORD.fromJson(Map<String, dynamic> json) {
    sEQNUM = json['SEQ_NUM'];
    tAXCOUNTRY = json['TAX_COUNTRY'];
    tAXCOUNTRYOTH = json['TAX_COUNTRY_OTH'];
    tAXREFNO = json['TAX_REF_NO'];
    iDENTITYPE = json['IDENTI_TYPE'];
    iDENTITYPEOTH = json['IDENTI_TYPE_OTH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SEQ_NUM'] = sEQNUM;
    data['TAX_COUNTRY'] = tAXCOUNTRY;
    data['TAX_COUNTRY_OTH'] = tAXCOUNTRYOTH;
    data['TAX_REF_NO'] = tAXREFNO;
    data['IDENTI_TYPE'] = iDENTITYPE;
    data['IDENTI_TYPE_OTH'] = iDENTITYPEOTH;
    return data;
  }
}

class ARNDETAILS {
  String? aRNNO;
  String? rIACODE;
  String? eUINCODE;

  ARNDETAILS({this.aRNNO, this.rIACODE, this.eUINCODE});

  ARNDETAILS.fromJson(Map<String, dynamic> json) {
    aRNNO = json['ARN_NO'];
    rIACODE = json['RIA_CODE'];
    eUINCODE = json['EUIN_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ARN_NO'] = aRNNO;
    data['RIA_CODE'] = rIACODE;
    data['EUIN_CODE'] = eUINCODE;
    return data;
  }
}

class BANKDETAILS {
  BANKRECORD? bANKRECORD;

  BANKDETAILS({this.bANKRECORD});

  BANKDETAILS.fromJson(Map<String, dynamic> json) {
    bANKRECORD = json['BANK_RECORD'] != null
        ? BANKRECORD.fromJson(json['BANK_RECORD'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bANKRECORD != null) {
      data['BANK_RECORD'] = bANKRECORD!.toJson();
    }
    return data;
  }
}

class BANKRECORD {
  int? sEQNUM;
  String? dEFAULTACCFLAG;
  String? aCCOUNTNO;
  String? aCCOUNTTYPE;
  String? bANKID;
  String? mICRCODE;
  String? iFSCCODE;
  int? pROOF;

  BANKRECORD(
      {this.sEQNUM,
      this.dEFAULTACCFLAG,
      this.aCCOUNTNO,
      this.aCCOUNTTYPE,
      this.bANKID,
      this.mICRCODE,
      this.iFSCCODE,
      this.pROOF});

  BANKRECORD.fromJson(Map<String, dynamic> json) {
    sEQNUM = json['SEQ_NUM'];
    dEFAULTACCFLAG = json['DEFAULT_ACC_FLAG'];
    aCCOUNTNO = json['ACCOUNT_NO'];
    aCCOUNTTYPE = json['ACCOUNT_TYPE'];
    bANKID = json['BANK_ID'];
    mICRCODE = json['MICR_CODE'];
    iFSCCODE = json['IFSC_CODE'];
    pROOF = json['PROOF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SEQ_NUM'] = sEQNUM;
    data['DEFAULT_ACC_FLAG'] = dEFAULTACCFLAG;
    data['ACCOUNT_NO'] = aCCOUNTNO;
    data['ACCOUNT_TYPE'] = aCCOUNTTYPE;
    data['BANK_ID'] = bANKID;
    data['MICR_CODE'] = mICRCODE;
    data['IFSC_CODE'] = iFSCCODE;
    data['PROOF'] = pROOF;
    return data;
  }
}

class NOMINEEDETAILS {
  String? nOMDECLLVL;
  String? nOMINOPTFLAG;
  NOMINEESRECORDS? nOMINEESRECORDS;

  NOMINEEDETAILS({this.nOMDECLLVL, this.nOMINOPTFLAG, this.nOMINEESRECORDS});

  NOMINEEDETAILS.fromJson(Map<String, dynamic> json) {
    nOMDECLLVL = json['NOM_DECL_LVL'];
    nOMINOPTFLAG = json['NOMIN_OPT_FLAG'];
    nOMINEESRECORDS = json['NOMINEES_RECORDS'] != null
        ? NOMINEESRECORDS.fromJson(json['NOMINEES_RECORDS'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NOM_DECL_LVL'] = nOMDECLLVL;
    data['NOMIN_OPT_FLAG'] = nOMINOPTFLAG;
    if (nOMINEESRECORDS != null) {
      data['NOMINEES_RECORDS'] = nOMINEESRECORDS!.toJson();
    }
    return data;
  }
}

class NOMINEESRECORDS {
  NOMINEERECORD? nOMINEERECORD;

  NOMINEESRECORDS({this.nOMINEERECORD});

  NOMINEESRECORDS.fromJson(Map<String, dynamic> json) {
    nOMINEERECORD = json['NOMINEE_RECORD'] != null
        ? NOMINEERECORD.fromJson(json['NOMINEE_RECORD'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nOMINEERECORD != null) {
      data['NOMINEE_RECORD'] = nOMINEERECORD!.toJson();
    }
    return data;
  }
}

class NOMINEERECORD {
  int? sEQNUM;
  String? nOMINEENAME;
  String? rELATION;
  String? pERCENTAGE;
  String? dOB;
  String? nOMGURINAME;
  String? nOMGURIREL;
  String? nOMGURIDOB;

  NOMINEERECORD(
      {this.sEQNUM,
      this.nOMINEENAME,
      this.rELATION,
      this.pERCENTAGE,
      this.dOB,
      this.nOMGURINAME,
      this.nOMGURIREL,
      this.nOMGURIDOB});

  NOMINEERECORD.fromJson(Map<String, dynamic> json) {
    sEQNUM = json['SEQ_NUM'];
    nOMINEENAME = json['NOMINEE_NAME'];
    rELATION = json['RELATION'];
    pERCENTAGE = json['PERCENTAGE'];
    dOB = json['DOB'];
    nOMGURINAME = json['NOM_GURI_NAME'];
    nOMGURIREL = json['NOM_GURI_REL'];
    nOMGURIDOB = json['NOM_GURI_DOB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SEQ_NUM'] = sEQNUM;
    data['NOMINEE_NAME'] = nOMINEENAME;
    data['RELATION'] = rELATION;
    data['PERCENTAGE'] = pERCENTAGE;
    data['DOB'] = dOB;
    data['NOM_GURI_NAME'] = nOMGURINAME;
    data['NOM_GURI_REL'] = nOMGURIREL;
    data['NOM_GURI_DOB'] = nOMGURIDOB;
    return data;
  }
}
