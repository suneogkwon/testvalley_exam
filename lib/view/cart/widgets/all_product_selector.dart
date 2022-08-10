part of '../cart_page.dart';

class AllProductSelector extends StatelessWidget {
  AllProductSelector({Key? key}) : super(key: key);

  final CartViewModel cvm = locator<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(
          dimension: 18,
          child: Checkbox(
            value: cvm.selectAll,
            onChanged: cvm.toggleSelectAll,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '전체선택',
          style: TextStyle(
            fontSize: 16,
            height: 1.4,
          ),
        ),
        const Spacer(),
        Consumer<CartViewModel>(
          builder: (_, __, ___) {
            final bool atLeastOneChecked = cvm.cartItemList.any(
              (element) => element.checked,
            );

            return !atLeastOneChecked
                ? const SizedBox()
                : GestureDetector(
                    onTap: _onTapDeleteSelectedItem,
                    child: const Text(
                      '선택삭제',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  void _onTapDeleteSelectedItem() {
    cvm.deleteSelectedItem();
  }
}
