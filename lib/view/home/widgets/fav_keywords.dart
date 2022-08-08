part of '../home_page.dart';

class FavKeywords extends StatelessWidget {
  const FavKeywords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> favKeyword = <String>[
      '에어컨',
      '냉풍기',
      '선풍기',
      '제습기',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40.0),
        Text(
          '인기 검색어',
          style: listLabelStyle,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: List.generate(
            favKeyword.length,
            (int index) => FavKeywordChip(
              keyword: favKeyword[index],
            ),
          ),
        ),
      ],
    );
  }
}

class FavKeywordChip extends StatelessWidget {
  const FavKeywordChip({
    Key? key,
    required this.keyword,
  }) : super(key: key);

  final String keyword;

  @override
  Widget build(BuildContext context) {
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

  /// 인기 검색어 탭 이벤트
  void _onTapFavKeyword(String keyword) {
    locator<AppNavigator>().pushNamed(
      AppRoutes.productList,
      arguments: keyword,
    );
  }
}
