import 'dart:convert';

List<SyllabusFileModel> syllabusFileModelFromJson(String str) => List<SyllabusFileModel>.from(json.decode(str).map((x) => SyllabusFileModel.fromJson(x)));

String syllabusFileModelToJson(List<SyllabusFileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SyllabusFileModel {
  int errorCode;
  String status;
  Data data;
  String? messages;

  SyllabusFileModel({
    required this.errorCode,
    required this.status,
    required this.data,
    this.messages
  });

  factory SyllabusFileModel.fromJson(Map<String, dynamic> json) => SyllabusFileModel(
    errorCode: json["error_code"],
    status: json["status"],
    messages: json['messages'],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error_code": errorCode,
    "status": status,
    'messages': messages,
    "data": data.toJson(),
  };
}

class Data {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String? nextPageUrl;
  String path;
  String perPage;
  String? prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int id;
  String url;

  Datum({
    required this.id,
    required this.url,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}
