import 'package:dio/dio.dart';
import 'package:book_finder/models/book/book.dart';
import 'package:book_finder/models/book/book_dto.dart';
import 'package:book_finder/repositories/repository_book.dart';

class RepositoryBookRemote implements RepositoryBook {
  Dio dio = Dio();
  final String baseUrl = "https://www.googleapis.com/books/v1";

  @override
  Future<List<Book>> search(BookDto bookDto) async {
    try {
      String query = "";
      
      if (bookDto.query != null && bookDto.query!.isNotEmpty) {
        query = bookDto.query!;
      }
      
      if (bookDto.author != null && bookDto.author!.isNotEmpty) {
        if (query.isNotEmpty) query += " ";
        query += "inauthor:${bookDto.author}";
      }
      
      if (bookDto.subject != null && bookDto.subject!.isNotEmpty) {
        if (query.isNotEmpty) query += " ";
        query += "subject:${bookDto.subject}";
      }

      if (query.isEmpty) {
        query = "programming";
      }

      var response = await dio.get(
        "$baseUrl/volumes",
        queryParameters: {
          "q": query,
          "maxResults": bookDto.maxResults,
        },
      );

      List<Book> books = [];
      var data = response.data;

      if (data["items"] != null) {
        for (var item in data["items"]) {
          books.add(_parseBook(item));
        }
      }

      return books;
    } catch (e) {
      print("Error searching books: $e");
      return [];
    }
  }

  @override
  Future<Book> view(BookDto bookDto) async {
    try {
      var response = await dio.get("$baseUrl/volumes/${bookDto.bookId}");
      return _parseBook(response.data);
    } catch (e) {
      print("Error viewing book: $e");
      rethrow;
    }
  }

  String _cleanHtmlTags(String htmlString) {
    String cleaned = htmlString
        .replaceAll(RegExp(r'<br\s*/?>'), '\n')
        .replaceAll(RegExp(r'<p>'), '\n')
        .replaceAll(RegExp(r'</p>'), '\n')
        .replaceAll(RegExp(r'<li>'), '• ')
        .replaceAll(RegExp(r'</li>'), '\n')
        .replaceAll(RegExp(r'<b>|</b>'), '')
        .replaceAll(RegExp(r'<i>|</i>'), '')
        .replaceAll(RegExp(r'<u>|</u>'), '')
        .replaceAll(RegExp(r'<strong>|</strong>'), '')
        .replaceAll(RegExp(r'<em>|</em>'), '')
        .replaceAll(RegExp(r'<h[1-6]>'), '\n')
        .replaceAll(RegExp(r'</h[1-6]>'), '\n')
        .replaceAll(RegExp(r'<div>|</div>'), '')
        .replaceAll(RegExp(r'<span[^>]*>|</span>'), '')
        .replaceAll(RegExp(r'<a[^>]*>|</a>'), '');
    
    cleaned = cleaned.replaceAll(RegExp(r'<[^>]+>'), '');
    
    cleaned = _decodeHtmlEntities(cleaned);
    
    cleaned = cleaned
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .replaceAll(RegExp(r' +'), ' ')
        .trim();
    
    return cleaned;
  }

  String _decodeHtmlEntities(String text) {
    return text
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&mdash;', '—')
        .replaceAll('&ndash;', '–')
        .replaceAll('&hellip;', '…')
        .replaceAll('&copy;', '©')
        .replaceAll('&reg;', '®')
        .replaceAll('&trade;', '™');
  }

  Book _parseBook(Map<String, dynamic> item) {
    var volumeInfo = item["volumeInfo"] ?? {};
    var imageLinks = volumeInfo["imageLinks"] ?? {};

    String thumbnail = "";
    if (imageLinks["thumbnail"] != null) {
      thumbnail = imageLinks["thumbnail"];
    } else if (imageLinks["smallThumbnail"] != null) {
      thumbnail = imageLinks["smallThumbnail"];
    } else if (imageLinks["small"] != null) {
      thumbnail = imageLinks["small"];
    } else if (imageLinks["medium"] != null) {
      thumbnail = imageLinks["medium"];
    }

    if (thumbnail.startsWith("http://")) {
      thumbnail = thumbnail.replaceFirst("http://", "https://");
    }

    if (thumbnail.contains("zoom=1")) {
      thumbnail = thumbnail.replaceAll("zoom=1", "zoom=2");
    }

    String rawDescription = volumeInfo["description"] ?? "No description available";
    String cleanedDescription = _cleanHtmlTags(rawDescription);

    return Book(
      id: item["id"] ?? "",
      title: volumeInfo["title"] ?? "Unknown Title",
      authors: volumeInfo["authors"] != null
          ? List<String>.from(volumeInfo["authors"])
          : [],
      description: cleanedDescription,
      thumbnail: thumbnail,
      publishedDate: volumeInfo["publishedDate"] ?? "",
      categories: volumeInfo["categories"] != null
          ? List<String>.from(volumeInfo["categories"])
          : [],
      averageRating: (volumeInfo["averageRating"] ?? 0.0).toDouble(),
      language: volumeInfo["language"] ?? "en",
    );
  }
}