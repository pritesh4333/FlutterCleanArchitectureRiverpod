import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:stockholding/core/socket/socket_service.dart';
import 'package:web_socket_channel/io.dart';

import 'socket_constants.dart';

class SocketServiceImpl implements SocketService {
  IOWebSocketChannel? _channel;
  final StreamController<dynamic> _messageController =
  StreamController<dynamic>.broadcast();

  final List<String> _broadcastList = [];
  bool _isConnected = false;

  @override
  Stream<dynamic> get messages => _messageController.stream;

  @override
  bool get isConnected => _isConnected;

  @override
  void setLoginId({String? loginId, String? loginIdGuest}) {
    this.loginId = loginId;
    this.loginIdGuest = loginIdGuest;
  }

  @override
  void connect() {
    try {
      _channel = IOWebSocketChannel.connect(SocketConstants.socketUrl);
      _isConnected = true;
      //print('SOCKET: connect() called, channel created, sending CONNECT packet');

      _send(_makeConnectObject());

      _channel!.stream.listen(
            (data) {
          //print('SOCKET: raw data received (${data is List<int> ? '${data.length} bytes' : data.runtimeType})');
          _messageController.add(data);
        },
        onDone: () {
          print('SOCKET: onDone fired — connection closed by server');
          _isConnected = false;
        },
        onError: (error) {
          print('SOCKET: onError — $error');
          _isConnected = false;
        },
        cancelOnError: true,

      );
    } catch (e, st) {
      print('SOCKET: connect() FAILED — $e');
      print(st);
      _isConnected = false;
    }
  }

  @override
  void disconnect() {
    _channel?.sink.close();
    _isConnected = false;
    _broadcastList.clear();
  }

  @override
  Future<void> subscribe(List<String> keys, {bool isMbp = false}) async {
    if (!_isConnected || keys.isEmpty) {
      //print('SOCKET: subscribe() skipped — isConnected=$_isConnected, keys=$keys');
      return;
    }
    //print('SOCKET: subscribing to $keys');

    // Group by segment ID first — matches your original _addScrips ->
    // _sendAddReq(scripList, isMbp, seg) pattern, where each segment's
    // scrips are sent together with `seg` passed separately as an int,
    // and scripCode is the BARE secId (no "segId|" prefix).
    final Map<String, List<String>> bySegment = {};
    for (final key in keys) {
      final parts = key.split('|');
      if (parts.length != 2) continue;
      final segId = parts[0];
      final secId = parts[1];
      bySegment.putIfAbsent(segId, () => []).add(secId);
      _broadcastList.add(key);
    }

    for (final entry in bySegment.entries) {
      final seg = int.parse(entry.key);
      await _sendAddReq(entry.value, isMbp, seg);
    }
  }

  Future<void> _sendAddReq(List<String> scripList, bool isMbp, int seg) async {
    for (final scripCode in scripList) {
      _send(_makeAddStockObject(scripCode, seg, SocketConstants.streamFeedAddStock));

      if (isMbp) {
        _send(_makeAddStockObject(scripCode, seg, SocketConstants.streamFeedMbpAddStock));
      }

      // Matches your original 3ms throttle between adds so the server
      // isn't flooded with subscribe requests back-to-back.
      await Future.delayed(const Duration(milliseconds: 3));
    }
  }

  @override
  void unsubscribeAll() {
    _broadcastList.clear();
    // TODO: send your delete/unsubscribe packet here if the server
    // requires an explicit "remove scrip" message (your old deleteScrip()).
  }

  void _send(dynamic object) {
    try {
      _channel?.sink.add(object);
    } catch (e) {
      if (e.toString().contains('Cannot add event after closing')) {
        _isConnected = false;
      }
    }
  }

  // ---- Confirmed and implemented ----

  Uint8List _makeConnectObject() {
    return Uint8List.fromList(_toByteArray(
      SocketConstants.streamFeedConnect,
      SocketConstants.connectPacketLength,
    ));
  }

  /// Faithful translation of your _makeObject(scripCode, segment, reqCode).
  Uint8List _makeAddStockObject(String scripCode, int seg, int reqCode) {
    final segBytes = Uint8List.fromList([seg]);
    final secIdxCode = Uint8List.fromList([-1, 0, 0, 0]);
    final scripCountByte = Uint8List.fromList([1]);

    final loginSocketId = _resolveLoginSocketId();
    final watchName = Uint8List.fromList(loginSocketId.codeUnits);
    final watchNameBlank = Uint8List(SocketConstants.defaultScripSize - watchName.length);

    final list = <int>[];
    list.addAll(_toByteArray(reqCode, SocketConstants.addStockHeaderLength));
    list.addAll(segBytes);
    list.addAll(secIdxCode);
    list.addAll(scripCountByte);
    list.addAll(watchName);
    list.addAll(watchNameBlank);

    final scrip = Uint8List.fromList(scripCode.codeUnits);
    final scripBlank = Uint8List(SocketConstants.defaultScripSize - scrip.length);
    list.addAll(scrip);
    list.addAll(scripBlank);

    return Uint8List.fromList(list);
  }

  /// Confirmed via live test: requestCode(1) + length-LE(2) +
  /// loginSocketId padded to 30 + remaining padding to reach `length`
  /// total bytes.

  List<int> _toByteArray(int requestCode, int length) {
    final loginSocketId = _resolveLoginSocketId();

    final rcUint = Uint8List.fromList([requestCode]);
    final lengthUint = Uint8List.fromList(_getBytesFromInteger(length));
    final rcID = Uint8List.fromList(loginSocketId.codeUnits);
    final blank = Uint8List(30 - rcID.length);
    // Always 50 — matches legacy. `length` only fills the declared-length
    // field above; it does NOT change how many bytes this helper emits.
    // Callers (e.g. _makeAddStockObject) append their own extra fields
    // after this to reach the declared total.
    final blank2 = Uint8List(50);

    final list = <int>[];
    list.addAll(rcUint);
    list.addAll(lengthUint);
    list.addAll(rcID);
    list.addAll(blank);
    list.addAll(blank2);

    return list;
  }

  List<int> _getBytesFromInteger(int num) {
    final byte1 = num & 0xff;
    final byte2 = (num >> 8) & 0xff;
    return [byte1, byte2];
  }

  /// Client/entity ID used as the socket's login identifier — set via
  /// setLoginId() before connect(). Falls back to a random guest ID.
  String? loginId;
  String? loginIdGuest;

  String _resolveLoginSocketId() {
    if (loginId != null && loginId!.isNotEmpty) return loginId!;
    if (loginIdGuest != null && loginIdGuest!.isNotEmpty) return loginIdGuest!;
    return _randomString(10);
  }

  String _randomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();
    return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  void dispose() {
    _messageController.close();
  }
}