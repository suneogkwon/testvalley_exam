part of '../search_page.dart';

class RecentKeywordList extends StatelessWidget {
  const RecentKeywordList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchViewModel viewModel = context.read<SearchViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40.0),
        Row(
          children: [
            Text(
              '최근 검색어',
              style: GoogleFonts.notoSans(
                color: const Color(0xFF333333),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _onTapClear(viewModel),
              child: Text(
                '전체삭제',
                style: GoogleFonts.notoSans(
                  fontSize: 12.0,
                  color: const Color(0xFF999999),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Consumer<SearchViewModel>(
            builder: (_, provider, __) {
              final List<String> keywords = provider.recentSearchKeywords;

              if (keywords.isEmpty) return const SizedBox();

              return ListView.builder(
                itemCount: keywords.length,
                itemExtent: 50,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      keywords[index],
                      style: GoogleFonts.notoSans(
                        fontSize: 14.0,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    trailing: GestureDetector(
                      onTap: () => _onTapSelectedKeywordDelete(
                        viewModel,
                        index: index,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF999999),
                        size: 20.0,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  /// 최근 검색어 전체삭제 탭 이벤트
  void _onTapClear(SearchViewModel viewModel) {
    viewModel.clearRecentSearchKeywords();
  }

  /// 최근 검색어 개별 삭제 탭 이벤트
  void _onTapSelectedKeywordDelete(
    SearchViewModel viewModel, {
    required int index,
  }) {
    viewModel.removeSelectedKeyword(index);
  }
}
