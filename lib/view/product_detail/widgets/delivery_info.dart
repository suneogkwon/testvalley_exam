part of '../product_detail_page.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
