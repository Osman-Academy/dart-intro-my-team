class SearchMatch {
  final int start;
  final int end;
  final String match;

  SearchMatch({required this.start, required this.end, required this.match});

  Map<String, dynamic> toJson() => {'start': start, 'end': end, 'match': match};
}

class SearchPatternUseCase {
  List<SearchMatch> execute({
    required String text,
    required String pattern,
    bool caseSensitive = false,
  }) {
    if (pattern.isEmpty) return [];
    final regExp = RegExp(
      pattern,
      caseSensitive: caseSensitive,
      multiLine: true,
    );
    return regExp.allMatches(text).map((m) {
      return SearchMatch(start: m.start, end: m.end, match: m.group(0) ?? '');
    }).toList();
  }
}
