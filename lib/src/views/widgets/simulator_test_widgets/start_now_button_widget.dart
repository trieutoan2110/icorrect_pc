import 'package:flutter/material.dart';
import 'package:icorrect_pc/src/data_source/constants.dart';
import 'package:icorrect_pc/src/utils/utils.dart';

class StartNowButtonWidget extends StatefulWidget {
  const StartNowButtonWidget({super.key, required this.startNowButtonTapped, required this.isDownloadSuccess});

  final Function startNowButtonTapped;
  final bool isDownloadSuccess;

  @override
  State<StartNowButtonWidget> createState() => _StartNowButtonWidgetState();
}

class _StartNowButtonWidgetState extends State<StartNowButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.isDownloadSuccess? Utils.instance()
              .multiLanguage(StringConstants.start_now) : Utils.instance()
              .multiLanguage(StringConstants.download_file_description),
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 40,
          alignment: Alignment.center,
          child: Center(
            child: InkWell(
              onTap: () {
                widget.startNowButtonTapped();
              },
              child: Text(
                Utils.instance()
                    .multiLanguage(StringConstants.start_now_button_title),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
