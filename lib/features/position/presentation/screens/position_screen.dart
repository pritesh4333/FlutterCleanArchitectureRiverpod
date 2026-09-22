import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/widgets/CommanWidgets.dart';
import '../../../../core/theam/app_fonts.dart';
import '../../../../core/widgets/ListSkeleton.dart';
import 'package:stockholding/features/position/presentation/providers/position_provider.dart';

import '../controllers/position_controller.dart';


class PositionScreen extends ConsumerStatefulWidget {
  const PositionScreen({super.key});

  @override
  ConsumerState<PositionScreen> createState() => _PositionScreenState();
}

class _PositionScreenState extends ConsumerState<PositionScreen> {

  @override
  Widget build(BuildContext context) {
    final positionDetailsState = ref.watch(positionControllerProvider);

    return Scaffold(

      body: positionDetailsState.when(
        loading: () => const ListSkeleton(),
        error: (e, _) => Center(child: CommonText('Error: $e',fontFamily: AppFonts.fontName,
          fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
          fontSize: 15,
          color: Colors.black,)),
        data: (result) {
          if (result == null) return const Center(child: CommonText('No data',fontFamily: AppFonts.fontName,
            fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
            fontSize: 15,
            color: Colors.black,));
          if (!result.isSuccess) return Center(child: CommonText(result.message,fontFamily: AppFonts.fontName,
            fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
            fontSize: 15,
            color: Colors.black,));
          if (result.items.isEmpty)
            return const Center(child: CommonText('No instruments found',fontFamily: AppFonts.fontName,
              fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
              fontSize: 15,
              color: Colors.black,));

          return ListView.builder(
            itemCount: result.items.length,
            itemBuilder: (context, index) {
              final item = result.items[index];
              return ListTile(
                title: CommonText(item.symbol,fontFamily: AppFonts.fontName,
                  fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                  fontSize: 15,
                  color: Colors.black,),
                subtitle: CommonText('${item.exchange} • ${item.buyAvg}',fontFamily: AppFonts.fontName,
                  fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                  fontSize: 15,
                  color: Colors.black,),
                trailing: CommonText(
                  '${item.grossQty}',fontFamily: AppFonts.fontName,
                  fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                  fontSize: 15,
                  color: Colors.black,
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
