part of '../product_detail_page.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }
}
