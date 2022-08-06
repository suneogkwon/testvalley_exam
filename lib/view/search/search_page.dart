import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/generated/assets.dart';
import 'package:testvalley/viewmodel/related_keyword_viewmodel.dart';
import 'package:testvalley/viewmodel/search/search_viewmodel.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/form/search_keyword_field.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

part 'widgets/no_related_keyword_list.dart';
part 'widgets/recent_keyword_list.dart';
part 'widgets/related_keyword_list.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: locator<SearchViewModel>()),
        ChangeNotifierProvider.value(value: locator<RelatedKeywordViewModel>()),
      ],
      builder: (context, _) {
        final SearchViewModel viewModel = context.read<SearchViewModel>();

        return CustomScaffold(
          onWillPop: () async => viewModel.resetState(),
          appBar: HomeAppBar(),
          body: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchKeywordField(
                  controller: searchController,
                  focus: true,
                  onChanged: (String? value) => _onChangedKeyword(
                    viewModel,
                    keyword: value ?? '',
                  ),
                  onFieldSubmitted: (String? value) {
                    if (value == null) return;
                    _onSubmit(viewModel, keyword: value);
                  },
                  suffixIcon: GestureDetector(
                    onTap: () => _onTapSearchTextClear(viewModel),
                    child: SvgPicture.asset(
                      Assets.iconsDelete,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<SearchViewModel>(
                    builder: (_, provider, child) {
                      if (provider.searchKeyword.isEmpty) {
                        return const RecentKeywordList();
                      }

                      if (provider.relatedKeywords.isEmpty) {
                        return const NoRelatedKeywordList();
                      }

                      return const RelatedKeywordList();
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
  void _onChangedKeyword(
    SearchViewModel viewModel, {
    required String keyword,
  }) {
    viewModel.setRelatedKeywords(keyword);
  }

  /// 검색바 제출 이벤트
  void _onSubmit(
    SearchViewModel viewModel, {
    required String keyword,
  }) {
    viewModel.routeSearchPage(keyword);
  }

  /// 검색바 초기화 이벤트
  void _onTapSearchTextClear(SearchViewModel viewModel) {
    viewModel.setRelatedKeywords('');
    searchController.clear();
  }
}
