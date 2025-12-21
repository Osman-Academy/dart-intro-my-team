import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/bloc/book/book_event.dart';
import 'package:book_finder/bloc/book/book_state.dart';
import 'package:book_finder/models/book/book.dart';
import 'package:book_finder/pages/detail.dart';
import 'package:book_finder/pages/favorites.dart';
import 'package:book_finder/bloc/book/book_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Book> books = [];
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController authorCtrl = TextEditingController();
  String selectedCategory = "All";
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(BookSearchEvent(query: "programming"));
    
    searchCtrl.addListener(_onSearchChanged);
    authorCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchCtrl.dispose();
    authorCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      _performSearch();
    });
    setState(() {});
  }

  void _performSearch() {
    if (searchCtrl.text.isEmpty && 
        authorCtrl.text.isEmpty && 
        selectedCategory == "All") {
      context.read<BookBloc>().add(BookSearchEvent(query: "programming"));
      return;
    }
    
    context.read<BookBloc>().add(BookSearchEvent(
          query: searchCtrl.text.isEmpty ? null : searchCtrl.text,
          author: authorCtrl.text.isEmpty ? null : authorCtrl.text,
          subject: selectedCategory != "All" ? selectedCategory : null,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.menu_book_rounded, size: 28),
              const SizedBox(width: 8),
              const Text(
                "Book Finder",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_rounded),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Favorites()),
                );
                context.read<BookBloc>().add(BookRefreshCurrentEvent());
              },
              tooltip: "Favorites",
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.indigo.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: searchCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search by title or keyword...",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      suffixIcon: searchCtrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  searchCtrl.clear();
                                });
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: authorCtrl,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Author...",
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.person_outline, color: Colors.white),
                            suffixIcon: authorCtrl.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        authorCtrl.clear();
                                      });
                                    },
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          dropdownColor: Colors.indigo.shade700,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          items: ["All", "Fiction", "Science", "History", "Art"]
                              .map((cat) => DropdownMenuItem(
                                    value: cat,
                                    child: Text(cat),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                            _performSearch();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is BookStateSuccess) {
                    books = state.books;
                  }
                  
                  if (state is BookStateInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is BookStateError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline_rounded, size: 64, color: Colors.red[300]),
                            const SizedBox(height: 16),
                            Text(
                              "Oops! Something went wrong",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<BookBloc>().add(
                                      BookSearchEvent(query: "programming"),
                                    );
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Try Again"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (books.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            "No books found",
                            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Detail(bookId: book.id),
                            ),
                          );
                          context.read<BookBloc>().add(BookRefreshCurrentEvent());
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.indigo[300]!, Colors.indigo[500]!],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.indigo.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          height: 1.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              book.authors.isNotEmpty
                                                  ? book.authors.join(", ")
                                                  : "Unknown Author",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (book.averageRating > 0) ...[
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(Icons.star, size: 14, color: Colors.amber[600]),
                                            const SizedBox(width: 4),
                                            Text(
                                              book.averageRating.toStringAsFixed(1),
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                      if (book.categories.isNotEmpty) ...[
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 6,
                                          runSpacing: 4,
                                          children: book.categories.take(2).map((cat) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.indigo[50],
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                cat,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.indigo[700],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: Icon(
                                    book.isFavorite
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: book.isFavorite ? Colors.red : Colors.grey[400],
                                  ),
                                  onPressed: () {
                                    context.read<BookBloc>().add(
                                          BookToggleFavoriteEvent(book: book),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}