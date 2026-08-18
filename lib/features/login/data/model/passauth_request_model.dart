import '../../domain/entities/passauth_params.dart';

class PassAuthRequestModel {
  final String entityId;
  final int inputType;
  final String inputValue;
  final String dob;
  final String source;
  final PassAuthDataModel data;
  final String aesKey;
  final String imeiNo;
  final String iv;
  final String tokenId;

  PassAuthRequestModel({
    required this.entityId,
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.data,
    required this.aesKey,
    required this.imeiNo,
    required this.iv,
    required this.tokenId,
  });

  factory PassAuthRequestModel.fromEntity(PassAuthParams p) {
    return PassAuthRequestModel(
      entityId: p.entityId,
      inputType: p.inputType,
      inputValue: p.inputValue,
      dob: p.dob,
      source: p.source,
      aesKey: p.aesKey,
      imeiNo: p.imeiNo,
      iv: p.iv,
      tokenId: p.tokenId,
      data: PassAuthDataModel(
        authenticationDetails: AuthenticationDetailsModel(
          authenticationType: p.authenticationType,
          authenticationValue: p.authenticationValue,
        ),
        entityDetails: EntityDetailsModel(
          entityIdentity: EntityIdentityModel(
            entityId: p.entityId,
            entityIdType: p.entityIdType,
          ),
        ),
        loginTerminal: p.loginTerminal,
        secondFactorDetails: SecondFactorDetailsModel(
          secondFactorType: p.secondFactorType,
          secondFactorValue: p.secondFactorValue,
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'entity_id': entityId,
    'inputType': inputType,
    'inputValue': inputValue,
    'dob': dob,
    'source': source,
    'data': data.toJson(),
    'aes_key': aesKey,
    'imei_no': imeiNo,
    'iv': iv,
    'token_id': tokenId,
  };
}

/// Wraps: authenticationDetails, entityDetails, loginTerminal, secondFactorDetails
class PassAuthDataModel {
  final AuthenticationDetailsModel authenticationDetails;
  final EntityDetailsModel entityDetails;
  final String loginTerminal;
  final SecondFactorDetailsModel secondFactorDetails;

  PassAuthDataModel({
    required this.authenticationDetails,
    required this.entityDetails,
    required this.loginTerminal,
    required this.secondFactorDetails,
  });

  factory PassAuthDataModel.fromJson(Map<String, dynamic> json) {
    return PassAuthDataModel(
      authenticationDetails: AuthenticationDetailsModel.fromJson(
        json['authenticationDetails'] as Map<String, dynamic>,
      ),
      entityDetails: EntityDetailsModel.fromJson(
        json['entityDetails'] as Map<String, dynamic>,
      ),
      loginTerminal: json['loginTerminal'] as String? ?? '',
      secondFactorDetails: SecondFactorDetailsModel.fromJson(
        json['secondFactorDetails'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'authenticationDetails': authenticationDetails.toJson(),
    'entityDetails': entityDetails.toJson(),
    'loginTerminal': loginTerminal,
    'secondFactorDetails': secondFactorDetails.toJson(),
  };
}

class AuthenticationDetailsModel {
  final int authenticationType;
  final String authenticationValue;

  AuthenticationDetailsModel({
    required this.authenticationType,
    required this.authenticationValue,
  });

  factory AuthenticationDetailsModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationDetailsModel(
      authenticationType: json['authenticationType'] as int? ?? 0,
      authenticationValue: json['authenticationValue'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'authenticationType': authenticationType,
    'authenticationValue': authenticationValue,
  };
}

class EntityDetailsModel {
  final EntityIdentityModel entityIdentity;

  EntityDetailsModel({required this.entityIdentity});

  factory EntityDetailsModel.fromJson(Map<String, dynamic> json) {
    return EntityDetailsModel(
      entityIdentity: EntityIdentityModel.fromJson(
        json['entityIdentity'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'entityIdentity': entityIdentity.toJson(),
  };
}

class EntityIdentityModel {
  final String entityId;
  final int entityIdType;

  EntityIdentityModel({
    required this.entityId,
    required this.entityIdType,
  });

  factory EntityIdentityModel.fromJson(Map<String, dynamic> json) {
    return EntityIdentityModel(
      entityId: json['entityId'] as String? ?? '',
      entityIdType: json['entityIdType'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'entityId': entityId,
    'entityIdType': entityIdType,
  };
}

class SecondFactorDetailsModel {
  final int secondFactorType;
  final String secondFactorValue;

  SecondFactorDetailsModel({
    required this.secondFactorType,
    required this.secondFactorValue,
  });

  factory SecondFactorDetailsModel.fromJson(Map<String, dynamic> json) {
    return SecondFactorDetailsModel(
      secondFactorType: json['secondFactorType'] as int? ?? 0,
      secondFactorValue: json['secondFactorValue'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'secondFactorType': secondFactorType,
    'secondFactorValue': secondFactorValue,
  };
}