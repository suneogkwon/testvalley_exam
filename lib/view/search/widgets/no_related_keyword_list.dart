part of '../search_page.dart';

class NoRelatedKeywordList extends StatelessWidget {
  const NoRelatedKeywordList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.imagesEmoji),
        const SizedBox(height: 32.0),
        Text(
          '조건에 맞는 상품이 없어요',
          style: GoogleFonts.notoSans(
            color: const Color(0xFF333333),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          '빠른 시일 내에 준비할게요!',
          style: GoogleFonts.notoSans(
            color: const Color(0xFF999999),
            fontSize: 14.0,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
