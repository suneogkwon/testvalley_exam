part of '../product_detail_page.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
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
