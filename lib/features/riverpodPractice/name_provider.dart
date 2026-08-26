// name_provider.dart
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> names = [
  'Aarav Sharma', 'Ishaan Verma', 'Rohan Malhotra', 'Kabir Singh',
  'Vivaan Gupta', 'Ananya Iyer', 'Diya Kapoor', 'Saanvi Reddy',
  'Myra Nair', 'Kiara Joshi', 'Arjun Mehta', 'Neha Kulkarni',
  'Rahul Chopra', 'Priya Desai', 'Vikram Rao',
];

final currentNameProvider = StateProvider.autoDispose<String>((ref) {
  return "Change My Name";
});

final nameListProvider = StateProvider.autoDispose<List<String>>((ref) {
  return [];
});

void pickRandomName(WidgetRef ref) {
  final random = Random();
  final newName = names[random.nextInt(names.length)];

  ref.read(currentNameProvider.notifier).state = newName;
  ref.read(nameListProvider.notifier).state = [
    ...ref.read(nameListProvider),
    newName,
  ];
}