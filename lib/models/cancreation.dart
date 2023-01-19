class CanIndFillEezzReq {
  late ReqHeader reqHeader = ReqHeader();
  late ReqBody reqBody = ReqBody();
  static const String xmlnsXsi = "http://www.w3.org/2001/XMLSchema-instance";
  static const String xsiNoNamespaceSchemaLocation = "CANIndFillEezzReq.xsd";
}

class ReqBody {
  late String reqEvent;
  late String can;
  late String regType;
  late String proofUploadByCan;
  late String enableOnlineAccessFlag;
  late EntityEmailDetails entityEmailDetails = EntityEmailDetails();
  late String holdingType;
  late String invCategory;
  late String taxStatus;
  late String holderCount;
  late HolderRecords holderRecords = HolderRecords();
  late ArnDetails arnDetails = ArnDetails();
  late BankDetails bankDetails = BankDetails();
  late NomineeDetails nomineeDetails = NomineeDetails();
}

class ArnDetails {
  late String arnNo;
  late String riaCode;
  late String euinCode;
}

class BankDetails {
  late BankRecord bankRecord = BankRecord();
}

class BankRecord {
  late String seqNum;
  late String defaultAccFlag;
  late String accountNo;
  late String accountType;
  late String bankId;
  late String micrCode;
  late String ifscCode;
  late String proof;
}

class EntityEmailDetails {
  late List<String> emailId;
}

class HolderRecords {
  late HolderRecord holderRecord = HolderRecord();
}

class HolderRecord {
  late String holderType;
  late String name;
  late DateTime dob;
  late String panExemptFlag;
  late String panPekrnNo;
  late String aadhaarNo;
  late String relationship;
  late String relProof;
  late ContactDetail contactDetail = ContactDetail();
  late OtherDetail otherDetail = OtherDetail();
  late FatcaDetail fatcaDetail = FatcaDetail();
}

class ContactDetail {
  late String resIsd;
  late String resStd;
  late String resPhoneNo;
  late String mobIsdCode;
  late String priMobNo;
  late String priMobBelongsto;
  late String altMobNo;
  late String offIsd;
  late String offStd;
  late String offPhoneNo;
  late String priEmail;
  late String priEmailBelongsto;
  late String altEmail;
}

class FatcaDetail {
  late String birthCity;
  late String birthCountry;
  late String birthCountryOth;
  late String citizenship;
  late String citizenshipOth;
  late String nationality;
  late String nationalityOth;
  late String taxResFlag;
  late TaxsRecords taxsRecords = TaxsRecords();
}

class TaxsRecords {
  late List<TaxsRecord> taxsrecord;
}

class TaxsRecord {
  late String seqNum;
  late String taxCountry;
  late String taxCountryOth;
  late String taxRefNo;
  late String identiType;
  late String identiTypeOth;
}

class OtherDetail {
  late String grossIncome;
  late String netWorth;
  late String netDate;
  late String sourceOfWealth;
  late String sourceOfWealthOth;
  late String kraAddrType;
  late String occupation;
  late String occupationOth;
  late String pep;
  late String anyOthInfo;
}

class NomineeDetails {
  late String nominOptFlag;
  late String nomDeclLvl;
  late NomineesRecords nomineesRecords = NomineesRecords();
}

class NomineesRecords {
  late NomineeRecord nomineeRecord = NomineeRecord();
}

class NomineeRecord {
  late String seqNum;
  late String nomineeName;
  late String relation;
  late String percentage;
  late DateTime dob;
  late String nomGuriName;
  late String nomGuriRel;
  late String nomGuriDob;
}

class ReqHeader {
  late String entityId;
  late String uniqueId;
  late String requestType;
  late String logUserId;
  late String enEncrPassword;
  late String versionNo;
  late DateTime timestamp;
}
