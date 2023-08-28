import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../data_source/constants.dart';
import '../../models/homework_models/new_api_135/activities_model.dart';
import '../../utils/utils.dart';

class HomeWorkWidget extends StatelessWidget {
  const HomeWorkWidget(
      {super.key, required this.homeWorkModel, required this.callBack});

  // final HomeWorkModel homeWorkModel;
  final ActivitiesModel homeWorkModel;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomSize.size_10,
        // vertical: CustomSize.size_5,
      ),
      child: Card(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(CustomSize.size_10),
              border: Border.all(
                color: AppColors.defaultPurpleColor,
                width: 0.5,
                style: BorderStyle.solid,
              )),
          child: ListTile(
            onTap: () {
              callBack(homeWorkModel);
            },
            contentPadding: const EdgeInsets.symmetric(
                horizontal: CustomSize.size_15, vertical: CustomSize.size_10),
            leading: Container(
              width: CustomSize.size_50,
              height: CustomSize.size_50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: AppColors.defaultPurpleColor,
                ),
                borderRadius: BorderRadius.circular(CustomSize.size_100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Part",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.defaultPurpleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    Utils.instance().getPartOfTestWithString(
                        homeWorkModel.activityTestOption),
                    style: CustomTextStyle.textBoldPurple_14,
                  ),
                ],
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    // homeWorkModel.name,
                    homeWorkModel.activityName,
                    maxLines: 2,
                    style: CustomTextStyle.textBlack_15,
                  ),
                ),
                const SizedBox(height: CustomSize.size_10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (homeWorkModel.activityEndTime.isNotEmpty)
                          ? homeWorkModel.activityEndTime
                          : '0000-00-00 00:00',
                      style: CustomTextStyle.textGrey_14,
                    ),
                    Text(
                      (Utils.instance().getHomeWorkStatus(homeWorkModel).isNotEmpty)
                          ? '${Utils.instance().getHomeWorkStatus(homeWorkModel)['title']} ${Utils.instance().haveAiResponse(homeWorkModel)}'
                          : '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: (Utils.instance().getHomeWorkStatus(homeWorkModel)
                                .isNotEmpty)
                            ? Utils.instance().getHomeWorkStatus(homeWorkModel)['color']
                            : AppColors.defaultPurpleColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
