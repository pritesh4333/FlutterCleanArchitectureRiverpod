import '../../data/model/positionResponseModel.dart';

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

  PositionResponseParams copyWithDecrypted({
    required List<PositonItem> items,
  }) {
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
class PositonItem {
  String clientId;
  String securityId;
  String instrument;
  String symbol;
  String exchange;
  String expiryDate;
  String strikePrice;
  String optType;
  int totBuyQty;
  int totBuyVal;
  int buyAvg;
  int totSellQty;
  double totSellVal;
  double sellAvg;
  int netQty;
  double netVal;
  double netAvg;
  int grossQty;
  double grossVal;
  String segment;
  String mktType;
  String product;
  int lotSize;
  double lastTradedPrice;
  int realisedProfit;
  int mtm;
  int rbiReferenceRate;
  String crossCurFlag;
  int commMultiplier;
  int totBuyQtyCf;
  int totSellQtyCf;
  int totBuyValCf;
  int totSellValCf;
  int totBuyQtyDay;
  int totBuyValDay;
  int totSellQtyDay;
  int totSellValDay;
  String isin;
  String series;
  String displayName;
  String exchangeInstName;
  double costPrice;
  String underlaying;
  String fullSymbol;
  String refId;
  String exchInstrumentType;
  ExchangeIdentity exchangeIdentity;
  InstrumentIdentity instrumentIdentity;

  PositonItem({
    required this.clientId,
    required this.securityId,
    required this.instrument,
    required this.symbol,
    required this.exchange,
    required this.expiryDate,
    required this.strikePrice,
    required this.optType,
    required this.totBuyQty,
    required this.totBuyVal,
    required this.buyAvg,
    required this.totSellQty,
    required this.totSellVal,
    required this.sellAvg,
    required this.netQty,
    required this.netVal,
    required this.netAvg,
    required this.grossQty,
    required this.grossVal,
    required this.segment,
    required this.mktType,
    required this.product,
    required this.lotSize,
    required this.lastTradedPrice,
    required this.realisedProfit,
    required this.mtm,
    required this.rbiReferenceRate,
    required this.crossCurFlag,
    required this.commMultiplier,
    required this.totBuyQtyCf,
    required this.totSellQtyCf,
    required this.totBuyValCf,
    required this.totSellValCf,
    required this.totBuyQtyDay,
    required this.totBuyValDay,
    required this.totSellQtyDay,
    required this.totSellValDay,
    required this.isin,
    required this.series,
    required this.displayName,
    required this.exchangeInstName,
    required this.costPrice,
    required this.underlaying,
    required this.fullSymbol,
    required this.refId,
    required this.exchInstrumentType,
    required this.exchangeIdentity,
    required this.instrumentIdentity,
  });

}

class ExchangeIdentityItem {
  int exchangeIdType;
  String exchangeId;

  ExchangeIdentityItem({
    required this.exchangeIdType,
    required this.exchangeId,
  });

}

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

}

