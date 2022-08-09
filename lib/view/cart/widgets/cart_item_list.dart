part of '../cart_page.dart';

class CartItemList extends StatelessWidget {
  CartItemList({Key? key}) : super(key: key);

  final CartViewModel cvm = locator<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        cvm.cartItemList.length,
        (index) {
          final CartItemModel cartModel = cvm.cartItemList[index];
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Column(
              children: [
                _itemTitle(cartModel, index),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        cartModel.item.image,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      _itemInfo(cartModel, index),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column _itemInfo(CartItemModel cartModel, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<CartViewModel>(
          builder: (_, __, ___) {
            return Text(
              '${cartModel.totalPrice.toKrFormat()}원',
              style: GoogleFonts.notoSans(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Text(
          cartModel.item.brand,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            GestureDetector(
              onTap: () => _onTapSubAmount(index),
              child: Icon(
                Icons.remove_circle_outline_rounded,
                size: 30,
                color: cartModel.amount == 1
                    ? Colors.black.withOpacity(0.1)
                    : null,
              ),
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                '${cartModel.amount}',
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onTapAddAmount(index),
              child: const Icon(
                Icons.add_circle_outline_rounded,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onTapSubAmount(int index) {
    cvm.subItemAmount(index);
  }

  void _onTapAddAmount(int index) {
    cvm.addItemAmount(index);
  }

  Row _itemTitle(
    CartItemModel cartModel,
    int index,
  ) {
    return Row(
      children: [
        Consumer<CartViewModel>(
          builder: (_, __, ___) {
            return SizedBox.square(
              dimension: 18,
              child: Checkbox(
                value: cartModel.checked,
                onChanged: (value) => cvm.toggleSelectOne(index, value),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            cartModel.item.title.removeHtmlTagMapJoin(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _onTapDeleteOne(cvm, index),
          child: const Text(
            '삭제',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }

  void _onTapDeleteOne(CartViewModel viewModel, int index) {
    viewModel.deleteOne(index);
  }
}
