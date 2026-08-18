import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/globalVariables.dart';
import '../../domain/entity/positionRequest_parmars.dart';
import '../../domain/entity/positionResponse_parmams.dart';

import '../providers/position_provider.dart';

class PositionDetailsController extends AsyncNotifier<PositionResponseParams?> {
  @override
  Future<PositionResponseParams?> build() async {

    final params = PositionRequestParmas(
      inputType: 2,
      inputValue: clientId!,
      dob: dob!,
      source: 'M',
      tokenId: tokenID!,
      iv: iV!,
      data: PositionData(
        source: 'M',
        interop_flag: '',
        clientId: clientId!,
        bankAccountSettlementType: '0',
      ),
    );

    final result = await ref
        .read(positionDetailsUseCaseProvider)
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

  Future<void> getPositionBookDetails(PositionRequestParmas params) async {
    state = const AsyncLoading();

    final useCase = ref.read(positionDetailsUseCaseProvider); // step 2
    final result = await useCase(params);

    // fold()/match() converts Either<Failure, T> into AsyncValue manually
    state = result.match(
          (failure) => AsyncError<PositionResponseParams?>(failure.message, StackTrace.current),
          (data) => AsyncData<PositionResponseParams?>(data),
    );
  }
}

final positionControllerProvider =
AsyncNotifierProvider<PositionDetailsController, PositionResponseParams?>(
  PositionDetailsController.new,
);