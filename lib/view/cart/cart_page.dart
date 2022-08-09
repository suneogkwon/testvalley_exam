import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/format_util.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/model/cart_item/cart_item_model.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/view/order/order_complete_page.dart';
import 'package:testvalley/viewmodel/cart_viewmodel.dart';
import 'package:testvalley/viewmodel/related_keyword_viewmodel.dart';
import 'package:testvalley/viewmodel/search_keyword_viewmodel.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

part 'widgets/all_product_selector.dart';
part 'widgets/cart_item_list.dart';
part 'widgets/order_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductModel? item =
        ModalRoute.of(context)!.settings.arguments as ProductModel?;
    final CartViewModel cvm = locator<CartViewModel>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cvm),
      ],
      builder: (context, _) {
        if (item != null) cvm.insertItem(item);

        return CustomScaffold(
          appBar: MainAppBar(
            title: const Text('장바구니'),
          ),
          body: Column(
            children: [
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Consumer<CartViewModel>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            // 전체삭제 체크박스
                            AllProductSelector(),
                            const SizedBox(height: 20),
                            // 장바구니 아이템 리스트
                            CartItemList(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              OrderButton(),
            ],
          ),
        );
      },
    );
  }
}
