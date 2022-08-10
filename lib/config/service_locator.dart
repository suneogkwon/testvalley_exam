import 'package:get_it/get_it.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/data/api/naver/search_api.dart';
import 'package:testvalley/data/api/naver_api_interface.dart';
import 'package:testvalley/data/repository/naver/search_repository.dart';
import 'package:testvalley/data/repository/naver_repository_interface.dart';
import 'package:testvalley/viewmodel/cart_viewmodel.dart';
import 'package:testvalley/viewmodel/product_list_viewmodel.dart';
import 'package:testvalley/viewmodel/recent_keyword_viewmodel.dart';
import 'package:testvalley/viewmodel/related_keyword_viewmodel.dart';
import 'package:testvalley/viewmodel/search_keyword_viewmodel.dart';

/// 서비스 로케이터
///
/// 종속성을 관리한다.
/// 종속성을 추가하려면 [initLocator] 함수에 종속성 추가 구문을 작성한다.
///
/// 사용법 : T model = locator<T>();
final GetIt locator = GetIt.I;

void initLocator() {
  // 네비게이션 싱글톤 생성
  // viewmodel 등 context가 없는 곳에서 Navigator를 사용하기 위한 설정
  locator.registerSingleton(AppNavigator());

  // API 의존성 주입
  locator.registerSingleton<INaverSearchApi>(NaverSearchApi());

  // Repository 의존성 주입
  locator.registerSingleton<INaverSearchRepo>(NaverSearchRepo());

  locator.registerSingleton<CartViewModel>(CartViewModel());
  locator.registerSingleton<SearchKeywordViewModel>(SearchKeywordViewModel());
  locator.registerSingleton<RecentKeywordViewModel>(RecentKeywordViewModel());

  locator.registerFactory<RelatedKeywordViewModel>(
    () => RelatedKeywordViewModel(),
  );
  locator.registerFactory<ProductListViewModel>(() => ProductListViewModel());
}
