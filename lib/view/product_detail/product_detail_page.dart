import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/generated/assets.dart';
import 'package:testvalley/viewmodel/product_list_viewmodel.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final ProductListViewModel plvm = locator<ProductListViewModel>();
    final ProductModel item = plvm.pagingController.itemList![index];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: plvm),
      ],
      builder: (context, child) => CustomScaffold(
        appBar: HomeAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CarouselSlider.builder(
                itemCount: 1,
                itemBuilder: (context, index, realIndex) {
                  return Image.network(
                    item.image,
                    fit: BoxFit.cover,
                  );
                },
                options: CarouselOptions(
                  height: 350,
                  viewportFraction: 1,
                ),
              ),
              const Divider(height: 1),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Text(
                      item.title.replaceAll(RegExp(r'<b>|</b>'), ''),
                      style: GoogleFonts.notoSans(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7.0),
                    Text(
                      '''${NumberFormat.simpleCurrency(
                        locale: 'ko',
                        name: '',
                        decimalDigits: 0,
                      ).format(
                        int.parse(
                          item.lowestPrice,
                        ),
                      )} 원''',
                      style: GoogleFonts.notoSans(
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Divider(),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        const Text(
                          '배송비 ',
                          style: TextStyle(height: 1.4),
                        ),
                        const Icon(
                          Icons.circle_notifications_outlined,
                          size: 12,
                        ),
                        Container(
                          width: 1.0,
                          height: 10,
                          color: const Color(0xFFE6E6E6),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                        ),
                        const Text('무료 ~ 3,900원 조건에 따라 차등부과'),
                      ],
                    ),
                    const SizedBox(height: 70.0),
                    const Text(
                      'Detail',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 7.0),
                    Text(
                      '${item.category1} > ${item.category2} > ${item.category3}',
                    ),
                    const SizedBox(height: 20.0),
                    Text('- 입점몰 : ${item.mallName}'),
                    Text('- 브랜드 : ${item.brand}'),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              ProductInfoWebView(item: item),
              const Divider(thickness: 10),
              const CommonMenuList(),
              const SizedBox(height: 100),
              const Divider(height: 1),
              Container(
                margin: const EdgeInsets.all(10),
                height: 45,
                child: Row(
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () => _onTapAddCart(item),
                        child: Container(
                          width: 200,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: const Text(
                            '장바구니 담기',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: GestureDetector(
                        onTap: () => _onTapQuickPurchase(item),
                        child: Container(
                          width: 200,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.black,
                          ),
                          child: const Text(
                            '바로구매',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapAddCart(ProductModel item) {
    locator<GlobalKey<NavigatorState>>().currentState!.pushNamed(
          AppRoutes.cart,
          arguments: item,
        );
  }

  void _onTapQuickPurchase(ProductModel item) {
    locator<GlobalKey<NavigatorState>>().currentState!.pushNamed(
          AppRoutes.orderComplete,
          arguments: int.parse(item.lowestPrice),
        );
  }
}

class ProductInfoWebView extends StatefulWidget {
  const ProductInfoWebView({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  State<ProductInfoWebView> createState() => _ProductInfoWebViewState();
}

class _ProductInfoWebViewState extends State<ProductInfoWebView> {
  double boxHeight = 300;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: boxHeight,
          child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.item.link))),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(border: Border.all()),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (isOpen) {
                  boxHeight = 300;
                } else {
                  boxHeight = 1000;
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('상품정보 더보기'),
                Container(
                  margin: const EdgeInsets.only(bottom: 2, left: 3),
                  child: SvgPicture.asset(
                    Assets.iconsArrow,
                    height: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CommonMenuList extends StatefulWidget {
  const CommonMenuList({Key? key}) : super(key: key);

  @override
  State<CommonMenuList> createState() => _CommonMenuListState();
}

class _CommonMenuListState extends State<CommonMenuList> {
  final List<String> menus = [
    '구매시 주의사항',
    '상품결제 정보',
    '배송정보',
    '교환 및 반품정보',
  ];
  int openedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          openedIndex = panelIndex == openedIndex ? -1 : panelIndex;
        });
      },
      expandedHeaderPadding: EdgeInsets.zero,
      children: List.generate(
        menus.length,
        (index) => ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              alignment: Alignment.centerLeft,
              child: Text(menus[index]),
            );
          },
          body: Container(
            height: 100,
          ),
          isExpanded: index == openedIndex,
        ),
      ),
    );
  }
}
