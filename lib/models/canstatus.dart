class CanDataStatusReq {
  CanDataStatusReq({
    required this.reqHeader,
    required this.reqBody,
    required this.xmlnsXsi,
    required this.xsiNoNamespaceSchemaLocation,
  });

  ReqHeader reqHeader;
  ReqBody reqBody;
  String xmlnsXsi;
  String xsiNoNamespaceSchemaLocation;
}

class ReqBody {
  ReqBody({
    required this.can,
  });

  String can;
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
