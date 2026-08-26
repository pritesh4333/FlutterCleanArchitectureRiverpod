import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/constants/globalVariables.dart';
import '../../domain/entity/WLRequest_parmars.dart';

import '../../domain/entity/WLResponse_parmams.dart';
import '../providers/watch_provider.dart';

class WldetailsController extends AsyncNotifier<WlResponseParams?> {
  @override
  Future<WlResponseParams?> build() async {
    await Future.delayed(const Duration(seconds: 3));
    final params = WlRequestParams(
      inputType: 2,
      inputValue: clientId!,
      dob: dob!,
      source: 'M',
      tokenId: tokenID!,
      iv: iV!,
      data: Data(wlName: 'MOBILETESTING', clientId: clientId!),
    );

    final result = await ref
        .read(wlDetailsUseCaseProvider)
        .call(params);

    return result.fold(
          (failure) {
        throw Exception(failure.message);
      },
          (response) {
        return response;
      },
    );
  }

  void updateLtp(String key, String newLtp) {
    final current = state.value;
    if (current == null || !current.isSuccess) return;

    final updatedItems = current.items.map((item) {
      if (item.socketKey == key) {
        return item.copyWith(refLtp: newLtp);
      }
      return item;
    }).toList();

    state = AsyncData(current.copyWithDecrypted(items: updatedItems));
  }
}

final wlDetailsControllerProvider =
AsyncNotifierProvider<WldetailsController, WlResponseParams?>(
  WldetailsController.new,
);