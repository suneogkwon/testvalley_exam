part of '../product_detail_page.dart';

class CartAndBuyButton extends StatelessWidget {
  const CartAndBuyButton({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 45,
      child: Row(
        children: [
          Flexible(
            child: GestureDetector(
              onTap: _onTapAddCart,
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
              onTap: _onTapQuickPurchase,
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
    );
  }

  void _onTapAddCart() {
    locator<AppNavigator>().pushNamed(
      AppRoutes.cart,
      arguments: item,
    );
  }

  void _onTapQuickPurchase() {
    locator<SearchKeywordViewModel>().resetState();
    locator<RelatedKeywordViewModel>().resetState();

    locator<AppNavigator>().pushNamed(
      AppRoutes.orderComplete,
      arguments: int.parse(item.lowestPrice),
    );
  }
}
