import 'package:fpdart/fpdart.dart';
 import '../../../../core/network/failure.dart';
import '../entities/authenticate_params.dart';
import '../entities/authenticate_result.dart';
import '../repository/authRepository.dart';

class AuthenticateUseCase {
  final AuthRepository repository;
  AuthenticateUseCase(this.repository);

  Future<Either<Failure, AuthenticateResult>> call(AuthenticateParams params) {
    return repository.authenticate(params);//step 4
  }
}