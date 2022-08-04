import 'package:flutter/material.dart';
import 'package:testvalley/view/home/home_page.dart';

class AppRoutes {
  static String home = '/home';

  static Map<String, Widget Function(BuildContext context)> routes =
      <String, Widget Function(BuildContext context)>{
    home: (context) => const HomePage(),
  };
}
