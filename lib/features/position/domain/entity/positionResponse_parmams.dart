import '../../data/model/positionResponseModel.dart';

// ---------- Safe parsing helpers ----------
// APIs are inconsistent about returning 0 as int vs 0.0 as double,
// or numbers as strings — these guards prevent type-cast crashes.

double _parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

int _parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

String _parseString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}

// ---------- PositionResponseParams ----------

class PositionResponseParams {
  final String status;
  final String errorCode;
  final String message;
  final String iv;
  final String data; // raw encrypted string, kept for reference/debugging

  /// Populated by the presentation/datasource after decrypting `data`.
  /// Empty until that happens (or on failure).
  final List<PositonItem> items;

  const PositionResponseParams({
    required this.status,
    required this.errorCode,
    required this.message,
    required this.iv,
    required this.data,
    this.items = const [],
  });

  bool get isSuccess => status.toLowerCase().trim() == 'success';

  factory PositionResponseParams.fromJson(Map<String, dynamic> json) {
    return PositionResponseParams(
      status: _parseString(json['status']),
      errorCode: _parseString(json['errorCode']),
      message: _parseString(json['message']),
      iv: _parseString(json['iv']),
      data: _parseString(json['data']),
    );
  }

  PositionResponseParams copyWithDecrypted({required List<PositonItem> items}) {
    return PositionResponseParams(
      status: status,
      errorCode: errorCode,
      message: message,
      iv: iv,
      data: data,
      items: items,
    );
  }
}

// ---------- PositonItem ----------

class PositonItem {
  String securityId;
  String symbol;
  String exchange;
  String strikePrice;
  double buyAvg;
  int grossQty;

  ExchangeIdentityItem exchangeIdentity;
  InstrumentIdentityItem instrumentIdentity;

  PositonItem({
    required this.securityId,
    required this.symbol,
    required this.exchange,
    required this.strikePrice,
    required this.buyAvg,
    required this.grossQty,
    required this.exchangeIdentity,
    required this.instrumentIdentity,
  });

  factory PositonItem.fromJson(Map<String, dynamic> json) {
    return PositonItem(
      securityId: _parseString(json['security_id']),
      symbol: _parseString(json['symbol']),
      exchange: _parseString(json['exchange']),
      strikePrice: _parseString(json['strike_price']),

      buyAvg: _parseDouble(json['buy_avg']),

      grossQty: _parseInt(json['gross_qty']),

      exchangeIdentity: ExchangeIdentityItem.fromJson(
        json['exchangeIdentity'] as Map<String, dynamic>? ?? {},
      ),
      instrumentIdentity: InstrumentIdentityItem.fromJson(
        json['instrumentIdentity'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

// ---------- ExchangeIdentityItem ----------

class ExchangeIdentityItem {
  int exchangeIdType;
  String exchangeId;

  ExchangeIdentityItem({
    required this.exchangeIdType,
    required this.exchangeId,
  });

  factory ExchangeIdentityItem.fromJson(Map<String, dynamic> json) {
    return ExchangeIdentityItem(
      exchangeIdType: _parseInt(json['exchangeIdType']),
      exchangeId: _parseString(json['exchangeId']),
    );
  }
}

// ---------- InstrumentIdentityItem ----------

class InstrumentIdentityItem {
  int instrumentSegment;
  int instrumentType;
  int instrumentIdType;
  String instrumentId;

  InstrumentIdentityItem({
    required this.instrumentSegment,
    required this.instrumentType,
    required this.instrumentIdType,
    required this.instrumentId,
  });

  factory InstrumentIdentityItem.fromJson(Map<String, dynamic> json) {
    return InstrumentIdentityItem(
      instrumentSegment: _parseInt(json['instrumentSegment']),
      instrumentType: _parseInt(json['instrumentType']),
      instrumentIdType: _parseInt(json['instrumentIdType']),
      instrumentId: _parseString(json['instrumentId']),
    );
  }
}
