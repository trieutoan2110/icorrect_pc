import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:icorrect_pc/src/data_source/constants.dart';
import 'package:icorrect_pc/src/providers/auth_widget_provider.dart';
import 'package:icorrect_pc/src/providers/camera_preview_provider.dart';
import 'package:icorrect_pc/src/providers/home_provider.dart';
import 'package:icorrect_pc/src/providers/main_widget_provider.dart';
import 'package:icorrect_pc/src/providers/my_test_provider.dart';
import 'package:icorrect_pc/src/providers/play_answer_provider.dart';
import 'package:icorrect_pc/src/providers/re_answer_provider.dart';
import 'package:icorrect_pc/src/providers/simulator_test_provider.dart';
import 'package:icorrect_pc/src/providers/submit_video_provider.dart';
import 'package:icorrect_pc/src/providers/test_room_provider.dart';
import 'package:icorrect_pc/src/providers/timer_provider.dart';
import 'package:icorrect_pc/src/providers/user_auth_detail_provider.dart';
import 'package:icorrect_pc/src/views/screens/auth/login_screen.dart';
import 'package:icorrect_pc/src/views/screens/auth_screen_manager.dart';
import 'package:icorrect_pc/src/views/test/my_test/my_test_screen.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'src/data_source/multi_language.dart';
import 'src/views/screens/auth/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setMinimumSize(const Size(800, 800));
      await windowManager.center();
      await windowManager.show();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  @override
  void initState() {
    super.initState();
    _localization.init(
      mapLocales: [
        const MapLocale('en', MultiLanguage.EN),
        const MapLocale('vn', MultiLanguage.VN),
      ],
      initLanguageCode: 'vn',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthWidgetProvider()),
          ChangeNotifierProvider(create: (_) => MainWidgetProvider()),
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => SimulatorTestProvider()),
          ChangeNotifierProvider(create: (_) => ReAnswerProvider()),
          ChangeNotifierProvider(create: (_) => PlayAnswerProvider()),
          ChangeNotifierProvider(create: (_) => TimerProvider()),
          ChangeNotifierProvider(create: (_) => MyTestProvider()),
          ChangeNotifierProvider(create: (_) => CameraPreviewProvider()),
          ChangeNotifierProvider(create: (_) => UserAuthDetailProvider()),
        ],
        child: MaterialApp(
            supportedLocales: _localization.supportedLocales,
            localizationsDelegates: _localization.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen()));
  }
}
