import '../../domain/entities/authenticate_params.dart';

class AuthenticateRequestModel {
  final int inputType;
  final String inputValue;
  final String dob;
  final String source;
  final String tokenId;
  final String iv;
  final String passFlag;
  final String pubKey;

  AuthenticateRequestModel({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.passFlag,
    required this.pubKey,
  });

  factory AuthenticateRequestModel.fromEntity(
      AuthenticateParams p, {
        required String pubKey, // generated fresh by the presentation
      }) {
    return AuthenticateRequestModel(
      inputType: p.inputType,
      inputValue: p.inputValue,
      dob: p.dob,
      source: p.source,
      tokenId: p.tokenId,
      iv: p.iv,
      passFlag: p.passFlag,
      pubKey: pubKey,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "inputType": inputType,
      "inputValue": inputValue,
      "dob": dob,
      "source": source,
      "token_id": tokenId,
      "iv": iv,
      "data": {
        "pass_flag": passFlag,
        "pub_key": pubKey, // confirm with backend this is the field they read — single source now
      },
    };
  }
}