part of '../search_page.dart';

class RecentKeywordList extends StatefulWidget {
  const RecentKeywordList({Key? key}) : super(key: key);

  @override
  State<RecentKeywordList> createState() => _RecentKeywordListState();
}

class _RecentKeywordListState extends State<RecentKeywordList> {
  List<String> recentKeywordList =
      Pref().storage.getStringList(Pref.recentKeyword) ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40.0),
        Row(
          children: [
            Text(
              '최근 검색어',
              style: listLabelStyle,
            ),
            const Spacer(),
            GestureDetector(
              onTap: _onTapClear,
              child: Text(
                '전체삭제',
                style: smallCaptionStyle,
              ),
            )
          ],
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: ListView.builder(
            itemCount: recentKeywordList.length,
            itemExtent: 50,
            itemBuilder: (_, index) => _recentKeyword(index),
          ),
        )
      ],
    );
  }

  ListTile _recentKeyword(int index) {
    final String keyword = recentKeywordList[index];

    return ListTile(
      title: Text(
        keyword,
        style: bodyTextStyle,
      ),
      onTap: () => _onTapKeyword(keyword),
      contentPadding: EdgeInsets.zero,
      trailing: GestureDetector(
        onTap: () => _onTapSelectedKeywordDelete(index),
        child: const Icon(
          Icons.close,
          color: Color(0xFF999999),
          size: 20.0,
        ),
      ),
    );
  }

  /// 최근 검색어 탭 이벤트
  void _onTapKeyword(String keyword) {
    locator<SearchKeywordViewModel>().searchKeyword = keyword;
    locator<AppNavigator>().pushNamed(AppRoutes.productList);
  }

  /// 최근 검색어 전체삭제 탭 이벤트
  void _onTapClear() {
    setState(() {
      recentKeywordList = [];
    });
    _saveRecentKeywordList();
  }

  /// 최근 검색어 개별 삭제 탭 이벤트
  void _onTapSelectedKeywordDelete(int index) {
    setState(() {
      recentKeywordList.removeAt(index);
    });
    _saveRecentKeywordList();
  }

  /// 최근검색어([recentKeywordList])를 내부 저장소에 저장한다.
  void _saveRecentKeywordList() {
    Pref().storage.setStringList(
          Pref.recentKeyword,
          recentKeywordList,
        );
  }
}
