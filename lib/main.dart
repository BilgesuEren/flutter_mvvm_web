import 'package:flutter/material.dart';
import 'package:flutter_mvvm_web/service/env_login.dart';
import 'package:flutter_mvvm_web/service/get_web_content_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/yaml_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/utils/routes.dart';
import '/theme/theme.dart';
import '/view/landing_view/landing_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LandingPageService authService = LandingPageService();
  await authService.loginCall();
  await authService.getCurrentUserInfo();
  await authService.getWebContentListData();
  runApp(const ProviderScope(
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: routes,
      localizationsDelegates: [
        FlutterI18nDelegate(
          missingTranslationHandler: (key, locale) {
            print("--- Missing Key: $key, languageCode: ${locale!.languageCode}");
          },
          translationLoader: FileTranslationLoader(
            fallbackFile: 'tr',
            basePath: 'assets/flutter_i18n',
            forcedLocale: const Locale('tr'),
            decodeStrategies: [YamlDecodeStrategy()],
            useCountryCode: false
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home:  LandingView(),
    );
  }
}
