import 'package:flutter/material.dart';
import 'package:testvalley/view/cart/cart_page.dart';
import 'package:testvalley/view/home/home_page.dart';
import 'package:testvalley/view/order/order_complete_page.dart';
import 'package:testvalley/view/product_detail/product_detail_page.dart';
import 'package:testvalley/view/product_search_result/product_search_result_page.dart';
import 'package:testvalley/view/search/search_page.dart';

class AppRoutes {
  static String home = '/home';
  static String search = '/home/search';
  static String productList = '/home/search/prdt_list';
  static String productDetail = '/home/search/prdt_list/detail';
  static String cart = '/home/cart';
  static String orderComplete = '/home/order_cmpl';

  static Map<String, Widget Function(BuildContext context)> routes =
      <String, Widget Function(BuildContext context)>{
    home: (_) => const HomePage(),
    search: (_) => SearchPage(),
    productList: (_) => const ProductSearchResultPage(),
    productDetail: (_) => const ProductDetailPage(),
    cart: (_) => const CartPage(),
    orderComplete: (_) => const OrderCompletePage(),
  };
}
