import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/widgets/CommanWidgets.dart';
import '../../core/theam/app_fonts.dart';
import 'name_provider.dart';

class StateTesting extends ConsumerWidget {
  const StateTesting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const CommonText('Riverpod',fontFamily: AppFonts.fontName,
        fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
        fontSize: 15,
        color: Colors.black,),
        backgroundColor: Theme.of(context).colorScheme.surface, // pin explicitly
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, _) {
              final currentName = ref.watch(currentNameProvider);
              return CommonText(currentName,fontFamily: AppFonts.fontName,
                fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                fontSize: 15,
                color: Colors.black,);
            },
          ),
          ElevatedButton(
            onPressed: () => pickRandomName(ref),
            child: const CommonText('Update Name',fontFamily: AppFonts.fontName,
              fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
              fontSize: 15,
              color: Colors.black,),
          ),
          Consumer(
            builder: (context, ref, _) {
              final listNames = ref.watch(nameListProvider);
              return Expanded(
                child: ListView.builder(
                  itemCount: listNames.length,
                  itemBuilder: (context, index) => ListTile(title: CommonText(listNames[index],fontFamily: AppFonts.fontName,
                    fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                    fontSize: 15,
                    color: Colors.black,)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}