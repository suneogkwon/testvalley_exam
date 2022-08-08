import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:testvalley/view/product_search_list/widgets/product_grid.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/form/search_keyword_field.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

class ProductSearchListPage extends StatelessWidget {
  const ProductSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: MainAppBar(
        actions: [
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: Badge(
              position: const BadgePosition(
                end: 0,
                top: 5,
              ),
              badgeColor: const Color(0xFFC4C4C4),
              badgeContent: const Text(
                '2',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.red,
                ),
              ),
              child: const Icon(
                Icons.shopping_cart_rounded,
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: const [
            SearchKeywordField(),
            SizedBox(height: 25.0),
            Expanded(
              child: ProductGrid(),
            )
          ],
        ),
      ),
    );
  }
}
