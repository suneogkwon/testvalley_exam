part of '../search_page.dart';

class RelatedKeywordList extends StatelessWidget {
  const RelatedKeywordList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchKeywordViewModel svm = locator<SearchKeywordViewModel>();
    final String keyword = svm.searchKeyword;

    return Consumer<RelatedKeywordViewModel>(
      builder: (_, rkvm, __) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          itemBuilder: (_, index) {
            final String title = rkvm.relatedKeywords[index];

            final List<String> splitTitle = title.removeHtmlTag();

            return ListTile(
              onTap: () =>
                  _onTapRelatedKeywordItem(title.removeHtmlTagMapJoin()),
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
          itemCount: rkvm.relatedKeywords.length,
        );
      },
    );
  }

  void _onTapRelatedKeywordItem(String keyword) {
    locator<AppNavigator>().pushNamed(
      AppRoutes.productList,
      arguments: keyword,
    );
  }
}
