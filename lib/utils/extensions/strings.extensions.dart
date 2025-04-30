extension StringExtension on String {
  bool get isHTML {
    final RegExp htmlRegExp =
        RegExp('<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlRegExp.hasMatch(this);
  }
}

extension StringNullExtension on String? {
  bool get isNotNullAndNotEmpty => this != null && (this?.isNotEmpty ?? false);
}
