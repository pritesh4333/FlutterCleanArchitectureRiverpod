// presentation/providers/exit_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Tracks whether the confirmation dialog is currently showing
final exitDialogVisibleProvider = StateProvider<bool>((ref) => false);