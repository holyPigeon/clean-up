import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kyonggi_project/screens/route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // 자신에게 필요한 언어 locale을 모두 추가
      supportedLocales: const [
        Locale('en'), // 영어
        Locale('es'), // 스페인어
        Locale('ko'), // 한국어
        Locale('ja'), // 일본어
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(135, 206, 235, 1),
        textTheme: Typography.whiteCupertino,
      ),
      home: const RoutePage(),
    );
  }
}
