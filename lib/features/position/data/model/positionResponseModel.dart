import 'package:stockholding/features/position/domain/entity/positionResponse_parmams.dart';

class PositionResponseModel extends PositionResponseParams {
  PositionResponseModel({
    required super.status,
    required super.errorCode,
    required super.message,
    required super.iv,
    required super.data,
    super.items,
  });

  factory PositionResponseModel.fromRawJson(Map<String, dynamic> json) {
    return PositionResponseModel(
      status: json['status'] as String? ?? '',
      errorCode: json['error_code'] as String? ?? '',
      message: json['message'] as String? ?? '',
      iv: json['iv'] as String? ?? '',
      data: json['data'] as String? ?? '',
    );
  }

  /// Parses raw fields AND attaches the decrypted, parsed watchlist items.
  factory PositionResponseModel.fromDecrypted({
    required Map<String, dynamic> rawJson,
    required List<dynamic> decryptedList,
  }) {
    return PositionResponseModel(
      status: rawJson['status'] as String? ?? '',
      errorCode: rawJson['error_code'] as String? ?? '',
      message: rawJson['message'] as String? ?? '',
      iv: rawJson['iv'] as String? ?? '',
      data: rawJson['data'] as String? ?? '',
      items: decryptedList
          .map((e) => PositonItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PositonItemModel extends PositonItem {
  PositonItemModel({
    required super.securityId,
    required super.symbol,
    required super.exchange,
    required super.strikePrice,

    required super.buyAvg,

    required super.grossQty,

    required super.exchangeIdentity,
    required super.instrumentIdentity,
  });

  factory PositonItemModel.fromJson(Map<String, dynamic> json) =>
      PositonItemModel(
        securityId: json["security_id"],
        symbol: json["symbol"],
        exchange: json["exchange"],
        strikePrice: json["strike_price"],
        buyAvg: json["buy_avg"],
        grossQty: json["gross_qty"],
        exchangeIdentity: ExchangeIdentityItem.fromJson(
          json["exchangeIdentity"],
        ),
        instrumentIdentity: InstrumentIdentityItem.fromJson(
          json["instrumentIdentity"],
        ),
      );
}

class ExchangeIdentity {
  int exchangeIdType;
  String exchangeId;

  ExchangeIdentity({required this.exchangeIdType, required this.exchangeId});

  factory ExchangeIdentity.fromJson(Map<String, dynamic> json) =>
      ExchangeIdentity(
        exchangeIdType: json["exchangeIdType"],
        exchangeId: json["exchangeId"],
      );
}

class InstrumentIdentity {
  int instrumentSegment;
  int instrumentType;
  int instrumentIdType;
  String instrumentId;

  InstrumentIdentity({
    required this.instrumentSegment,
    required this.instrumentType,
    required this.instrumentIdType,
    required this.instrumentId,
  });

  factory InstrumentIdentity.fromJson(Map<String, dynamic> json) =>
      InstrumentIdentity(
        instrumentSegment: json["instrumentSegment"],
        instrumentType: json["instrumentType"],
        instrumentIdType: json["instrumentIdType"],
        instrumentId: json["instrumentId"],
      );
}
