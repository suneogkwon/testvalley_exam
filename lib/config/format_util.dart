import 'package:intl/intl.dart';

extension FormatString on String {
  /// HTML 태그를 삭제하여 리스트로 반환한다.
  List<String> removeHtmlTag() => split(RegExp(r'<[^>]*>|</[^>]*>'));

  /// HTML 태그 삭제한 문자열을 반환한다.
  String removeHtmlTagMapJoin() => replaceAll(RegExp(r'<[^>]*>|</[^>]*>'), '');

  String toKrFormat() => NumberFormat.simpleCurrency(
        locale: 'ko',
        name: '',
        decimalDigits: 0,
      ).format(int.parse(this));
}

extension KRNumberFormat on num {
  String toKrFormat() => NumberFormat.simpleCurrency(
        locale: 'ko',
        name: '',
        decimalDigits: 0,
      ).format(this);
}
