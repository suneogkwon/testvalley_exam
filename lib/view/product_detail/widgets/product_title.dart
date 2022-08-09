part of '../product_detail_page.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Text(
          item.title.removeHtmlTagMapJoin(),
          style: GoogleFonts.notoSans(
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 7.0),
        Text(
          '${item.lowestPrice.toKrFormat()}원',
          style: GoogleFonts.notoSans(
            fontSize: 17.0,
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
