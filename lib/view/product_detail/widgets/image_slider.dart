part of '../product_detail_page.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
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
    );
  }
}
