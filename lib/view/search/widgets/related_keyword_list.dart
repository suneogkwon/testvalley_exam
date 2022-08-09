part of '../search_page.dart';

class RelatedKeywordList extends StatelessWidget {
  RelatedKeywordList({Key? key}) : super(key: key);

  final SearchKeywordViewModel skvm = locator<SearchKeywordViewModel>();

  @override
  Widget build(BuildContext context) {
    return Consumer<RelatedKeywordViewModel>(
      builder: (_, rkvm, __) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          itemBuilder: (_, index) {
            final String title = rkvm.relatedKeywords[index];

            final List<String> splitTitle = title.removeHtmlTag();

            return ListTile(
              onTap: () => _onTapRelatedKeywordItem(
                title.removeHtmlTagMapJoin(),
              ),
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
        );
      },
    );
  }

  void _onTapRelatedKeywordItem(String keyword) {
    skvm.searchKeyword = keyword;
    locator<AppNavigator>().pushNamed(AppRoutes.productList);
  }
}
