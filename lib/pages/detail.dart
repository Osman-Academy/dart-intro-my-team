import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/bloc/book/book_bloc.dart';
import 'package:book_finder/bloc/book/book_event.dart';
import 'package:book_finder/bloc/book/book_state.dart';
import 'package:book_finder/models/book/book.dart';

class Detail extends StatefulWidget {
  final String? bookId;
  Detail({super.key, this.bookId});

  @override
  State<Detail> createState() => DetailState();
}

class DetailState extends State<Detail> {
  Book? book;

  @override
  void initState() {
    super.initState();
    if (widget.bookId != null) {
      context.read<BookBloc>().add(BookViewEvent(bookId: widget.bookId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<BookBloc>().add(BookRefreshCurrentEvent());
        return true;
      },
      child: SafeArea(
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookStateLoading) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Loading..."),
                ),
                body: const Center(child: CircularProgressIndicator()),
              );
            }

            if (state is BookStateView) {
              book = state.book;
            }

            if (book == null) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Book Not Found"),
                ),
                body: const Center(child: Text("Book not found")),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text("Book Details"),
                actions: [
                  IconButton(
                    icon: Icon(
                      book!.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: book!.isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      context.read<BookBloc>().add(
                            BookToggleFavoriteEvent(book: book!),
                          );
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.indigo.shade100, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Container(
                          width: 180,
                          height: 250,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.indigo[300]!, Colors.indigo[500]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.indigo.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book!.title,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (book!.authors.isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.person_outline, size: 18, color: Colors.grey[600]),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    book!.authors.join(", "),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              if (book!.averageRating > 0) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.amber[50],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, size: 18, color: Colors.amber[700]),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${book!.averageRating}/5",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                              if (book!.publishedDate.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 14, color: Colors.grey[700]),
                                      const SizedBox(width: 6),
                                      Text(
                                        book!.publishedDate,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          if (book!.categories.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: book!.categories.map((cat) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[50],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.indigo[200]!),
                                  ),
                                  child: Text(
                                    cat,
                                    style: TextStyle(
                                      color: Colors.indigo[700],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.description_outlined, size: 20, color: Colors.indigo),
                              const SizedBox(width: 8),
                              const Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            book!.description,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}