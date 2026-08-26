import '../../domain/entity/sipBookResponse_params.dart';

class SipBookItemResponseModel extends SipBookResponseParams {
  SipBookItemResponseModel({
    required super.status,
    required super.errorCode,
    required super.message,
    required super.iv,
    required super.data,
    super.items,
  });

  factory SipBookItemResponseModel.fromRawJson(Map<String, dynamic> json) {
    return SipBookItemResponseModel(
      status: json['status'] as String? ?? '',
      errorCode: json['error_code'] as String? ?? '',
      message: json['message'] as String? ?? '',
      iv: json['iv'] as String? ?? '',
      data: json['data'] as String? ?? '',
    );
  }

  /// Parses raw fields AND attaches the decrypted, parsed SIP items.
  factory SipBookItemResponseModel.fromDecrypted({
    required Map<String, dynamic> rawJson,
    required List<dynamic> decryptedList,
  }) {
    return SipBookItemResponseModel(
      status: rawJson['status'] as String? ?? '',
      errorCode: rawJson['error_code'] as String? ?? '',
      message: rawJson['message'] as String? ?? '',
      iv: rawJson['iv'] as String? ?? '',
      data: rawJson['data'] as String? ?? '',
      items: decryptedList
          .map((e) => SipBookItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SipBookItemModel extends SipBookItem {
  const SipBookItemModel({
    required super.serialNo,
    required super.clientId,
    required super.orderNumber,
    required super.exchange,
    required super.orderDateTime,
    required super.startDateTime,
    required super.endDateTime,
    required super.frequency,
    required super.txnType,
    required super.product,
    required super.segment,
    required super.securityId,
    required super.symbol,
    required super.period,
    required super.totalQuantity,
    required super.entityId,
    required super.sourceName,
    required super.status,
    required super.orderValidity,
    required super.reasonDescription,
    required super.lastTriggerDate,
    required super.nextTriggerDate,
    required super.panNo,
    required super.participantType,
    required super.mktProFlag,
    required super.mktProValue,
    required super.settlor,
    required super.goodTillDaysFlag,
    required super.encashFlag,
    required super.amount,
    required super.orderType,
    required super.r,
    required super.templateName,
  });

  factory SipBookItemModel.fromJson(Map<String, dynamic> json) =>
      SipBookItemModel(
        serialNo: json["serial_no"]?.toString() ?? "",
        clientId: json["client_id"]?.toString() ?? "",
        orderNumber: json["order_number"]?.toString() ?? "",
        exchange: json["exchange"]?.toString() ?? "",
        orderDateTime: json["order_date_time"]?.toString() ?? "",
        startDateTime: json["start_date_time"]?.toString() ?? "",
        endDateTime: json["end_date_time"]?.toString() ?? "",
        frequency: json["frequency"]?.toString() ?? "",
        txnType: json["txn_type"]?.toString() ?? "",
        product: json["product"]?.toString() ?? "",
        segment: json["segment"]?.toString() ?? "",
        securityId: json["security_id"]?.toString() ?? "",
        symbol: json["symbol"]?.toString() ?? "",
        period: json["period"]?.toString() ?? "",
        totalQuantity: json["total_quantity"]?.toString() ?? "",
        entityId: json["entity_id"]?.toString() ?? "",
        sourceName: json["source_name"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "",
        orderValidity: json["order_validity"]?.toString() ?? "",
        reasonDescription: json["reason_description"]?.toString() ?? "",
        lastTriggerDate: json["last_trigger_date"]?.toString() ?? "",
        nextTriggerDate: json["next_trigger_date"]?.toString() ?? "",
        panNo: json["pan_no"]?.toString() ?? "",
        participantType: json["participant_type"]?.toString() ?? "",
        mktProFlag: json["mkt_pro_flag"]?.toString() ?? "",
        mktProValue: json["mkt_pro_value"]?.toString() ?? "",
        settlor: json["settlor"]?.toString() ?? "",
        goodTillDaysFlag: json["good_till_days_flag"]?.toString() ?? "",
        encashFlag: json["encash_flag"]?.toString() ?? "",
        amount: json["amount"]?.toString() ?? "",
        orderType: json["order_type"]?.toString() ?? "",
        r: (json["R"] ?? json["r"])?.toString() ?? "",
        templateName: (json["templateName"] ?? json["template_name"])?.toString() ?? "",
      );
}

