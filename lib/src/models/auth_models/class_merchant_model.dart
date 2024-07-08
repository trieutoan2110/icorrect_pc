class ClassMerchantModel {
  int errorCode;
  String status;
  Data? data;
  String? messages;

  ClassMerchantModel({
    required this.errorCode,
    required this.status,
    this.data,
    this.messages,
  });

  factory ClassMerchantModel.fromJson(Map<String, dynamic> json) => ClassMerchantModel(
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
  int currentPage;
  List<Datum> data;
  int from;
  int lastPage;
  int perPage;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    from: json["from"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "from": from,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}

class Datum {
  int id;
  String name;
  DateTime createdAt;
  String classId;

  Datum({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.classId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    classId: json["class_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "class_id": classId,
  };
}