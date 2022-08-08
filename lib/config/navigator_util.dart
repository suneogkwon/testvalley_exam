import 'package:flutter/material.dart';

class AppNavigator extends NavigatorState {
  final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

  @override
  Future<T?> push<T extends Object?>(Route<T> route) {
    return nav.currentState!.push(route);
  }

  @override
  Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return nav.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }
}
