import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/format_util.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/generated/assets.dart';
import 'package:testvalley/viewmodel/cart_viewmodel.dart';
import 'package:testvalley/viewmodel/product_list_viewmodel.dart';
import 'package:testvalley/viewmodel/recent_keyword_viewmodel.dart';
import 'package:testvalley/viewmodel/search_keyword_viewmodel.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/form/search_keyword_field.dart';
import 'package:testvalley/widgets/layout/content_container.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

part 'widgets/cart_icon_button.dart';
part 'widgets/product_grid.dart';

class ProductSearchResultPage extends StatelessWidget {
  ProductSearchResultPage({Key? key}) : super(key: key);

  final CartViewModel cvm = locator<CartViewModel>();
  final ProductListViewModel plvm = locator<ProductListViewModel>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController(
      text: locator<SearchKeywordViewModel>().searchKeyword,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cvm),
        ChangeNotifierProvider.value(value: plvm),
      ],
      builder: (context, child) {
        plvm.addPagingListener(searchController.text);

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
                  controller: searchController,
                  onFieldSubmitted: _searchProduct,
                  suffixIcon: GestureDetector(
                    onTap: searchController.clear,
                    child: SvgPicture.asset(
                      Assets.iconsDelete,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                // 상품 리스트
                const ProductGrid(),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 상품 검색
  void _searchProduct(String keyword) {
    if (keyword.isNotEmpty) {
      locator<RecentKeywordViewModel>().addKeyword(keyword);
      locator<SearchKeywordViewModel>().searchKeyword = keyword;
      plvm.loadProducts(
        keyword: keyword,
        initial: true,
      );
    }
  }
}
