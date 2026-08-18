import '../../domain/entity/WLResponse_parmams.dart';

class WLResponseModelParams extends WlResponseParams {
  WLResponseModelParams({
    required super.status,
    required super.errorCode,
    required super.message,
    required super.iv,
    required super.data,
    super.items,
  });

  /// Parses only the top-level fields — used when status != success,
  /// since there's no encrypted payload worth decrypting in that case.
  factory WLResponseModelParams.fromRawJson(Map<String, dynamic> json) {
    return WLResponseModelParams(
      status: json['status'] as String? ?? '',
      errorCode: json['error_code'] as String? ?? '',
      message: json['message'] as String? ?? '',
      iv: json['iv'] as String? ?? '',
      data: json['data'] as String? ?? '',
    );
  }

  /// Parses raw fields AND attaches the decrypted, parsed watchlist items.
  factory WLResponseModelParams.fromDecrypted({
    required Map<String, dynamic> rawJson,
    required List<dynamic> decryptedList,
  }) {
    return WLResponseModelParams(
      status: rawJson['status'] as String? ?? '',
      errorCode: rawJson['error_code'] as String? ?? '',
      message: rawJson['message'] as String? ?? '',
      iv: rawJson['iv'] as String? ?? '',
      data: rawJson['data'] as String? ?? '',
      items: decryptedList
          .map((e) => WatchlistItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class WatchlistItemModel extends WatchlistItem {
  WatchlistItemModel({
    required super.symbol,
    required super.segment,
    required super.exchange,
    required super.secId,
    required super.isinCode,
    required super.tick,
    required super.lot,
    required super.upperLimit,
    required super.lowerLimit,
    required super.expDate,
    required super.strikePrice,
    required super.optType,
    required super.instrument,
    required super.refLtp,
  });

  factory WatchlistItemModel.fromJson(Map<String, dynamic> json) {
    return WatchlistItemModel(
      symbol: json['SYMBOL'] as String? ?? '',
      segment: json['SEGMENT'] as String? ?? '',
      exchange: json['EXCHANGE'] as String? ?? '',
      secId: json['SEC_ID'] as String? ?? '',
      isinCode: json['ISIN_CODE'] as String? ?? '',
      tick: json['TICK'] as String? ?? '',
      lot: json['LOT'] as String? ?? '',
      upperLimit: json['UPPER_LIMIT'] as String? ?? '',
      lowerLimit: json['LOWER_LIMIT'] as String? ?? '',
      expDate: json['EXP_DATE'] as String? ?? '',
      strikePrice: json['STRIKE_PRICE'] as String? ?? '',
      optType: json['OPT_TYPE'] as String? ?? '',
      instrument: json['INSTRUMENT'] as String? ?? '',
      refLtp: json['REF_LTP'] as String? ?? '',
    );
  }
}