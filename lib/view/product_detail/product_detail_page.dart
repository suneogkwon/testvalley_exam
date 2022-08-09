import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testvalley/config/format_util.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/generated/assets.dart';
import 'package:testvalley/viewmodel/related_keyword_viewmodel.dart';
import 'package:testvalley/viewmodel/search_keyword_viewmodel.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

part 'widgets/cart_and_buy_button.dart';
part 'widgets/common_info_list.dart';
part 'widgets/delivery_info.dart';
part 'widgets/image_slider.dart';
part 'widgets/product_detail.dart';
part 'widgets/product_info.dart';
part 'widgets/product_title.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductModel item =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return CustomScaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상품 이미지 슬라이더
            ImageSlider(item: item),
            const Divider(height: 1),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상품명 및 가격
                  ProductTitle(item: item),
                  const Divider(),
                  // 배송정보
                  const DeliveryInfo(),
                  // 상품 정보
                  ProductInfo(item: item),
                ],
              ),
            ),
            // 상품 상세
            ProductDetail(item: item),
            const Divider(thickness: 10),
            // 상품 공통 설명
            const CommonInfoList(),
            const SizedBox(height: 100),
            const Divider(height: 1),
            // 장바구니 및 바로구매 버튼
            CartAndBuyButton(item: item),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
