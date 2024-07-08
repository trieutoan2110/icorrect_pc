import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../constants.dart';

class FileStorageHelper {
  static Future<String> getExternalDocumentPath() async {
    Directory? directory = Directory('');
    // directory = await getExternalStorageDirectory();
    // directory = await getDownloadsDirectory();
    directory = await getApplicationSupportDirectory();
    // directory = await getApplicationDocumentsDirectory();
    String exPath = directory.path;
    exPath += '/icorrect_log';
    if (kDebugMode) {
      print("DEBUG: Saved Path: $exPath");
    }
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _getRootPath async {
    // final directory = await getExternalDocumentPath();
    // return directory;

    final directory = await getApplicationSupportDirectory();
    if (!directory.existsSync()) {
      directory.createSync();
    }
    return directory.path;
  }

  static Future<String> getFolderPath(
      MediaType mediaType, String? testId) async {
    final path = await _getRootPath;

    String folder = '';
    if (mediaType == MediaType.video) {
      folder = StringClass.video;
    } else if (mediaType == MediaType.audio) {
      folder = StringClass.audio;
    } else {
      folder = StringClass.image;
    }

    String filePath = '';

    if (null != testId) {
      filePath = '$path\\$folder\\$testId';
    } else {
      filePath = '$path\\$folder';
    }

    Directory hideDirectory = Directory(filePath);
    if (!hideDirectory.existsSync()) {
      hideDirectory.createSync();
    }
    return hideDirectory.path;
  }

  static Future<String> getFolderPathVideoDIO(
      MediaType mediaType, String? testId) async {
    final path = await _getRootPath;

    String folder = '';
    if (mediaType == MediaType.video) {
      folder = StringClass.video;
    } else if (mediaType == MediaType.audio) {
      folder = StringClass.audio;
    } else {
      folder = StringClass.image;
    }

    String filePath = '';

    if (null != testId) {
      filePath = '$path\\$folder\\$testId';
    } else {
      filePath = '$path\\$folder';
    }

    Directory hideDirectory = Directory(filePath);
    if (!hideDirectory.existsSync()) {
      hideDirectory.createSync();
    }
    return hideDirectory.path;
  }

  static Future<File> writeVideo(
      String bytes, String name, MediaType mediaType) async {
    final path = await getFolderPath(mediaType, null);

    File file = File('$path\\$name');
    if (kDebugMode) {
      print('DEBUG: SAVE VIDEO FILE: $path\\$name');
    }
    return file.writeAsString(bytes);
  }

  static Future<String> readVideoFromFile(
      String fileName, MediaType mediaType) async {
    try {
      final path = await getFolderPath(mediaType, null);
      File file = File('$path\\$fileName');
      final content = file.readAsStringSync();
      return content;
    } catch (e) {
      return '';
    }
  }

  static Future<bool> checkExistFile(
      String fileName, MediaType mediaType, String? testId) async {
    final path = await getFolderPath(mediaType, testId);
    String filePath = '$path\\$fileName';
    bool result = await File(filePath).exists();
    return result;
  }

  static Future<bool> newCheckExistFile(String fileName, MediaType mediaType) async {
    final path = await getFolderPath(mediaType, null);
    try {
      await for (var entity in Directory(path).list(recursive: true, followLinks: false)) {
        if (entity is File && entity.path.endsWith(fileName)) {
          return true;
        }
      }
    } catch (e) {
      print('Có lỗi xảy ra: $e');
    }
    return false;
  }

  static Future<String> getFilePath(
      String fileName, MediaType mediaType, String? testId) async {
    final path = await getFolderPath(mediaType, testId);
    String filePath = '$path\\$fileName';
    return filePath;
  }

  static Future<String> newGetFilePath(String fileName, MediaType mediaType) async {
    final path = await getFolderPath(mediaType, null);
    try {
      await for (var entity in Directory(path).list(recursive: true, followLinks: false)) {
        if (entity is File && entity.path.endsWith(fileName)) {
          return entity.path;
        }
      }
    } catch (e) {
      print('Có lỗi xảy ra: $e');
    }
    return '';
  }

  static Future<bool> deleteFile(
      String fileName, MediaType mediaType, String? testId) async {
    try {
      String filePath = await getFilePath(fileName, mediaType, testId);
      File file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('DEBUG: Error when delete file: ${e.toString()}');
      }
      return false;
    }
  }

  static Future<bool> newDeleteFile(String path) async {
    try {
      File file = File(path);
      if (await file.exists()) {
        await file.delete();
        if (kDebugMode) {
          print('DEBUG: delete file: $path');
        }
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('DEBUG: Error when delete file: ${e.toString()}');
      }
      return false;
    }
  }
}
