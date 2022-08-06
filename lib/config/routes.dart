import 'package:flutter/material.dart';
import 'package:testvalley/view/home/home_page.dart';
import 'package:testvalley/view/product_search_list/product_search_list_page.dart';
import 'package:testvalley/view/search/search_page.dart';

class AppRoutes {
  static String home = '/home';
  static String search = '/home/search';
  static String productList = '/home/prdt_list';

  static Map<String, Widget Function(BuildContext context)> routes =
      <String, Widget Function(BuildContext context)>{
    home: (_) => const HomePage(),
    search: (_) => SearchPage(),
    productList: (_) => const ProductSearchListPage(),
  };
}
