import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pointycastle/asymmetric/api.dart';
import '../../../../core/network/failure.dart';
import '../../../../core/security/RsaKeyHelper.dart';
import '../../domain/entities/authenticate_params.dart';
import '../../domain/entities/authenticate_result.dart';
import '../../domain/entities/passauth_params.dart';
import '../../domain/entities/passauth_result.dart';
import '../../domain/repository/authRepository.dart';
import '../datasource/auth_remote_data_source.dart';
import '../model/authenticate_params.dart';
 import '../model/passauth_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final RsaKeyHelper rsaKeyHelper;

  AuthRepositoryImpl(this.remote, this.rsaKeyHelper);

  @override
  Future<Either<Failure, AuthenticateResult>> authenticate(
      AuthenticateParams params,
      ) async {
    try {
      // 1. Generate a fresh RSA key pair for THIS request
      final keyPair = await rsaKeyHelper.computeRSAKeyPair(rsaKeyHelper.getSecureRandom());
      final publicKey = keyPair.publicKey as RSAPublicKey;
      final privateKey = keyPair.privateKey as RSAPrivateKey;

      final publicKeyPem = rsaKeyHelper.encodePublicKeyToPemPKCS8(publicKey);
      final pubKeyStripped = rsaKeyHelper.removePemHeaderAndFooter(publicKeyPem);

      // 2. Build the request WITH that pubKey — single place it's set
      final requestModel = AuthenticateRequestModel.fromEntity(
        params,
        pubKey: pubKeyStripped,
      );

      // 3. Datasource just posts + parses — no RSA inside it
      final responseModel = await remote.authenticate(requestModel);

      if (!responseModel.isSuccess || responseModel.data.isEmpty) {
        return Right(responseModel);
      }

      // 4. Decrypt with the SAME keypair generated in step 1 — this is
      //    the fix for "Unsupported block type for private key"
      final encrypted = responseModel.data[0];
      final decryptedAesKey = rsaKeyHelper.decrypt(
        encrypted.encryptedKey,
        publicKey,
        privateKey,
      );
      final decryptedTokenId = rsaKeyHelper.decrypt(
        encrypted.encryptedToken,
        publicKey,
        privateKey,
      );

      return Right(responseModel.copyWithDecrypted(
        decryptedAesKey: decryptedAesKey,
        decryptedTokenId: decryptedTokenId,
      ));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PassAuthResult>> passAuth(
      PassAuthParams params,
      ) async {
    try {
      final requestModel = PassAuthRequestModel.fromEntity(params);
      final responseModel = await remote.passAuth(requestModel);
      return Right(responseModel);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


}