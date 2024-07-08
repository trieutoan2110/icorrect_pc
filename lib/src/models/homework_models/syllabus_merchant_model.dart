class SyllabusMerchantModel {
  int errorCode;
  String status;
  String? messages;
  List<Syllabus>? data;

  SyllabusMerchantModel({
    required this.errorCode,
    required this.status,
    this.messages,
    this.data,
  });

  factory SyllabusMerchantModel.fromJson(Map<String, dynamic> json) => SyllabusMerchantModel(
    errorCode: json["error_code"],
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<Syllabus>.from(json["data"]!.map((x) => Syllabus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error_code": errorCode,
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Syllabus {
  int id;
  String name;
  String slug;
  String? mota;
  int createdBy;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String level;
  int centerId;
  int sharedByIcorrect;
  int questions;

  Syllabus({
    required this.id,
    required this.name,
    required this.slug,
    required this.mota,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.level,
    required this.centerId,
    required this.sharedByIcorrect,
    required this.questions,
  });

  factory Syllabus.fromJson(Map<String, dynamic> json) => Syllabus(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    mota: json["mota"],
    createdBy: json["created_by"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    level: json["level"],
    centerId: json["center_id"],
    sharedByIcorrect: json["shared_by_icorrect"],
    questions: json["questions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "mota": mota,
    "created_by": createdBy,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "level": level,
    "center_id": centerId,
    "shared_by_icorrect": sharedByIcorrect,
    "questions": questions,
  };
}
