class VerifyModel {
  int errorCode;
  String status;
  Data? data;
  String? messages;

  VerifyModel({
    required this.errorCode,
    required this.status,
    this.data,
    this.messages,
  });

  factory VerifyModel.fromJson(Map<String, dynamic> json) => VerifyModel(
    errorCode: json["error_code"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    messages: json["messages"],
  );

  Map<String, dynamic> toJson() => {
    "error_code": errorCode,
    "status": status,
    "data": data?.toJson(),
    "messages": messages,
  };
}

class Data {
  String expireTime;
  String merchantId;

  Data({
    required this.expireTime,
    required this.merchantId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    expireTime: json["expire_time"],
    merchantId: json["merchant_id"],
  );

  Map<String, dynamic> toJson() => {
    "expire_time": expireTime,
    "merchant_id": merchantId,
  };
}