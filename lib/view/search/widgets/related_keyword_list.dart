part of '../search_page.dart';

class RelatedKeywordList extends StatelessWidget {
  RelatedKeywordList({Key? key}) : super(key: key);

  final SearchKeywordViewModel skvm = locator<SearchKeywordViewModel>();

  @override
  Widget build(BuildContext context) {
    return Consumer<RelatedKeywordViewModel>(
      builder: (_, rkvm, ___) {
        return rkvm.relatedKeywords.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                itemBuilder: (_, index) {
                  final String title = rkvm.relatedKeywords[index];
                  final List<String> splitTitle = title.removeHtmlTag();

                  return ListTile(
                    onTap: () => _onTapRelatedKeywordItem(title),
                    contentPadding: EdgeInsets.zero,
                    title: RichText(
                      text: TextSpan(
                        children: splitTitle.map((e) {
                          return TextSpan(
                            text: e,
                            style: GoogleFonts.notoSans(
                              fontSize: 14.0,
                              color: e == skvm.searchKeyword
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
                itemCount: rkvm.relatedKeywords.length,
              )
            // 연관 검색어가 없다면 안내 문구 출력
            : const NoRelatedKeywordList();
      },
    );
  }

  void _onTapRelatedKeywordItem(String keyword) {
    final String filteredKeyword = keyword.removeHtmlTagMapJoin();

    skvm.searchKeyword = filteredKeyword;
    locator<AppNavigator>().pushNamed(AppRoutes.productList);
  }
}
