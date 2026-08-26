import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/globalVariables.dart';
import '../../domain/entity/sipBookRequest_params.dart';
import '../../domain/entity/sipBookResponse_params.dart';
import '../providers/sipBook_provider.dart';

class SipBookDetailsController extends AsyncNotifier<SipBookResponseParams?> {
  @override
  Future<SipBookResponseParams?> build() async {
    await Future.delayed(const Duration(seconds: 3));
    final params = SipBookItemRequestParams(
      inputType: 2,
      inputValue: clientId ?? '',
      dob: dob ?? '',
      source: 'M',
      tokenId: tokenID ?? '',
      iv: iV ?? '',
      data: SipBookData(
        clientId: clientId ?? '',
        product: '0',
      ),
    );

    final result = await ref
        .read(sipBookDetailsUseCaseProvider)
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

  Future<void> getSipBookDetails(SipBookItemRequestParams params) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 3));
    final useCase = ref.read(sipBookDetailsUseCaseProvider);
    final result = await useCase(params);

    state = result.match(
      (failure) => AsyncError<SipBookResponseParams?>(failure.message, StackTrace.current),
      (data) => AsyncData<SipBookResponseParams?>(data),
    );
  }
}

final sipBookDetailsControllerProvider =
    AsyncNotifierProvider<SipBookDetailsController, SipBookResponseParams?>(
  SipBookDetailsController.new,
);

