import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/format_util.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/config/storage_util.dart';
import 'package:testvalley/generated/assets.dart';
import 'package:testvalley/theme/text_theme.dart';
import 'package:testvalley/viewmodel/related_keyword_viewmodel.dart';
import 'package:testvalley/viewmodel/search_keyword_viewmodel.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/form/search_keyword_field.dart';
import 'package:testvalley/widgets/layout/content_container.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

part 'widgets/no_related_keyword_list.dart';
part 'widgets/recent_keyword_list.dart';
part 'widgets/related_keyword_list.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();
  final SearchKeywordViewModel skvm = locator<SearchKeywordViewModel>();
  final RelatedKeywordViewModel rkvm = locator<RelatedKeywordViewModel>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: skvm),
        ChangeNotifierProvider.value(value: rkvm),
      ],
      builder: (context, _) {
        return CustomScaffold(
          onWillPop: _onWillPop,
          appBar: MainAppBar(),
          body: ContentContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchKeywordField(
                  controller: searchController,
                  focus: true,
                  onFieldSubmitted: _searchProduct,
                  onChanged: _onChangedKeyword,
                  suffixIcon: GestureDetector(
                    onTap: _onTapSearchTextClear,
                    child: SvgPicture.asset(
                      Assets.iconsDelete,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer2<SearchKeywordViewModel,
                      RelatedKeywordViewModel>(
                    builder: (_, __, ___, ____) {
                      // 검색바가 비어있다면 최근 검색어 출력
                      if (skvm.searchKeyword.isEmpty) {
                        return const RecentKeywordList();
                      }
                      // 연관 검색어가 없다면 안내 문구 출력
                      if (rkvm.relatedKeywords.isEmpty) {
                        return const NoRelatedKeywordList();
                      }

                      return RelatedKeywordList();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 뒤로 갈 때
  void _onWillPop() {
    skvm.resetState();
    rkvm.resetState();
  }

  /// 검색바 변경 감지
  void _onChangedKeyword(String keyword) {
    skvm.setSearchKeyword(keyword);
    rkvm.setRelatedKeywordList(keyword);
  }

  /// 검색바 초기화 이벤트
  void _onTapSearchTextClear() {
    skvm.resetState();
    rkvm.resetState();
    searchController.clear();
  }

  /// 상품 검색
  void _searchProduct(String? keyword) {
    if (keyword != null && keyword != '') {
      final List<String> recentKeywordList =
          Pref().storage.getStringList(Pref.recentKeyword) ?? [];

      recentKeywordList.insert(0, keyword);

      Pref().storage.setStringList(
            Pref.recentKeyword,
            recentKeywordList,
          );

      locator<SearchKeywordViewModel>().searchKeyword = keyword;
      locator<AppNavigator>().pushNamed(AppRoutes.productList);
    }
  }
}
