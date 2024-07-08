
import 'package:flutter/material.dart';
import 'package:icorrect_pc/src/data_source/constants.dart';
import 'package:icorrect_pc/src/providers/simulator_test_provider.dart';
import 'package:icorrect_pc/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../models/ui_models/download_info.dart';

class DownloadProgressingWidget extends StatefulWidget {
  DownloadProgressingWidget(this.downloadInfo, {super.key, required this.reDownload, required this.visible});

  DownloadInfo downloadInfo;

  final Function reDownload;

  final bool visible;

  @override
  State<DownloadProgressingWidget> createState() => _DownloadProgressingWidgetState();
}

class _DownloadProgressingWidgetState extends State<DownloadProgressingWidget> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 2;

    return Consumer<SimulatorTestProvider>(builder: (context, provider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppAssets.img_download, width: 120, height: 120),
          const SizedBox(height: 8),
          //percent

          Text("${widget.downloadInfo.strPercent}%",
              style: const TextStyle(
                  color: AppColors.defaultLightPurpleColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),

          const SizedBox(height: 8),
          //progress bar
          SizedBox(
            width: w,
            child: _buildProgressBar(),
          ),
          const SizedBox(height: 8),
          //part of total
          Text("${widget.downloadInfo.downloadIndex}/${widget.downloadInfo.total}",
              style: const TextStyle(
                  color: AppColors.defaultLightPurpleColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),

          const SizedBox(height: 8),
          Text(
              widget.visible?
              Utils.instance().multiLanguage(StringConstants.download_again_complete) :
              '${Utils.instance().multiLanguage(StringConstants.downloading)}...',
              style: const TextStyle(
                  color: AppColors.defaultLightPurpleColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          Visibility(
              visible: false,
              child: InkWell (
                onTap: () {},
                child: Text(
                Utils.instance()
                    .multiLanguage(StringConstants.re_load_button_title),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              )),
        ],
      );
    },);
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      backgroundColor: AppColors.defaultLightGrayColor,
      minHeight: 10,
      borderRadius: BorderRadius.circular(10),
      valueColor:
          const AlwaysStoppedAnimation<Color>(AppColors.defaultPurpleColor),
      value: widget.downloadInfo.downloadPercent,
    );
  }
}
