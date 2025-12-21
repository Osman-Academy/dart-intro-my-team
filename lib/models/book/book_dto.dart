class BookDto {
  String? query;
  String? bookId;
  String? author;
  String? subject;
  int? maxResults;
  
  BookDto({
    this.query,
    this.bookId,
    this.author,
    this.subject,
    this.maxResults = 20,
  });
}