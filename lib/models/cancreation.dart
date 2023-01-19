class CanIndFillEezzReq {
  late ReqHeader reqHeader;
  late ReqBody reqBody;
  static const String xmlnsXsi = "http://www.w3.org/2001/XMLSchema-instance";
  static const String xsiNoNamespaceSchemaLocation = "CANIndFillEezzReq.xsd";
}

class ReqBody {
  ReqBody({
    required this.reqEvent,
    required this.can,
    required this.regType,
    required this.proofUploadByCan,
    required this.enableOnlineAccessFlag,
    required this.entityEmailDetails,
    required this.holdingType,
    required this.invCategory,
    required this.taxStatus,
    required this.holderCount,
    required this.holderRecords,
    required this.arnDetails,
    required this.bankDetails,
    required this.nomineeDetails,
  });

  String reqEvent;
  String can;
  String regType;
  String proofUploadByCan;
  String enableOnlineAccessFlag;
  EntityEmailDetails entityEmailDetails;
  String holdingType;
  String invCategory;
  String taxStatus;
  String holderCount;
  HolderRecords holderRecords;
  ArnDetails arnDetails;
  BankDetails bankDetails;
  NomineeDetails nomineeDetails;
}

class ArnDetails {
  ArnDetails({
    required this.arnNo,
    required this.riaCode,
    required this.euinCode,
  });

  String arnNo;
  String riaCode;
  String euinCode;
}

class BankDetails {
  BankDetails({
    required this.bankRecord,
  });

  BankRecord bankRecord;
}

class BankRecord {
  BankRecord({
    required this.seqNum,
    required this.defaultAccFlag,
    required this.accountNo,
    required this.accountType,
    required this.bankId,
    required this.micrCode,
    required this.ifscCode,
    required this.proof,
  });

  String seqNum;
  String defaultAccFlag;
  String accountNo;
  String accountType;
  String bankId;
  String micrCode;
  String ifscCode;
  String proof;
}

class EntityEmailDetails {
  EntityEmailDetails({
    required this.emailId,
  });

  List<String> emailId;
}

class HolderRecords {
  HolderRecords({
    required this.holderRecord,
  });

  HolderRecord holderRecord;
}

class HolderRecord {
  HolderRecord({
    required this.holderType,
    required this.name,
    required this.dob,
    required this.panExemptFlag,
    required this.panPekrnNo,
    required this.aadhaarNo,
    required this.relationship,
    required this.relProof,
    required this.contactDetail,
    required this.otherDetail,
    required this.fatcaDetail,
  });

  String holderType;
  String name;
  DateTime dob;
  String panExemptFlag;
  String panPekrnNo;
  String aadhaarNo;
  String relationship;
  String relProof;
  ContactDetail contactDetail;
  OtherDetail otherDetail;
  FatcaDetail fatcaDetail;
}

class ContactDetail {
  ContactDetail({
    required this.resIsd,
    required this.resStd,
    required this.resPhoneNo,
    required this.mobIsdCode,
    required this.priMobNo,
    required this.priMobBelongsto,
    required this.altMobNo,
    required this.offIsd,
    required this.offStd,
    required this.offPhoneNo,
    required this.priEmail,
    required this.priEmailBelongsto,
    required this.altEmail,
  });

  String resIsd;
  String resStd;
  String resPhoneNo;
  String mobIsdCode;
  String priMobNo;
  String priMobBelongsto;
  String altMobNo;
  String offIsd;
  String offStd;
  String offPhoneNo;
  String priEmail;
  String priEmailBelongsto;
  String altEmail;
}

class FatcaDetail {
  FatcaDetail({
    required this.birthCity,
    required this.birthCountry,
    required this.birthCountryOth,
    required this.citizenship,
    required this.citizenshipOth,
    required this.nationality,
    required this.nationalityOth,
    required this.taxResFlag,
    required this.taxsRecords,
  });

  String birthCity;
  String birthCountry;
  String birthCountryOth;
  String citizenship;
  String citizenshipOth;
  String nationality;
  String nationalityOth;
  String taxResFlag;
  TaxsRecords taxsRecords;
}

class TaxsRecords {
  TaxsRecords();
}

class OtherDetail {
  OtherDetail({
    required this.grossIncome,
    required this.netWorth,
    required this.netDate,
    required this.sourceOfWealth,
    required this.sourceOfWealthOth,
    required this.kraAddrType,
    required this.occupation,
    required this.occupationOth,
    required this.pep,
    required this.anyOthInfo,
  });

  String grossIncome;
  String netWorth;
  String netDate;
  String sourceOfWealth;
  String sourceOfWealthOth;
  String kraAddrType;
  String occupation;
  String occupationOth;
  String pep;
  String anyOthInfo;
}

class NomineeDetails {
  NomineeDetails({
    required this.nominOptFlag,
    required this.nomDeclLvl,
    required this.nomineesRecords,
  });

  String nominOptFlag;
  String nomDeclLvl;
  NomineesRecords nomineesRecords;
}

class NomineesRecords {
  NomineesRecords({
    required this.nomineeRecord,
  });

  NomineeRecord nomineeRecord;
}

class NomineeRecord {
  NomineeRecord({
    required this.seqNum,
    required this.nomineeName,
    required this.relation,
    required this.percentage,
    required this.dob,
    required this.nomGuriName,
    required this.nomGuriRel,
    required this.nomGuriDob,
  });

  String seqNum;
  String nomineeName;
  String relation;
  String percentage;
  DateTime dob;
  String nomGuriName;
  String nomGuriRel;
  String nomGuriDob;
}

class ReqHeader {
  ReqHeader({
    required this.entityId,
    required this.uniqueId,
    required this.requestType,
    required this.logUserId,
    required this.enEncrPassword,
    required this.versionNo,
    required this.timestamp,
  });

  String entityId;
  String uniqueId;
  String requestType;
  String logUserId;
  String enEncrPassword;
  String versionNo;
  DateTime timestamp;
}
