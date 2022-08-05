import 'package:flutter/material.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';

void main() {
  initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.home,
      navigatorKey: locator<GlobalKey<NavigatorState>>(),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        // 기기의 텍스트 배율 설정을 무시한다.
        final MediaQueryData setMediaQueryData =
            MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

        return MediaQuery(
          data: setMediaQueryData,
          child: child!,
        );
      },
    );
  }
}
