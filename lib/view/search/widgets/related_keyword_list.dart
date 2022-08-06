part of '../search_page.dart';

class RelatedKeywordList extends StatelessWidget {
  const RelatedKeywordList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchViewModel viewModel = context.watch<SearchViewModel>();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      itemBuilder: (_, index) {
        final String keyword = viewModel.searchKeyword;
        final String title = viewModel.relatedKeywords[index];

        final List<String> splitTitle = title.split(RegExp(r'<b>|</b>'));
        splitTitle.removeWhere((element) => element.isEmpty);

        return ListTile(
          onTap: () => _onTapRelatedKeywordItem(splitTitle.join()),
          contentPadding: EdgeInsets.zero,
          title: RichText(
            text: TextSpan(
              children: splitTitle.map((e) {
                return TextSpan(
                  text: e,
                  style: GoogleFonts.notoSans(
                    fontSize: 14.0,
                    color: e == keyword
                        ? const Color(0xFF00D094)
                        : const Color(0xFF333333),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(
        color: Color(0xFFEEEEEE),
        thickness: 1,
        height: 1,
      ),
      itemCount: viewModel.relatedKeywords.length,
    );
  }

  void _onTapRelatedKeywordItem(String keyword) {
    locator<GlobalKey<NavigatorState>>().currentState?.pushNamed(
          AppRoutes.productList,
          arguments: keyword,
        );
  }
}
