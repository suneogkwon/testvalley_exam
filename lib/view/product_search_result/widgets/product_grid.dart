part of '../product_search_result_page.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProductListViewModel>(
        builder: (_, provider, __) {
          return PagedGridView<int, ProductModel>(
            pagingController: provider.pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (_, item, index) {
                return ProductGridItem(item: item);
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
      ),
    );
  }
}

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    final String filteredTitle = item.title.removeHtmlTagMapJoin();
    final String price = item.lowestPrice.toKrFormat();

    return GestureDetector(
      onTap: _onTapItem,
      child: LayoutBuilder(
        builder: (_, constraints) => Column(
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
        ),
      ),
    );
  }

  void _onTapItem() {
    locator<AppNavigator>().pushNamed(
      AppRoutes.productDetail,
      arguments: item,
    );
  }
}
