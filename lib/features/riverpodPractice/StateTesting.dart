import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'name_provider.dart';

class StateTesting extends ConsumerWidget {
  const StateTesting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentName = ref.watch(currentNameProvider);
    final listNames = ref.watch(nameListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod')),
      body: Column(
        children: [
          Text(currentName, style: const TextStyle(fontSize: 24)),
          ElevatedButton(
            onPressed: () => pickRandomName(ref),
            child: const Text('Update Name'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listNames.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(listNames[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}