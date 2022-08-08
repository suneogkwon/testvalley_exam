import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/view/product_search_result/widgets/cart_icon_button.dart';
import 'package:testvalley/view/product_search_result/widgets/product_grid.dart';
import 'package:testvalley/viewmodel/cart_viewmodel.dart';
import 'package:testvalley/viewmodel/search_keyword_viewmodel.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/form/search_keyword_field.dart';
import 'package:testvalley/widgets/layout/content_container.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

class ProductSearchResultPage extends StatelessWidget {
  const ProductSearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String searchKeyword =
        ModalRoute.of(context)!.settings.arguments as String;

    final CartViewModel cvm = locator<CartViewModel>();
    final SearchKeywordViewModel skvm = locator<SearchKeywordViewModel>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cvm),
        ChangeNotifierProvider.value(value: skvm),
      ],
      builder: (context, child) {
        return CustomScaffold(
          appBar: MainAppBar(
            actions: const [
              CartIconButton(),
            ],
          ),
          body: ContentContainer(
            child: Column(
              children: [
                SearchKeywordField(
                  initialString: searchKeyword,
                  onFieldSubmitted: skvm.searchProduct,
                ),
                const SizedBox(height: 25.0),
                const Expanded(
                  child: ProductGrid(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
