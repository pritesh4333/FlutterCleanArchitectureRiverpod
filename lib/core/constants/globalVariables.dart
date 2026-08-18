import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/watchlist/presentation/controllers/wlDetails_controller.dart';
import '../socket/socket_constants.dart';

String? clientId;
String? dob;
String? tokenID;
String? iV;

int getSegId(String? exch, String? name) {
  if (exch == null) return -1;

  if (exch.toUpperCase() == 'NSE') {
    switch (name?.toUpperCase()) {
      case 'E':
        return SocketConstants.iNSE_E;
      case 'D':
        return SocketConstants.iNSE_D;
      case 'C':
        return SocketConstants.iNSE_C;
      case 'M':
        return SocketConstants.iNSE_M;
    }
  } else if (exch.toUpperCase() == 'BSE') {
    switch (name?.toUpperCase()) {
      case 'E':
        return SocketConstants.iBSE_E;
      case 'D':
        return SocketConstants.iBSE_D;
      case 'C':
        return SocketConstants.iBSE_C;
      case 'M':
        return SocketConstants.iBSE_M;
    }
  } else if (exch.toUpperCase() == 'MCX') {
    return SocketConstants.iMCX_M;
  } else if (exch.toUpperCase() == 'NCDEX') {
    return SocketConstants.iNCDEX_M;
  } else if (exch.toUpperCase() == 'PSE') {
    return SocketConstants.iPSE_E;
  } else if (exch.toUpperCase() == 'IDX') {
    return SocketConstants.iIDX_I;
  }

  return -1;
}
int readOnePacket(ByteReader reader, Ref ref) {
  final startOffset = reader.offset;
  final hexAll = reader.bytes
      .sublist(startOffset)
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join(' ');
  try {
    final exchSeg = reader.getUint8();
    final scripID = reader.getInt32();
    final scripID2 = reader.getInt32();
    final length = reader.getUint8();
    final msgCode = reader.getUint8();

    final secId = scripID.toString();
    // Full identity — matches getSegId(exchange, segment)|secId used to
    // build the subscribe keys and the WLResponse item's socketKey.
    // Do NOT match on bare secId elsewhere — the same numeric secId can
    // exist on more than one segment/exchange.
    final key = '$exchSeg|$secId';

    // print('SOCKET DIAG: frameLen=${reader.bytes.length - startOffset} '
    //     'hex=$hexAll');
    // print('SOCKET DIAG: header-parse exchSeg=$exchSeg scripID=$scripID '
    //     'scripID2=$scripID2 length=$length msgCode=$msgCode key=$key');

    switch (msgCode) {
      case 1:   // Trade Packet
      case 101: // Trade Packet (new structure)
      // ltp is genuinely the first float32 field here — matches legacy
      // _parseTradePacketNewStructure exactly.
        if (reader.remaining >= 4) {
          final ltp = reader.getFloat32();
          //print('SOCKET: parsed msgCode=$msgCode key=$key ltp=$ltp');
          if (ltp > 0) {

            ref
                .read(wlDetailsControllerProvider.notifier)
                .updateLtp(key, ltp.toStringAsFixed(2));
          } else {
            //print('SOCKET: ignoring zero LTP tick for key=$key');
          }
        }
        break;
      case 14: // heartbeat — nothing to parse
        break;
      default:
      // MBP (2/102), Top Bid Ask (6/106), OHLC, index, pclose, ckt
      // limit, 52-week hi/lo, ticker, etc. — not needed for LTP,
      // skip without touching state.
        break;
    }

    // `length` is the TOTAL packet size (header + payload), confirmed
    // from live capture — e.g. length=51 for an 11-byte header + 40-byte
    // payload. Do NOT add headerSize on top of it, or every packet after
    // the first in a multi-packet frame lands misaligned.
    final packetTotal = length;
    final actuallyConsumed = reader.offset - startOffset;

    return packetTotal > actuallyConsumed ? packetTotal : actuallyConsumed;
  } catch (e, st) {
    // print('SOCKET: failed to parse packet — $e');
    // print(st);
    return -1;
  }
}
class ByteReader {
  final Uint8List bytes;
  int offset;

  ByteReader(this.bytes, this.offset);

  int get remaining => bytes.length - offset;

  int getUint8() {
    final v = bytes[offset];
    offset += 1;
    return v;
  }

  int getInt32() {
    final v = ByteData.sublistView(bytes, offset, offset + 4).getInt32(0, Endian.little);
    offset += 4;
    return v;
  }

  double getFloat32() {
    final v = ByteData.sublistView(bytes, offset, offset + 4).getFloat32(0, Endian.little);
    offset += 4;
    return v;
  }
}