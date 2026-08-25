import '../../data/model/HoldingResponseModel.dart';

class HoldingResponseParams {
  String status;
  String errorCode;
  String message;
  String iv;
  String data;
  HoldingResponseRecords? items;

  HoldingResponseParams({
    required this.status,
    required this.errorCode,
    required this.message,
    required this.iv,
    required this.data,
    this.items,
  });
}

class HoldingResponseRecordsParams {
  String? merchantCode;
  String? messageSeq;
  String? requestDateTime;
  String? dpReferenceNo;
  String? dpid;
  String? dpAccount;
  String? responseCode;
  String? errorCode;
  String? errorMessage;

  /// The actual per-ISIN stock holding entries.
  List<Record>? records;

  HoldingResponseRecordsParams({
    required this.merchantCode,
    required this.messageSeq,
    required this.requestDateTime,
    required this.dpReferenceNo,
    required this.dpid,
    required this.dpAccount,
    required this.responseCode,
    required this.errorCode,
    required this.errorMessage,
    required this.records,
  });
}

class Record {
  String isin;
  String companyName;
  int totalQty;
  int blockedQty;
  int underProcess;
  int marginPledgeQty;
  int freeQty;
  int mtfpledgeQty;
  String nseSymbol;
  String nseScriptCode;
  String nseSeries;
  String bseSymbol;
  String bseScriptCode;
  String bseSeries;

  Record({
    required this.isin,
    required this.companyName,
    required this.totalQty,
    required this.blockedQty,
    required this.underProcess,
    required this.marginPledgeQty,
    required this.freeQty,
    required this.mtfpledgeQty,
    required this.nseSymbol,
    required this.nseScriptCode,
    required this.nseSeries,
    required this.bseSymbol,
    required this.bseScriptCode,
    required this.bseSeries,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      isin: json['isin'] ?? '',
      companyName: json['companyName'] ?? '',
      totalQty: json['totalQty'] ?? 0,
      blockedQty: json['blockedQty'] ?? 0,
      underProcess: json['underProcess'] ?? 0,
      marginPledgeQty: json['marginPledgeQty'] ?? 0,
      freeQty: json['freeQty'] ?? 0,
      mtfpledgeQty: json['mtfpledgeQty'] ?? 0,
      nseSymbol: json['nseSymbol'] ?? '',
      nseScriptCode: json['nseScriptCode'] ?? '',
      nseSeries: json['nseSeries'] ?? '',
      bseSymbol: json['bseSymbol'] ?? '',
      bseScriptCode: json['bseScriptCode'] ?? '',
      bseSeries: json['bseSeries'] ?? '',
    );
  }
}