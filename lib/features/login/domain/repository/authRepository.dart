
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../entities/authenticate_params.dart';
import '../entities/authenticate_result.dart';
import '../entities/passauth_params.dart';
import '../entities/passauth_result.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthenticateResult>> authenticate(
      AuthenticateParams params,
      );//step 5

  Future<Either<Failure, PassAuthResult>> passAuth(
      PassAuthParams params,
      ); // new
}