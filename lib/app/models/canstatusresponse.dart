class CanDataStatusResp {
  CanDataStatusResp({
    required this.respHeader,
    required this.respBody,
    required this.xmlnsXsi,
    required this.xsiNoNamespaceSchemaLocation,
  });

  RespHeader respHeader;
  RespBody respBody;
  String xmlnsXsi;
  String xsiNoNamespaceSchemaLocation;
}

class RespBody {
  RespBody({
    required this.can,
    required this.proofUploadLink,
    required this.nomVerLinkH1,
    required this.nomVerLinkH2,
    required this.nomVerLinkH3,
    required this.msg,
    required this.canStatus,
    required this.blockResps,
  });

  String can;
  String proofUploadLink;
  String nomVerLinkH1;
  String nomVerLinkH2;
  String nomVerLinkH3;
  String msg;
  String canStatus;
  BlockResps blockResps;
}

class BlockResps {
  BlockResps({
    required this.blockDetail,
    required this.blockCount,
  });

  BlockDetail blockDetail;
  String blockCount;
}

class BlockDetail {
  BlockDetail({
    required this.blockName,
    required this.blockSubName,
    required this.seqNo,
    required this.respCode,
    required this.respMsg,
    required this.rowNum,
  });

  String blockName;
  String blockSubName;
  String seqNo;
  String respCode;
  String respMsg;
  String rowNum;
}

class RespHeader {
  RespHeader({
    required this.entityId,
    required this.uniqueId,
    required this.requestType,
    required this.versionNo,
    required this.timestamp,
  });

  String entityId;
  String uniqueId;
  String requestType;
  String versionNo;
  DateTime timestamp;
}
