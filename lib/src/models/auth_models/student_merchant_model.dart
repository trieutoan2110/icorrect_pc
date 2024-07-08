class StudentMerchantModel {
  int errorCode;
  String status;
  List<StudentModel>? data;
  String? messages;

  StudentMerchantModel({
    required this.errorCode,
    required this.status,
    this.data,
    this.messages,
  });

  factory StudentMerchantModel.fromJson(Map<String, dynamic> json) => StudentMerchantModel(
    errorCode: json["error_code"],
    status: json["status"],
    data: json["data"] == null ? [] : List<StudentModel>.from(json["data"]!.map((x) => StudentModel.fromJson(x))),
    messages: json["messages"],
  );

  Map<String, dynamic> toJson() => {
    "error_code": errorCode,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "messages": messages,
  };
}

class StudentModel {
  int id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic inviteCode;
  String? phone;
  int? rule;
  dynamic age;
  dynamic address;
  dynamic deletedAt;
  int? centerId;
  int? apiId;
  int? classId;
  dynamic uuid;
  int? canCreateMybank;
  int? answersOfStudentCount;
  String? studentClassName;
  dynamic province;
  dynamic nickName;
  Pivot? pivot;

  StudentModel({
    required this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.inviteCode,
    this.phone,
    this.rule,
    this.age,
    this.address,
    this.deletedAt,
    this.centerId,
    this.apiId,
    this.classId,
    this.uuid,
    this.canCreateMybank,
    this.answersOfStudentCount,
    this.studentClassName,
    this.province,
    this.nickName,
    this.pivot,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    inviteCode: json["invite_code"],
    phone: json["phone"],
    rule: json["rule"],
    age: json["age"],
    address: json["address"],
    deletedAt: json["deleted_at"],
    centerId: json["center_id"],
    apiId: json["api_id"],
    classId: json["class_id"],
    uuid: json["uuid"],
    canCreateMybank: json["can_create_mybank"],
    answersOfStudentCount: json["answers_of_student_count"],
    studentClassName: json["student_class_name"],
    province: json["province"],
    nickName: json["nick_name"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "invite_code": inviteCode,
    "phone": phone,
    "rule": rule,
    "age": age,
    "address": address,
    "deleted_at": deletedAt,
    "center_id": centerId,
    "api_id": apiId,
    "class_id": classId,
    "uuid": uuid,
    "can_create_mybank": canCreateMybank,
    "answers_of_student_count": answersOfStudentCount,
    "student_class_name": studentClassName,
    "province": province,
    "nick_name": nickName,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  int classId;
  int studentId;

  Pivot({
    required this.classId,
    required this.studentId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    classId: json["class_id"],
    studentId: json["student_id"],
  );

  Map<String, dynamic> toJson() => {
    "class_id": classId,
    "student_id": studentId,
  };
}