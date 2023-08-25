import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class MessageDialog {
  static Widget alertDialog(BuildContext context, String message) {
    return Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
            width: 400,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Notify",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      message,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    )),
                const Divider(
                  color: AppColors.gray,
                  height: 1,
                ),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                          color: AppColors.purple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )));
  }
}
