import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.onWillPop,
    this.blockedPop = false,
  }) : super(key: key);

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Function()? onWillPop;
  final bool blockedPop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: WillPopScope(
        onWillPop: () async {
          if (onWillPop != null) onWillPop!();
          if (blockedPop) return false;
          return true;
        },
        child: Scaffold(
          backgroundColor: backgroundColor ?? Colors.white,
          appBar: appBar,
          body: SafeArea(
            child: body,
          ),
        ),
      ),
    );
  }
}
