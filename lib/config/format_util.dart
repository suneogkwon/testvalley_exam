extension FormatString on String {
  /// HTML 태그를 삭제하여 리스트로 반환한다.
  List<String> removeHtmlTag() => split(RegExp(r'<[^>]*>|</[^>]*>'));

  /// HTML 태그 삭제 후 문자열로 만들어 반환한다.
  String removeHtmlTagMapJoin() => splitMapJoin(RegExp(r'<[^>]*>|</[^>]*>'));
}
