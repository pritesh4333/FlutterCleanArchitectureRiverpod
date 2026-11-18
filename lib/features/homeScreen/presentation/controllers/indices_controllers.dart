import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/socket/socket_service.dart';
import 'package:stockholding/features/homeScreen/domain/entity/GetSetIndex.dart';

import '../../../../core/constants/globalVariables.dart';
import '../../../../core/socket/socket_providers.dart';

class IndicesControllers {
  final Ref ref;
  final SocketService socketService;
  StreamSubscription? _sub;
  bool _subscribed = false;

  IndicesControllers(this.ref, this.socketService);

  /// Index packets always arrive on the index segment (0), and the socket
  /// subscribeIndices() call sends them on segment 0 too. Keys must match the
  /// key readOnePacket builds from the packet header ("exchSeg|secId"), which
  /// for indices is "0|id".
  static const int _indexSegment = 0;

  Future<void> startBrodcast({required List<GetSetIndex> listGetSetIndex}) async {
    // Only subscribe once per controller lifetime — HomeScreen.build can run
    // many times, and re-subscribing on every build floods the server.
    if (_subscribed) return;

    final effectiveLoginId =
        (clientId != null && clientId!.isNotEmpty) ? clientId! : 'EKS560743';

    if (!socketService.isConnected) {
      socketService.setLoginId(loginId: effectiveLoginId);
      socketService.connect();
    }

    // Start listening to the socket BEFORE subscribing so we don't miss the
    // first ticks. _handleMessage feeds every frame through the shared
    // readOnePacket parser, which pushes INDEX ticks into indicesProvider.
    _sub ??= socketService.messages.listen(_handleMessage);

    // subscribeIndices expects BARE secIds (the "seg|" prefix is added by
    // the packet builder via the segment arg), so send just the ids here.
    final secIds = <String>[];
    for (final model in listGetSetIndex) {
      secIds.add('${model.id}');
    }

    await socketService.subscribeIndices(secIds, _indexSegment);
    _subscribed = true;
  }

  void _handleMessage(dynamic data) {
    if (data is! List<int> || data.isEmpty) return;

    final bytes = Uint8List.fromList(data);
    int offset = 0;

    // A single frame can carry multiple packets back to back. Track the
    // offset externally and feed a fresh reader each time — readOnePacket
    // returns the number of bytes the packet declared (its total length),
    // which is what we advance by, matching the watchlist controller.
    while (offset < bytes.length) {
      final reader = ByteReader(bytes, offset);
      final consumed = readOnePacket(reader, ref);
      if (consumed <= 0) break; // bad/partial frame — avoid an infinite loop
      offset += consumed;
    }
  }

  void dispose() {
    _sub?.cancel();
    _sub = null;
    _subscribed = false;
    socketService.disconnect();
  }
}

final indicesSocketControllerProvider = Provider<IndicesControllers>((ref) {
  final controller = IndicesControllers(ref, ref.watch(socketServiceProvider));
  ref.onDispose(controller.dispose);
  return controller;
});
