class SyllabusDBModel {
  // syllabusName TEXT NOT NULL PRIMARY KEY,
  //     total INTEGER NOT NULL,
  // totalDownloaded INTEGER NOT NULL,
  //     capacity REAL,
  // statusDownload INTEGER NOT NULL
  int syllabusID;
  String syllabusName;
  int total;
  int totalDownloaded;
  double capacity;
  int statusDownload; //0 : chua down, 1: da down
  DateTime updateAt;
  DateTime? downloadAt;

  SyllabusDBModel(
      {
      required this.syllabusID,
      required this.syllabusName,
      required this.total,
      required this.totalDownloaded,
      required this.capacity,
      required this.statusDownload,
      required this.updateAt,
        this.downloadAt
      });

  factory SyllabusDBModel.fromJson(Map<String, dynamic> json) => SyllabusDBModel(
      syllabusID: json['syllabusID'],
    syllabusName: json["syllabusName"],
    total: json["total"],
    totalDownloaded: json["totalDownloaded"],
    capacity: json["capacity"],
    statusDownload: json["statusDownload"],
    updateAt: DateTime.parse(json['updateAt']),
    downloadAt: json['downloadAt'] == null ? null : DateTime.parse(json['downloadAt'])
  );

  Map<String, dynamic> toJson() => {
    "syllabusID": syllabusID,
    "syllabusName": syllabusName,
    "total": total,
    "totalDownloaded": totalDownloaded,
    "capacity": capacity,
    "statusDownload": statusDownload,
    "updateAt": updateAt.toIso8601String(),
    "downloadAt": downloadAt?.toIso8601String()
  };
}