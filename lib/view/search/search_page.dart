import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/format_util.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/generated/assets.dart';
import 'package:testvalley/theme/text_theme.dart';
import 'package:testvalley/viewmodel/recent_keyword_viewmodel.dart';
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

  final SearchKeywordViewModel skvm = locator<SearchKeywordViewModel>();
  final RelatedKeywordViewModel rkvm = locator<RelatedKeywordViewModel>();
  final RecentKeywordViewModel rckvm = locator<RecentKeywordViewModel>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: skvm),
        ChangeNotifierProvider.value(value: rkvm),
        ChangeNotifierProvider.value(value: rckvm),
      ],
      builder: (_, __) {
        skvm.resetState();
        rkvm.resetState();

        return CustomScaffold(
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
                    onTap: () {
                      searchController.clear();
                      _onTapSearchTextClear();
                    },
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
                      return skvm.searchKeyword.isEmpty
                          ? RecentKeywordList()
                          : RelatedKeywordList();
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

  /// 검색바 변경 감지
  void _onChangedKeyword(String keyword) {
    skvm.searchKeyword = keyword;
    rkvm.setRelatedKeywordList(keyword);
  }

  /// 검색바 초기화 이벤트
  void _onTapSearchTextClear() {
    skvm.resetState();
    rkvm.resetState();
  }

  /// 상품 검색
  void _searchProduct(String? keyword) {
    if (keyword != null && keyword != '') {
      rckvm.addKeyword(keyword);
      locator<SearchKeywordViewModel>().searchKeyword = keyword;
      locator<AppNavigator>().pushNamed(AppRoutes.productList);
    }
  }
}
