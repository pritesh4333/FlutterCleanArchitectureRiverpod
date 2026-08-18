
import '../../../../core/constants/globalVariables.dart';
import '../../presentation/controllers/watchlist_socket_controller.dart';

class WlResponseParams {
  final String status;
  final String errorCode;
  final String message;
  final String iv;
  final String data; // raw encrypted string, kept for reference/debugging

  /// Populated by the presentation/datasource after decrypting `data`.
  /// Empty until that happens (or on failure).
  final List<WatchlistItem> items;

  const WlResponseParams({
    required this.status,
    required this.errorCode,
    required this.message,
    required this.iv,
    required this.data,
    this.items = const [],
  });

  bool get isSuccess => status.toLowerCase().trim() == 'success';
  WlResponseParams copyWithDecrypted({
    required List<WatchlistItem> items,
  }) {
    return WlResponseParams(
      status: status,
      errorCode: errorCode,
      message: message,
      iv: iv,
      data: data,
      items: items,
    );
  }
}

class WatchlistItem {
  final String symbol;
  final String segment;
  final String exchange;
  final String secId;
  final String isinCode;
  final String tick;
  final String lot;
  final String upperLimit;
  final String lowerLimit;
  final String expDate;
  final String strikePrice;
  final String optType;
  final String instrument;
  final String refLtp;

  const WatchlistItem({
    required this.symbol,
    required this.segment,
    required this.exchange,
    required this.secId,
    required this.isinCode,
    required this.tick,
    required this.lot,
    required this.upperLimit,
    required this.lowerLimit,
    required this.expDate,
    required this.strikePrice,
    required this.optType,
    required this.instrument,
    required this.refLtp,
  });

  /// Identity used to match incoming socket ticks to this item — must be
  /// built the exact same way as the subscribe key in
  /// WatchlistSocketController.startBroadcast() (getSegId(exchange, segment)
  /// + '|' + secId), or ticks silently fail to match / land on the wrong
  /// row. secId alone is NOT safe to match on since the same numeric secId
  /// can appear on more than one segment/exchange.
  String get socketKey => '${getSegId(exchange, segment)}|$secId';

  /// Used by the socket controller to patch just the LTP on a tick,
  /// without touching any other field.
  WatchlistItem copyWith({String? refLtp}) {
    return WatchlistItem(
      symbol: symbol,
      segment: segment,
      exchange: exchange,
      secId: secId,
      isinCode: isinCode,
      tick: tick,
      lot: lot,
      upperLimit: upperLimit,
      lowerLimit: lowerLimit,
      expDate: expDate,
      strikePrice: strikePrice,
      optType: optType,
      instrument: instrument,
      refLtp: refLtp ?? this.refLtp,
    );
  }

}