abstract class SocketService {
  /// Broadcast stream of raw messages coming off the socket — the
  /// watchlist controller parses these into LTP ticks.
  Stream<dynamic> get messages;

  bool get isConnected;

  void connect();

  /// Sets the login socket ID used in the packet header — falls back to a
  /// random guest ID if not called. Call this before connect().
  void setLoginId({String? loginId, String? loginIdGuest});

  void disconnect();

  /// [keys] are "segId|secId" strings, matching your existing
  /// `segmentID + '|' + secID` format from _askForBroadcast().
  Future<void> subscribe(List<String> keys, {bool isMbp = false});

  void unsubscribeAll();
}