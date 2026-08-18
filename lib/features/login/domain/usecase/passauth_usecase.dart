import 'package:fpdart/fpdart.dart';
import '../../../../core/network/failure.dart';
import '../entities/passauth_params.dart';
import '../entities/passauth_result.dart';
import '../repository/authRepository.dart';

class PassAuthUseCase {
  final AuthRepository repository;
  PassAuthUseCase(this.repository);

  Future<Either<Failure, PassAuthResult>> call(PassAuthParams params) {
    return repository.passAuth(params);
  }
}