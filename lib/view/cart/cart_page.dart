import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/model/cart_item/cart_item_model.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/viewmodel/cart_viewmodel.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductModel item =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    final CartViewModel cvm = locator<CartViewModel>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cvm),
      ],
      builder: (context, _) {
        cvm.insertItem(item);

        return CustomScaffold(
          appBar: HomeAppBar(
            title: const Text('장바구니'),
          ),
          body: Column(
            children: [
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Consumer<CartViewModel>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Consumer<CartViewModel>(
                                  builder: (context, _, __) {
                                    return SizedBox.square(
                                      dimension: 18,
                                      child: Checkbox(
                                        value: cvm.selectAll,
                                        onChanged: cvm.toggleSelectAll,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '전체선택',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ),
                                Spacer(),
                                Consumer<CartViewModel>(
                                  builder: (_, __, ___) {
                                    final bool atLeastOneChecked =
                                        cvm.cartItemList.any(
                                      (element) => element.checked,
                                    );

                                    if (!atLeastOneChecked) {
                                      return SizedBox();
                                    }

                                    return GestureDetector(
                                      onTap: () =>
                                          _onTapDeleteSelectedItem(cvm),
                                      child: Text(
                                        '선택삭제',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            ...List.generate(
                              cvm.cartItemList.length,
                              (index) {
                                final CartItemModel cartModel =
                                    cvm.cartItemList[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Consumer<CartViewModel>(
                                            builder: (context, _, __) {
                                              return SizedBox.square(
                                                dimension: 18,
                                                child: Checkbox(
                                                  value: cartModel.checked,
                                                  onChanged: (value) =>
                                                      cvm.toggleSelectOne(
                                                          index, value),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              cartModel.item.title.replaceAll(
                                                RegExp(r'<b>|</b>'),
                                                '',
                                              ),
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () =>
                                                _onTapDeleteOne(cvm, index),
                                            child: Text(
                                              '삭제',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        height: 120,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              cartModel.item.image,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Consumer<CartViewModel>(
                                                  builder:
                                                      (context, provider, _) {
                                                    return Text(
                                                      '''${NumberFormat.simpleCurrency(
                                                        name: '',
                                                        decimalDigits: 0,
                                                      ).format(cartModel.totalPrice)}원''',
                                                      style:
                                                          GoogleFonts.notoSans(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(height: 12),
                                                Text(
                                                  cartModel.item.brand,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                const SizedBox(height: 40),
                                                Consumer<CartViewModel>(
                                                  builder:
                                                      (context, provider, _) {
                                                    return Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () =>
                                                              _onTapSubAmount(
                                                                  cvm, index),
                                                          child: Icon(
                                                            Icons
                                                                .remove_circle_outline_rounded,
                                                            size: 30,
                                                            color: cartModel
                                                                        .amount ==
                                                                    1
                                                                ? Colors.black
                                                                    .withOpacity(
                                                                        0.1)
                                                                : null,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 40,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${cartModel.amount}',
                                                            style: GoogleFonts
                                                                .notoSans(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () =>
                                                              _onTapAddAmount(
                                                                  cvm, index),
                                                          child: const Icon(
                                                            Icons
                                                                .add_circle_outline_rounded,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                color: const Color(0xFFF8F8F8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Consumer<CartViewModel>(
                  builder: (context, provider, _) {
                    int totalOrderPrice = 0;

                    for (CartItemModel element in cvm.cartItemList) {
                      totalOrderPrice += element.totalPrice;
                    }
                    return GestureDetector(
                      onTap: () => _onTapOrder(cvm, totalOrderPrice),
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
                              '''${NumberFormat.simpleCurrency(
                                name: '',
                                decimalDigits: 0,
                              ).format(
                                totalOrderPrice,
                              )}원 주문하기''',
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
              )
            ],
          ),
        );
      },
    );
  }

  void _onTapSubAmount(CartViewModel viewModel, int index) {
    viewModel.subItemAmount(index);
  }

  void _onTapAddAmount(CartViewModel viewModel, int index) {
    viewModel.addItemAmount(index);
  }

  void _onTapDeleteSelectedItem(CartViewModel viewModel) {
    viewModel.deleteSelectedItem();
  }

  void _onTapDeleteOne(CartViewModel viewModel, int index) {
    viewModel.deleteOne(index);
  }

  void _onTapOrder(CartViewModel viewModel, int totalOrderPrice) {
    locator<GlobalKey<NavigatorState>>().currentState!.pushNamed(
          AppRoutes.orderComplete,
          arguments: totalOrderPrice,
        );
  }
}
