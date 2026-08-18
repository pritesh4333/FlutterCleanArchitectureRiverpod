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

  Future<void> getWlDetails(WlRequestParams params) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 3));
    final useCase = ref.read(wlDetailsUseCaseProvider); //step 2
    final result = await useCase(params);

    // fold() converts Either<Failure, T> into AsyncValue manually
    state = result.match( // step 11
          (failure) => AsyncError<WlResponseParams?>(failure.message, StackTrace.current),
          (data) => AsyncData<WlResponseParams?>(data),
    );
  }

  /// Called by WatchlistSocketController whenever a tick arrives for a
  /// symbol currently in the loaded watchlist.
  ///
  /// [key] must be the same "segId|secId" identity used by
  /// WatchlistSocketController (getSegId(exchange, segment)|secId) —
  /// NOT bare secId, since secId alone can collide across
  /// segments/exchanges and stomp the wrong row.
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