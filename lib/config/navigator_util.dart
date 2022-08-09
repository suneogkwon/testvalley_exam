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

  @override
  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute, RoutePredicate predicate) {
    return nav.currentState!.pushAndRemoveUntil(
      newRoute,
      predicate,
    );
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      String newRouteName, RoutePredicate predicate,
      {Object? arguments}) {
    return nav.currentState!.pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
    );
  }
}
