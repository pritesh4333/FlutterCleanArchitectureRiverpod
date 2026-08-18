// data/model/positionRequestModel.dart
import 'package:stockholding/features/watchlist/domain/entity/WLRequest_parmars.dart';

class WlRequestModelParams {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  WlRequestDataModel data; // ← renamed type

  WlRequestModelParams({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.data,
  });

  factory WlRequestModelParams.fromEntity(WlRequestParams p) {
    return WlRequestModelParams(
      inputType: p.inputType,
      inputValue: p.inputValue,
      dob: p.dob,
      source: p.source,
      tokenId: p.tokenId,
      iv: p.iv,
      data: WlRequestDataModel(
        wlName: p.data.wlName,
        clientId: p.data.clientId,
      ),
    );
  }

  factory WlRequestModelParams.fromJson(Map<String, dynamic> json) => WlRequestModelParams(
    inputType: json["inputType"],
    inputValue: json["inputValue"],
    dob: json["dob"],
    source: json["source"],
    tokenId: json["token_id"],
    iv: json["iv"],
    data: WlRequestDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "inputType": inputType,
    "inputValue": inputValue,
    "dob": dob,
    "source": source,
    "token_id": tokenId,
    "iv": iv,
    "data": data.toJson(),
  };
}

class WlRequestDataModel { // ← renamed from Data
  String wlName;
  String clientId;

  WlRequestDataModel({
    required this.wlName,
    required this.clientId,
  });

  factory WlRequestDataModel.fromJson(Map<String, dynamic> json) => WlRequestDataModel(
    wlName: json["wl_name"],
    clientId: json["client_id"],
  );

  Map<String, dynamic> toJson() => {
    "wl_name": wlName,
    "client_id": clientId,
  };
}