import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/theme/text_theme.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/form/search_keyword_field.dart';
import 'package:testvalley/widgets/layout/content_container.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

part 'widgets/fav_keywords.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: MainAppBar(
        title: const Text('테스트벨리'),
      ),
      body: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchKeywordField(
              readOnly: true,
              showPrefixIcon: true,
              onTap: _onTapSearchField,
              hintText: '살까말까 고민된다면 검색해보세요!',
            ),
            // 인기 검색어
            const FavKeywords(),
          ],
        ),
      ),
    );
  }

  /// 검색바 탭 이벤트
  void _onTapSearchField() {
    FocusManager.instance.primaryFocus!.unfocus();

    locator<AppNavigator>().pushNamed(AppRoutes.search);
  }
}
