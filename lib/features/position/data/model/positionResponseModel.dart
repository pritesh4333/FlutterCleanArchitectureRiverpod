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
    required super.clientId,
    required super.securityId,
    required super.instrument,
    required super.symbol,
    required super.exchange,
    required super.expiryDate,
    required super.strikePrice,
    required super.optType,
    required super.totBuyQty,
    required super.totBuyVal,
    required super.buyAvg,
    required super.totSellQty,
    required super.totSellVal,
    required super.sellAvg,
    required super.netQty,
    required super.netVal,
    required super.netAvg,
    required super.grossQty,
    required super.grossVal,
    required super.segment,
    required super.mktType,
    required super.product,
    required super.lotSize,
    required super.lastTradedPrice,
    required super.realisedProfit,
    required super.mtm,
    required super.rbiReferenceRate,
    required super.crossCurFlag,
    required super.commMultiplier,
    required super.totBuyQtyCf,
    required super.totSellQtyCf,
    required super.totBuyValCf,
    required super.totSellValCf,
    required super.totBuyQtyDay,
    required super.totBuyValDay,
    required super.totSellQtyDay,
    required super.totSellValDay,
    required super.isin,
    required super.series,
    required super.displayName,
    required super.exchangeInstName,
    required super.costPrice,
    required super.underlaying,
    required super.fullSymbol,
    required super.refId,
    required super.exchInstrumentType,
    required super.exchangeIdentity,
    required super.instrumentIdentity,
  });
  factory PositonItemModel.fromJson(Map<String, dynamic> json) =>
      PositonItemModel(
        clientId: json["client_id"],
        securityId: json["security_id"],
        instrument: json["instrument"],
        symbol: json["symbol"],
        exchange: json["exchange"],
        expiryDate: json["expiry_date"],
        strikePrice: json["strike_price"],
        optType: json["opt_type"],
        totBuyQty: json["tot_buy_qty"],
        totBuyVal: json["tot_buy_val"],
        buyAvg: json["buy_avg"],
        totSellQty: json["tot_sell_qty"],
        totSellVal: json["tot_sell_val"],
        sellAvg: json["sell_avg"],
        netQty: json["net_qty"],
        netVal: json["net_val"],
        netAvg: json["net_avg"],
        grossQty: json["gross_qty"],
        grossVal: json["gross_val"],
        segment: json["segment"],
        mktType: json["mkt_type"],
        product: json["product"],
        lotSize: json["lot_size"],
        lastTradedPrice: json["last_traded_price"]?.toDouble(),
        realisedProfit: json["realised_profit"],
        mtm: json["mtm"],
        rbiReferenceRate: json["rbi_reference_rate"],
        crossCurFlag: json["cross_cur_flag"],
        commMultiplier: json["comm_multiplier"],
        totBuyQtyCf: json["tot_buy_qty_cf"],
        totSellQtyCf: json["tot_sell_qty_cf"],
        totBuyValCf: json["tot_buy_val_cf"],
        totSellValCf: json["tot_sell_val_cf"],
        totBuyQtyDay: json["tot_buy_qty_day"],
        totBuyValDay: json["tot_buy_val_day"],
        totSellQtyDay: json["tot_sell_qty_day"],
        totSellValDay: json["tot_sell_val_day"],
        isin: json["isin"],
        series: json["series"],
        displayName: json["display_name"],
        exchangeInstName: json["exchange_inst_name"],
        costPrice: json["cost_price"],
        underlaying: json["underlaying"],
        fullSymbol: json["FULL_SYMBOL"],
        refId: json["ref_id"],
        exchInstrumentType: json["exch_instrument_type"],
        exchangeIdentity: ExchangeIdentity.fromJson(json["exchangeIdentity"]),
        instrumentIdentity: InstrumentIdentity.fromJson(json["instrumentIdentity"]),
      );

}
class ExchangeIdentity {
  int exchangeIdType;
  String exchangeId;

  ExchangeIdentity({
    required this.exchangeIdType,
    required this.exchangeId,
  });

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
  factory InstrumentIdentity.fromJson(Map<String, dynamic> json) => InstrumentIdentity(
    instrumentSegment: json["instrumentSegment"],
    instrumentType: json["instrumentType"],
    instrumentIdType: json["instrumentIdType"],
    instrumentId: json["instrumentId"],
  );
}

