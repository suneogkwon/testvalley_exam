import 'package:flutter/material.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/config/storage_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Pref().initStorage();
  await Pref().storage.setStringList(Pref.recentKeyword, [
    'a',
    'b',
    'c',
    'd',
  ]);
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
      navigatorKey: locator<AppNavigator>().nav,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        // 기기의 텍스트 배율 설정을 무시한다.
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        );
      },
    );
  }
}
