class SocketConstants {
  SocketConstants._();

  static const socketUrl = 'wss://bcast.shcilservices.net:443';

  // Confirmed from live testing:
  static const streamFeedConnect = 10;
  static const connectPacketLength = 83; // total bytes for the CONNECT packet

  // Add-stock header length — confirmed via _makeObject(reqCode, 129) call.
  static const addStockHeaderLength = 129;

  // Confirmed from legacy source — these were wrong before (2/3 placeholders),
  // which is why subscribe requests were being silently ignored by the server.
  static const streamFeedDisconnect = 11;
  static const heartBeat = 14;
  static const streamFeedAddStock = 12;
  static const streamFeedIndexAddStock = 24;
  static const streamFeedDelStock = 13;
  static const streamFeedMbpAddStock = 23;
  static const streamFeedMbpDelStock = 25;
  static const streamFeedIndexDelStock = 28;

  static const defaultScripSize = 20;
  static const trade = 1;

  // Segment IDs — confirmed from legacy source.
  static const iIDX_I = 0;
  static const iNSE_E = 1;
  static const iNSE_D = 2;
  static const iNSE_C = 3;
  static const iBSE_E = 4;
  static const iMCX_M = 5;
  static const iNCDEX_M = 6;
  static const iBSE_C = 7; // BSE currency
  static const iBSE_D = 8; // BSE Derivative (F&O)
  static const iBSE_M = 9; // BSE commodity
  static const iNSE_M = 10; // NSE commodity
  static const iPSE_E = 12;
}