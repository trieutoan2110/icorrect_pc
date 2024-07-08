import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icorrect_pc/src/data_source/constants.dart';
import 'package:icorrect_pc/src/data_source/local/app_shared_references.dart';
import 'package:icorrect_pc/src/presenters/login_presenter.dart';
import 'package:icorrect_pc/src/presenters/verify_presenter.dart';
import 'package:icorrect_pc/src/providers/auth_widget_provider.dart';
import 'package:icorrect_pc/src/providers/verify_provider.dart';
import 'package:icorrect_pc/src/views/screens/auth/login_screen.dart';
import 'package:icorrect_pc/src/views/screens/verify/verify_login_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_colors.dart';
import '../../../models/auth_models/class_merchant_model.dart';
import '../../../utils/Navigations.dart';
import '../../../utils/utils.dart';
import '../../dialogs/circle_loading.dart';
import '../../dialogs/message_alert.dart';
import '../../widgets/input_field_custom.dart';

class VerifyWidget extends StatefulWidget {
  const VerifyWidget({super.key});

  @override
  State<VerifyWidget> createState() => _VerifyWidget();
}

class _VerifyWidget extends State<VerifyWidget> implements VerifyViewContact {
  CircleLoading? _loading;
  late AuthWidgetProvider _provider;
  late VerifyProvider _verifyProvider;
  late VerifyPresenter _verifyPresenter;

  final _txtLicenseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loading = CircleLoading();
    _autoVerify();
    _verifyPresenter = VerifyPresenter(this);
    _provider = Provider.of<AuthWidgetProvider>(context, listen: false);
    _verifyProvider = Provider.of<VerifyProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildVerifyForm();
  }

  Widget _buildVerifyForm() {
    double w = MediaQuery.of(context).size.width / 2;
    double h = MediaQuery.of(context).size.height / 3;
    return Center(
      child: Container(
        width: w,
        height: h,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
        margin: const EdgeInsets.only(bottom: 100),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.gray),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildKeyField(),
            const SizedBox(height: 40),
            SizedBox(
              width: w / 2,
              child: ElevatedButton(
                onPressed: () {
                  _loading?.show(context);
                  _onPressVerify();
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.purple),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        Utils.instance().multiLanguage(StringConstants.verify_button_title),
                        style: const TextStyle(
                            fontSize: 17, color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKeyField() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(StringConstants.input_key,
            style: TextStyle(
                color: AppColors.purple,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        TextField(
          controller: _txtLicenseController,
          decoration:
          InputFieldCustom.init().borderGray10('Key'),
        )
      ],
    );
  }

  void _autoVerify() async {
    // AppSharedPref.instance().clearShared();
    _loading?.show(context);
    String licenseKey = await Utils.instance().getLicenseKey() ?? '';
    String merchantID = await Utils.instance().getMerchantID() ?? '';
    Timer(const Duration(seconds: 2), () {
      if (licenseKey.isNotEmpty && merchantID.isNotEmpty) {
        _verifyPresenter.getListClass(context, merchantID);
      }
      _loading?.hide();
    });
  }

  void _onPressVerify() {
    String license = _txtLicenseController.text.trim();
    _verifyPresenter.verify(context, license);
  }

  @override
  void onVerifyComplete(String merchantID) {
    // _loading?.hide();
    _verifyPresenter.getListClass(context, merchantID);
  }

  @override
  void onVerifyError(String message) {
    _loading?.hide();
    // message = StringConstants.verify_wrong_massage;
    showDialog(
        context: context,
        builder: (context) {
          return MessageDialog(context: context, message: message);
        });
  }

  @override
  void onGetListClassComplete(List<Datum> classes) {
    _verifyProvider.setListClass(classes);
    _provider.setCurrentScreen(const LoginVerifyWidget());
    _loading?.hide();
  }

  @override
  void onGetListClassError(String message) {
    _loading?.hide();
    // message = StringConstants.verify_wrong_massage;
    showDialog(
        context: context,
        builder: (context) {
          return MessageDialog(context: context, message: message);
        });
  }
}
