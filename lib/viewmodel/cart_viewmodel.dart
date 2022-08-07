import 'package:flutter/material.dart';
import 'package:testvalley/data/model/cart_item/cart_item_model.dart';
import 'package:testvalley/data/model/product/product_model.dart';

class CartViewModel extends ChangeNotifier {
  List<CartItemModel> cartItemList = [];

  bool selectAll = false;

  void insertItem(ProductModel item) {
    try {
      final int itemIndex = cartItemList.indexWhere(
        (element) => element.item == item,
      );
      cartItemList[itemIndex].amount += 1;
      cartItemList[itemIndex].totalPrice =
          int.parse(item.lowestPrice) * cartItemList[itemIndex].amount;
    } catch (e) {
      final CartItemModel newCartItem = CartItemModel(
        item: item,
        amount: 1,
        totalPrice: int.parse(item.lowestPrice),
      );
      cartItemList.add(newCartItem);
    }
  }

  void toggleSelectAll(bool? checked) {
    selectAll = checked!;
    for (CartItemModel item in cartItemList) {
      item.checked = selectAll;
    }

    notifyListeners();
  }

  void toggleSelectOne(int index, bool? checked) {
    cartItemList[index].checked = checked!;

    selectAll = cartItemList.every((element) => element.checked);

    notifyListeners();
  }

  void addItemAmount(int index) {
    final CartItemModel cartItem = cartItemList[index];
    cartItem.amount += 1;
    cartItem.totalPrice =
        int.parse(cartItem.item.lowestPrice) * cartItem.amount;
    notifyListeners();
  }

  void subItemAmount(int index) {
    final CartItemModel cartItem = cartItemList[index];

    if (cartItem.amount == 1) return;

    cartItem.amount -= 1;
    cartItem.totalPrice =
        int.parse(cartItem.item.lowestPrice) * cartItem.amount;
    notifyListeners();
  }

  void deleteSelectedItem() {
    cartItemList.removeWhere((element) => element.checked);
    notifyListeners();
  }

  void deleteOne(int index) {
    cartItemList.removeAt(index);

    notifyListeners();
  }
}
