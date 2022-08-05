import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({
    Key? key,
    Widget? title,
    double? toolBarHeight,
  }) : super(
          key: key,
          toolbarHeight: toolBarHeight,
          title: title,
          titleTextStyle: GoogleFonts.notoSans(
            color: const Color(0xFF333333),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        );
}
