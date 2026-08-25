// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../core/constants/globalVariables.dart';
// import '../../../../core/socket/socket_providers.dart';
// import '../../../../core/socket/socket_service.dart';
// import 'holding_controller.dart';
//
//
//
// class WatchlistSocketController {
//   final Ref ref;
//   final SocketService socketService;
//   StreamSubscription? _sub;
//
//   List<String>? _lastSubscribedKeys;
//
//   WatchlistSocketController(this.ref, this.socketService);
//
//   Future<void> startBroadcast({required String clientId}) async {
//     final wlState = ref.read(holdingDetailsControllerProvider).value;
//     if (wlState == null || !wlState.isSuccess || wlState.items.isEmpty) {
//       return;
//     }
//
//     if (!socketService.isConnected) {
//       socketService.setLoginId(loginId: clientId);
//       socketService.connect();
//       _lastSubscribedKeys = null;
//     }
//
//     final keys = wlState.items.first.records
//         .map((item) {
//       final segId = getSegId(item.bseScriptCode, item.segment);
//       if (segId == -1) {
//         // print('SOCKET: skipping ${item.symbol} — unmapped exchange/segment '
//         //     '(${item.exchange}/${item.segment})');
//         return null;
//       }
//       return '$segId|${item.secId}';
//     })
//         .whereType<String>()
//         .toList();
//
//     if (keys.isEmpty) {
//       // print('SOCKET: no subscribable keys — nothing will be sent, no ticks '
//       //     'will arrive. Check SocketConstants segment IDs marked TODO.');
//       return;
//     }
//
//     if (_lastSubscribedKeys != null &&
//         _lastSubscribedKeys!.length == keys.length &&
//         _lastSubscribedKeys!.toSet().containsAll(keys)) {
//       // print('SOCKET: startBroadcast called again with the same keys — '
//       //     'skipping duplicate subscribe. keys=$keys');
//       return;
//     }
//
//    // print('SOCKET: startBroadcast built keys=$keys');
//     await socketService.subscribe(keys, isMbp: false);
//     _lastSubscribedKeys = keys;
//
//     _sub ??= socketService.messages.listen(_handleMessage);
//   }
//
//   void _handleMessage(dynamic data) {
//     if (data is! List<int>) {
//       //print('SOCKET TICK (non-binary): $data');
//       return;
//     }
//     if (data.isEmpty) return;
//
//     final bytes = Uint8List.fromList(data);
//     int offset = 0;
//
//     while (offset < bytes.length) {
//       final reader = ByteReader(bytes, offset);
//       final consumed = readOnePacket(reader,ref);
//       if (consumed <= 0) {
//         final rest = bytes.sublist(offset);
//         final hex = rest.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
//         //print('SOCKET: could not parse remaining ${rest.length} bytes: $hex');
//         break;
//       }
//       offset += consumed;
//     }
//   }
//
//
//
//   void dispose() {
//     _sub?.cancel();
//     _sub = null;
//     _lastSubscribedKeys = null;
//     socketService.disconnect();
//   }
// }
//
//
//
// final holdingSocketControllerProvider = Provider<HoldingSocketController>((ref) {
//   final controller = WatchlistSocketController(ref, ref.watch(socketServiceProvider));
//   ref.onDispose(controller.dispose);
//   return controller;
// });