part of '../cart_page.dart';

class OrderButton extends StatelessWidget {
  OrderButton({Key? key}) : super(key: key);

  final CartViewModel cvm = locator<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F8F8),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: Consumer<CartViewModel>(
        builder: (_, __, ___) {
          int totalOrderPrice = 0;

          for (CartItemModel element in cvm.cartItemList) {
            totalOrderPrice += element.totalPrice;
          }
          return GestureDetector(
            onTap: () => _onTapOrder(totalOrderPrice),
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(right: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text('${cvm.cartItemList.length}'),
                  ),
                  Text(
                    '${totalOrderPrice.toKrFormat()}원 주문하기',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTapOrder(int totalOrderPrice) {
    if (totalOrderPrice == 0) return;

    cvm.cartItemList.clear();

    locator<AppNavigator>().pushNamed(
      AppRoutes.orderComplete,
      arguments: totalOrderPrice,
    );
  }
}
