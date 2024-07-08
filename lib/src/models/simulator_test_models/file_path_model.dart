import 'dart:convert';

FilePathModel filePathModelFromJson(String str) => FilePathModel.fromJson(json.decode(str));

String filePathModelToJson(FilePathModel data) => json.encode(data.toJson());

class FilePathModel {
  String savePath;
  bool isSuccess = false;

  FilePathModel({
    required this.savePath,
    required this.isSuccess,
  });

  factory FilePathModel.fromJson(Map<String, dynamic> json) => FilePathModel(
    savePath: json["savePath"],
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "savePath": savePath,
    "isSuccess": isSuccess,
  };
}