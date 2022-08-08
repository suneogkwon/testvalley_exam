import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testvalley/generated/assets.dart';

class SearchKeywordField extends StatelessWidget {
  const SearchKeywordField({
    Key? key,
    this.initialString,
    this.onTap,
    this.readOnly,
    this.showPrefixIcon = false,
    this.suffixIcon,
    this.hintText,
    this.controller,
    this.focus,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  final String? initialString;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final bool? readOnly;
  final bool showPrefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextEditingController? controller;
  final bool? focus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialString,
      controller: controller,
      autofocus: focus ?? false,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly ?? false,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        constraints: const BoxConstraints.expand(height: 40.0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: Color(0xFFDDDDDD),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: Color(0xFFDDDDDD),
          ),
        ),
        prefixIcon: showPrefixIcon
            ? SvgPicture.asset(
                Assets.iconsSearch,
                fit: BoxFit.scaleDown,
                color: const Color(0xFF121212),
              )
            : null,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: GoogleFonts.notoSans(
          fontSize: 14.0,
        ),
      ),
    );
  }
}
