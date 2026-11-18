import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Live index quote pushed off the socket for a single index.
class IndexQuote {
  final double ltp;
  final double open;
  final double close;
  final double high;
  final double low;

  const IndexQuote({
    this.ltp = 0.0,
    this.open = 0.0,
    this.close = 0.0,
    this.high = 0.0,
    this.low = 0.0,
  });

  /// Absolute change vs previous close.
  double get change => close != 0 ? (ltp - close) : 0.0;

  /// Percentage change vs previous close.
  double get perChange => close != 0 ? ((ltp - close) / close) * 100 : 0.0;

  IndexQuote copyWith({
    double? ltp,
    double? open,
    double? close,
    double? high,
    double? low,
  }) {
    return IndexQuote(
      ltp: ltp ?? this.ltp,
      open: open ?? this.open,
      close: close ?? this.close,
      high: high ?? this.high,
      low: low ?? this.low,
    );
  }
}

/// Holds the latest index quotes keyed by "segId|secId" (e.g. "0|13").
/// The socket parser calls [update] on every INDEX tick; the app bar strip
/// watches this so it rebuilds in real time.
class IndicesNotifier extends StateNotifier<Map<String, IndexQuote>> {
  IndicesNotifier() : super(const {});

  /// Public accessor for the current quotes map. `state` is protected on
  /// StateNotifier, so widgets that listen directly (bypassing Riverpod)
  /// read through this getter.
  Map<String, IndexQuote> get quotes => state;

  // The app currently boots in a way that produces more than one
  // ProviderContainer (confirmed via logs — the provider was created twice
  // with different notifier hashCodes). To guarantee the socket parser and
  // the UI share ONE notifier regardless of how many containers exist, this
  // notifier is never actually disposed.
  @override
  void dispose() {
    // Intentionally NOT calling super.dispose() — see note above. The single
    // shared instance must survive for the whole app session.
  }

  void update({
    required String key,
    required double ltp,
    required double open,
    required double close,
    required double high,
    required double low,
  }) {
    // Rebuild the map so Riverpod detects a new reference and notifies
    // listeners (mutating in place would not trigger a rebuild).
    state = {
      ...state,
      key: IndexQuote(
        ltp: ltp,
        open: open,
        close: close,
        high: high,
        low: low,
      ),
    };
  }
}

/// App-wide single instance. Shared across every ProviderContainer so the
/// socket parser (which may run under a different container than the widget
/// tree) and the UI always read/write the SAME notifier and state.
final IndicesNotifier indicesNotifierSingleton = IndicesNotifier();

final indicesProvider =
    StateNotifierProvider<IndicesNotifier, Map<String, IndexQuote>>(
  (ref) => indicesNotifierSingleton,
);
