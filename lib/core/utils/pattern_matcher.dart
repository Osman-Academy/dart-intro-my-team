bool matchesPattern(String text, String pattern) {
  final t = text.toLowerCase();
  final p = pattern.toLowerCase().trim();

  if (p.isEmpty) return true;

  final escaped = RegExp.escape(p)
      .replaceAll(r'\*', '.*')
      .replaceAll(r'\?', '.');

  final re = RegExp('^$escaped\$');
  return re.hasMatch(t);
}
