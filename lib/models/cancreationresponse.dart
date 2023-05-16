class CanIndFillEezzResp {
  CanIndFillEezzResp({
    required this.respHeader,
    required this.respBody,
  });

  RespHeader respHeader;
  RespBody respBody;
}

class RespBody {
  RespBody({
    required this.can,
    required this.proofUploadLink,
    required this.nomVerLinkH1,
    required this.nomVerLinkH2,
    required this.nomVerLinkH3,
  });

  String can;
  String proofUploadLink;
  String nomVerLinkH1;
  String nomVerLinkH2;
  String nomVerLinkH3;
}

class RespHeader {
  RespHeader({
    required this.entityId,
    required this.uniqueId,
    required this.requestType,
    required this.versionNo,
    required this.timestamp,
    required this.resCode,
    required this.resMsg,
  });

  String entityId;
  String uniqueId;
  String requestType;
  String versionNo;
  DateTime timestamp;
  String resCode;
  String resMsg;
}
