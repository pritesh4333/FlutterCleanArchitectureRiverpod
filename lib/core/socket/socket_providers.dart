import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'socket_service.dart';
import 'socket_service_impl.dart';

final socketServiceProvider = Provider<SocketService>((ref) {
  final service = SocketServiceImpl();
  ref.onDispose(() => (service as SocketServiceImpl).dispose());
  return service;
});