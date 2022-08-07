import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/viewmodel/product_list_viewmodel.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductListViewModel plvm = locator<ProductListViewModel>();
    return ChangeNotifierProvider.value(
      value: plvm,
      builder: (context, child) {
        plvm.loadProducts(initial: true);

        return PagedGridView<int, ProductModel>(
          pagingController:
              context.read<ProductListViewModel>().pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) {
              return ProductGridItem(index: index);
            },
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisExtent: 320,
            mainAxisSpacing: 40.0,
            crossAxisSpacing: 15.0,
          ),
        );
      },
    );
  }
}

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final ProductModel item =
        context.read<ProductListViewModel>().pagingController.itemList![index];
    final String filteredTitle = item.title.replaceAll(RegExp(r'<b>|</b>'), '');
    final String price = NumberFormat.simpleCurrency(
      locale: 'ko',
      name: '',
      decimalDigits: 0,
    ).format(int.parse(item.lowestPrice));

    return GestureDetector(
      onTap: () => _onTapItem(index),
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: constraints.maxWidth,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xFFF7F7F7),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              item.brand,
              style: GoogleFonts.notoSans(
                fontSize: 12.0,
                letterSpacing: -0.3,
                color: const Color(0xFF999999),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              filteredTitle,
              style: GoogleFonts.notoSans(
                fontSize: 14.0,
                height: 1.5,
                letterSpacing: -0.5,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10.0),
            Text(
              '최저가',
              style: GoogleFonts.roboto(
                color: const Color(0xFF00D094),
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: price,
                        style: GoogleFonts.roboto(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      TextSpan(
                        text: '원',
                        style: GoogleFonts.notoSans(
                          fontSize: 12.0,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  size: 12.0,
                  color: Color(0xFF00D094),
                ),
                const SizedBox(width: 2.0),
                Text(
                  item.mallName,
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                    height: 1.5,
                    color: const Color(0xFF333333),
                  ),
                )
              ],
            )
          ],
        );
      }),
    );
  }

  void _onTapItem(int index) {
    locator<GlobalKey<NavigatorState>>().currentState!.pushNamed(
          AppRoutes.productDetail,
          arguments: index,
        );
  }
}
