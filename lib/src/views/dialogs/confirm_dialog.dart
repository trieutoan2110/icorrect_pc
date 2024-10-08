import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../data_source/constants.dart';

class ConfirmDialogWidget extends StatelessWidget {
  const ConfirmDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.cancelButtonTitle,
    required this.okButtonTitle,
    required this.cancelButtonTapped,
    required this.okButtonTapped,
  });

  final String title;
  final String message;
  final String cancelButtonTitle;
  final String okButtonTitle;
  final Function cancelButtonTapped;
  final Function okButtonTapped;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        width: (w < SizeLayout.MyTestScreenSize) ? w : w / 3,
        child: Wrap(
          children: [
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, right: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel_outlined, size: 25),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: FontsSize.fontSize_16,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        Text(message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: FontsSize.fontSize_15,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  cancelButtonTapped();
                                },
                                child: Text(
                                  cancelButtonTitle,
                                  style: const TextStyle(
                                      color: AppColors.defaultGrayColor,
                                      fontSize: FontsSize.fontSize_15,
                                      fontWeight: FontWeight.w700),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  okButtonTapped();
                                },
                                child: Text(
                                  okButtonTitle,
                                  style: const TextStyle(
                                      color: AppColors.defaultPurpleColor,
                                      fontSize: FontsSize.fontSize_15,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
