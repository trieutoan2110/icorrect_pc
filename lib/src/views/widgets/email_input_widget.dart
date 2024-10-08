import 'package:flutter/material.dart';
import 'package:icorrect_pc/src/data_source/constants.dart';
import 'package:icorrect_pc/src/utils/utils.dart';

import 'auth_form_field.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({super.key, required this.emailController});

  final TextEditingController emailController;

  final String regexEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  @override
  Widget build(BuildContext context) {
    return AuthFormField(
      prefixIcon: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset('assets/images/ic_email.png', width: 1, height: 1),
      ),
      autofocus: false,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (emailController.text.isEmpty) {
          return Utils.instance()
              .multiLanguage(StringConstants.empty_email_error_message);
        }

        if (!RegExp(regexEmail).hasMatch(emailController.text)) {
          return Utils.instance()
              .multiLanguage(StringConstants.invalid_email_error_message);
        }

        return null;
      },
      controller: emailController,
      keyboardType: TextInputType.text,
      hintText: StringConstants.email,
      upHintText: StringConstants.email,
      maxLines: 1,
    );
  }
}
