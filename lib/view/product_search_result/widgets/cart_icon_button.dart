part of '../product_search_result_page.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _routeToCartPage,
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: Badge(
          position: const BadgePosition(
            end: 0,
            top: 5,
          ),
          badgeColor: const Color(0xFFC4C4C4),
          badgeContent: Consumer<CartViewModel>(
            builder: (_, provider, __) {
              return Text(
                '${provider.cartItemList.length}',
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.red,
                ),
              );
            },
          ),
          child: const Icon(
            Icons.shopping_cart_rounded,
          ),
        ),
      ),
    );
  }

  void _routeToCartPage() {
    locator<AppNavigator>().pushNamed(AppRoutes.cart);
  }
}
