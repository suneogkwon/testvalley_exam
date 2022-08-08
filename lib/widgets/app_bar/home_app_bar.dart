import 'package:flutter/material.dart';
import 'package:testvalley/theme/text_theme.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    Key? key,
    Widget? title,
    List<Widget>? actions,
  }) : super(
          key: key,
          title: title,
          titleTextStyle: appBarTitleStyle,
          centerTitle: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          actions: actions != null
              ? [
                  const SizedBox(
                    width: 20.0,
                  ),
                  ...actions,
                  const SizedBox(
                    width: 20.0,
                  ),
                ]
              : null,
        );
}
