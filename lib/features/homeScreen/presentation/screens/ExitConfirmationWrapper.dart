// presentation/widgets/exit_confirmation_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/exit_provider.dart';

class ExitConfirmationWrapper extends ConsumerWidget {
  final Widget child;
  const ExitConfirmationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false, // we intercept manually
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await showExitConfirmationDialog(context, ref);
      },
      child: child,
    );
  }
}
Future<void> showExitConfirmationDialog(BuildContext context, WidgetRef ref) async {
  final visible = ref.read(exitDialogVisibleProvider);
  if (visible) return; // prevent double dialogs

  ref.read(exitDialogVisibleProvider.notifier).state = true;

  final shouldExit = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Exit App'),
      content: const Text('Are you sure you want to exit?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Exit'),
        ),
      ],
    ),
  ) ??
      false;

  ref.read(exitDialogVisibleProvider.notifier).state = false;

  if (shouldExit && context.mounted) {
    SystemNavigator.pop();
  }
}