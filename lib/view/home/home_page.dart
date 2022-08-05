import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/generated/assets.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/form/search_keyword_field.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> favKeyword = <String>[
      '에어컨',
      '냉풍기',
      '선풍기',
      '제습기',
    ];

    return CustomScaffold(
      appBar: HomeAppBar(
        title: const Text('테스트벨리'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchKeywordField(
              readOnly: true,
              onTap: _onTapSearchField,
              prefixIcon: SvgPicture.asset(
                Assets.iconsSearch,
                fit: BoxFit.scaleDown,
                color: const Color(0xFF121212),
              ),
              hintText: '살까말까 고민된다면 검색해보세요!',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40.0),
                Text(
                  '인기 검색어',
                  style: GoogleFonts.notoSans(
                    color: const Color(0xFF333333),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16.0),
                Wrap(
                  spacing: 9,
                  runSpacing: 9,
                  children: List.generate(
                    favKeyword.length,
                    (int index) => _favoriteKeywordChip(
                      favKeyword[index],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _favoriteKeywordChip(String keyword) {
    return GestureDetector(
      onTap: () => _onTapFavKeyword(keyword),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 9.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(94.0),
        ),
        child: Text(
          keyword,
          style: GoogleFonts.notoSans(
            fontSize: 14.0,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  /// 검색바 탭 이벤트
  void _onTapSearchField() {
    FocusManager.instance.primaryFocus!.unfocus();
    locator<GlobalKey<NavigatorState>>()
        .currentState!
        .pushNamed(AppRoutes.search);
  }

  /// 인기 검색어 탭 이벤트
  void _onTapFavKeyword(String keyword) {}
}
