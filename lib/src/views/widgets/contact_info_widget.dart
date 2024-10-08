import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data_source/constants.dart';
import '../../utils/utils.dart';

class ContactInfoWidget extends StatefulWidget {
  const ContactInfoWidget({super.key});

  @override
  State<ContactInfoWidget> createState() => _ContactInfoWidgetState();
}

class _ContactInfoWidgetState extends State<ContactInfoWidget> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;

      //Save app version into local
      Utils.instance().setAppVersion(info.version);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${_packageInfo.appName} version ${_packageInfo.version}',
            style: CustomTextStyle.textGrey_14,
          ),
          Text(
            '${Utils.instance().multiLanguage(StringConstants.contact)}: support@ielts-correction.com',
            style: CustomTextStyle.textGrey_14,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            '@Csupporter JSC',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// class ContactInfoWidget extends StatelessWidget {
//   const ContactInfoWidget({super.key});
//
//   // final PackageInfo info;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Text('$_appName version $_appVersion'),
//           Text('${info.appName} version ${info.version}'),
//           const Text('Contact: support@ielts-correction.com'),
//           const SizedBox(height: 8,),
//           Text('@Csupporter JSC', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
// }
