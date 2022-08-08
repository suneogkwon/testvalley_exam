import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  /// [child]에 수평 마진을 추가한다.
  /// [vertical]이 제공될 경우 수직 마진을 추가한다.
  const ContentContainer({
    Key? key,
    required this.child,
    this.horizontal,
    this.vertical,
  }) : super(key: key);

  final Widget child;
  final double? horizontal;
  final double? vertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontal ?? 20.0,
        vertical: vertical ?? 0,
      ),
      child: child,
    );
  }
}
