import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icorrect_pc/core/app_assets.dart';
import 'package:icorrect_pc/core/app_colors.dart';
import 'package:icorrect_pc/src/data_source/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../data_source/local/file_storage_helper.dart';
import '../../models/log_models/log_model.dart';
import '../../models/simulator_test_models/file_topic_model.dart';
import '../../models/simulator_test_models/question_topic_model.dart';
import '../../providers/re_answer_provider.dart';
import '../../utils/utils.dart';
import 'package:record/record.dart';

// ignore: must_be_immutable
class ReAnswerDialog extends Dialog {
  final BuildContext _context;
  final QuestionTopicModel _question;
  final int _indexReanswer;
  Timer? _countDown;
  int _timeRecord = 30;
  late Record _record;
  String _filePath = '';
  String _fileName = '';
  final String _currentTestId;
  final Function(QuestionTopicModel question, int index) _finishReanswerCallback;

  ReAnswerDialog(this._context, this._question, this._currentTestId, this._indexReanswer,
      this._finishReanswerCallback,
      {super.key});

  @override
  double? get elevation => 0;

  @override
  Color? get backgroundColor => Colors.white;
  @override
  ShapeBorder? get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));

  @override
  Widget? get child => _buildDialog();

  Widget _buildDialog() {
    _timeRecord = Utils.instance().getRecordTime(_question.numPart);

    _record = Record();
    _startCountDown();
    _startRecord();

    return Container(
      width: 400,
      height: 280,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Utils.instance()
                  .multiLanguage(StringConstants.answer_being_recorded),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const Image(image: AssetImage(AppAssets.img_micro)),
            const SizedBox(height: 10),
            Consumer<ReAnswerProvider>(
              builder: (context, reAnswerProvider, child) {
                return Text(
                  reAnswerProvider.strCount,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    _cancelReAnswer();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.defaultGrayColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      Utils.instance()
                          .multiLanguage(StringConstants.cancel_button_title),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                const SizedBox(width: 20),
                Consumer<ReAnswerProvider>(
                    builder: (context, reAnswerProvider, child) {
                  return Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      _finishReAnswerSimulatorTest(_question);
                    },
                    style: ButtonStyle(
                      backgroundColor: _canFinishReanswer()
                          ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 11, 180, 16))
                          : MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 199, 221, 200)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        Utils.instance()
                            .multiLanguage(StringConstants.finish_button_title),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ));
                }),
                const SizedBox(width: 20),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _finishReAnswerSimulatorTest(QuestionTopicModel question) async {
    if (_canFinishReanswer()) {
      if (question.answers.isNotEmpty) {
        question.answers[_indexReanswer].url = _fileName;
        question.reAnswerCount = question.reAnswerCount + 1;
        _record.stop();
        _countDown!.cancel();
        _finishReanswerCallback(question, _indexReanswer);
      } else {
        FileTopicModel answer = FileTopicModel(url: _fileName);
        question.answers = [answer];
        question.repeatIndex = 0;
        _record.stop();
        _countDown!.cancel();
        _finishReanswerCallback(question, _indexReanswer);
      }

      Map<String, dynamic> info = {
        StringConstants.k_question_content: question.content,
        StringConstants.k_file_audio_path: _filePath,
        // StringConstants.k_size_file_audio: await File(_filePath).length()
      };

      _createLog(action: LogEvent.actionFinishReAnswer, data: info);

      Navigator.pop(_context);
    }
  }

  // Future<void> _finishReAnswer(QuestionTopicModel question) async {
  //   if (_canFinishReanswer()) {
  //     if (question.answers.isNotEmpty) {
  //       question.answers.last.url = _fileName;
  //       question.reAnswerCount = question.reAnswerCount + 1;
  //       _record.stop();
  //       _countDown!.cancel();
  //       _finishReanswerCallback(question);
  //     } else {
  //       FileTopicModel answer = FileTopicModel(url: _fileName);
  //       question.answers = [answer];
  //       question.repeatIndex = 0;
  //       _record.stop();
  //       _countDown!.cancel();
  //       _finishReanswerCallback(question);
  //     }
  //
  //     Map<String, dynamic> info = {
  //       StringConstants.k_question_content: question.content,
  //       StringConstants.k_file_audio_path: _filePath,
  //       // StringConstants.k_size_file_audio: await File(_filePath).length()
  //     };
  //
  //     _createLog(action: LogEvent.actionFinishReAnswer, data: info);
  //
  //     Navigator.pop(_context);
  //   }
  // }

  bool _canFinishReanswer() {
    int timeCounting =
        Provider.of<ReAnswerProvider>(_context, listen: false).numCount;
    return _timeRecord - timeCounting >= 2;
  }

  void _cancelReAnswer() async {
    if (File(_filePath).existsSync()) {
      await File(_filePath).delete();
    }
    _record.stop();
    _countDown!.cancel();
    // ignore: use_build_context_synchronously
    Map<String, dynamic> info = {

    };

    _createLog(action: LogEvent.actionCancelReanswer, data: info);
    Navigator.pop(_context);
  }

  void _startCountDown() {
    Future.delayed(Duration.zero).then((value) {
      _countDown != null ? _countDown!.cancel() : '';
      _countDown = _countDownTimer(_context, _timeRecord, false);
      Provider.of<ReAnswerProvider>(_context, listen: false)
          .setCountDown("00:$_timeRecord", _timeRecord);
    });
  }

  void _startRecord() async {
    _fileName = '${await Utils.instance().generateAudioFileName()}.wav';
    _filePath =
        '${await FileStorageHelper.getFolderPath(MediaType.audio, null)}'
        '\\$_fileName';

    if (await _record.hasPermission()) {

      Map<String, dynamic> info = {
        StringConstants.k_question_content: _question.content,
        StringConstants.k_file_audio_path: _fileName
      };

      _createLog(action: LogEvent.startRecordReanswer, data: info);

      await _record.start(
        path: _filePath,
        encoder: Platform.isWindows ? AudioEncoder.wav : AudioEncoder.pcm16bit,
        bitRate: 128000,
        samplingRate: 44100,
      );
    } else {
      await openAppSettings();
    }
  }

  Timer _countDownTimer(BuildContext context, int count, bool isPart2) {
    bool finishCountDown = false;
    const oneSec = Duration(seconds: 1);
    return Timer.periodic(oneSec, (Timer timer) {
      if (count < 1) {
        timer.cancel();
      } else {
        count = count - 1;
      }

      dynamic minutes = count ~/ 60;
      dynamic seconds = count % 60;

      dynamic minuteStr = minutes.toString().padLeft(2, '0');
      dynamic secondStr = seconds.toString().padLeft(2, '0');

      Provider.of<ReAnswerProvider>(_context, listen: false)
          .setCountDown("$minuteStr:$secondStr", count);

      if (count == 0 && !finishCountDown) {
        finishCountDown = true;
        _finishReAnswerSimulatorTest(_question);
      }
    });
  }

  void _createLog(
      {required String action, required Map<String, dynamic>? data}) async {
    if (_context.mounted) {
      //Add action log
      LogModel actionLog =
      await Utils.instance().prepareToCreateLog(_context, action: action);
      if (null != data) {
        if (data.isNotEmpty) {
          actionLog.addData(
              key: StringConstants.k_data, value: jsonEncode(data));
        }
      }
      Utils.instance().addLog(actionLog, LogEvent.none);
    }
  }
}
