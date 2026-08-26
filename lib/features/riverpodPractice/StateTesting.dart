import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateTesing extends ConsumerStatefulWidget {
  const StateTesing({super.key});

  @override
  ConsumerState<StateTesing> createState() => _StateTesingState();
}

class _StateTesingState extends ConsumerState<StateTesing> {
  final List<String> names = [
    'Aarav Sharma',
    'Ishaan Verma',
    'Rohan Malhotra',
    'Kabir Singh',
    'Vivaan Gupta',
    'Ananya Iyer',
    'Diya Kapoor',
    'Saanvi Reddy',
    'Myra Nair',
    'Kiara Joshi',
    'Arjun Mehta',
    'Neha Kulkarni',
    'Rahul Chopra',
    'Priya Desai',
    'Vikram Rao',
  ];



  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            ref.read(updateText.notifier).state = "Default"; // reset manually
          }
        },
     child: Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        // pin explicitly
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0, // prevents elevation change on scroll
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Only this Consumer rebuilds when textProvider changes
                  Consumer(
                    builder: (context, ref, _) {
                       return Text(
                        ref.watch(updateText),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: (){
                      final random = Random();

                         ref.read(updateText.notifier).state = names[random.nextInt(names.length)];
                     },
                    child:  const Text('Update Name'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
    );
  }
}



final updateText = StateProvider.autoDispose<String>((ref){
  return "Change My Name";
});





