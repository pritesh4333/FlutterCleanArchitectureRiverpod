import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/constants/globalVariables.dart';
import '../../domain/entity/HoldingRequest_parmars.dart';

import '../../domain/entity/HoldingResponse_parmams.dart';
import '../providers/holding_provider.dart';

class HoldingDetailsController extends AsyncNotifier<HoldingResponseParams?> {
  @override
  Future<HoldingResponseParams?> build() async {
    // await Future.delayed(const Duration(seconds: 3));
    final params = HoldingRequestParams(
      inputType: 2,
      inputValue: clientId!,
      dob: dob!,
      source: 'M',
      tokenId: tokenID!,
      iv: iV!,
      data: Data(requestDateTime: '', merchantCode: '', holdingType: 'equity', isin: '', messageSeq: '', dpid: '12090700', dpName: 'CDSL', dpAccount: '1209070000070098'

      ),
    );

    final result = await ref
        .read(holdingDetailsUseCaseProvider)
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




  // void updateLtp(String key, String newLtp) {
  //   final current = state.value;
  //   if (current == null || !current.isSuccess) return;
  //
  //   final updatedItems = current.data.map((item) {
  //     if (item.records == key) {
  //       return item.records.copyWith(refLtp: newLtp);
  //     }
  //     return item;
  //   }).toList();
  //
  //   state = AsyncData(current.copyWithDecrypted(items: updatedItems));
  // }
}

final holdingDetailsControllerProvider =
AsyncNotifierProvider<HoldingDetailsController, HoldingResponseParams?>(
  HoldingDetailsController.new,
);