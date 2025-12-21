import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/bloc/book/book_bloc.dart';
import 'package:book_finder/bloc/book/book_event.dart';
import 'package:book_finder/bloc/book/book_state.dart';
import 'package:book_finder/bloc/category/category_bloc.dart';
import 'package:book_finder/bloc/category/category_event.dart';
import 'package:book_finder/bloc/category/category_state.dart';
import 'package:book_finder/models/book/book.dart';
import 'package:book_finder/models/category/category.dart';
import 'package:book_finder/models/category/category_dto.dart';
import 'package:book_finder/pages/detail.dart';
import 'package:book_finder/common/di/service_locator.dart';
import 'package:book_finder/usecases/book_usecase.dart';
import 'package:book_finder/usecases/category_usecase.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  List<Book> favorites = [];
  List<Category> categories = [];
  String selectedCategory = "All";
  final BookUsecase bookUsecase = sl<BookUsecase>();
  final CategoryUsecase categoryUsecase = sl<CategoryUsecase>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<BookBloc>().add(BookLoadFavoritesEvent());
    context.read<CategoryBloc>().add(CategoryLoadEvent());
  }

  void _showAddCategoryDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Category"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter category name...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<CategoryBloc>().add(
                      CategoryCreateEvent(
                        dto: CategoryDto(name: controller.text),
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showBookCategoriesDialog(Book book) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          List<Category> allCategories = categoryUsecase.getAllCategories();
          return AlertDialog(
            title: const Text("Add to Category"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: allCategories.map((category) {
                  bool isInCategory = category.bookIds.contains(book.id);
                  return CheckboxListTile(
                    title: Text(category.name),
                    value: isInCategory,
                    onChanged: (bool? value) {
                      if (value == true) {
                        context.read<CategoryBloc>().add(
                              CategoryAddBookEvent(
                                dto: CategoryDto(
                                  bookId: book.id,
                                  categoryId: category.id,
                                ),
                              ),
                            );
                      } else {
                        context.read<CategoryBloc>().add(
                              CategoryRemoveBookEvent(
                                dto: CategoryDto(
                                  bookId: book.id,
                                  categoryId: category.id,
                                ),
                              ),
                            );
                      }
                      context.read<BookBloc>().add(BookLoadFavoritesEvent());
                      setDialogState(() {});
                    },
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteCategoryDialog(String categoryId) {
    final category = categoryUsecase.getCategoryByIdDirect(categoryId);
    if (category == null || category.isDefault) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            const SizedBox(width: 8),
            const Text("Delete Category"),
          ],
        ),
        content: Text("Are you sure you want to delete '${category.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              context.read<CategoryBloc>().add(
                    CategoryDeleteEvent(
                      dto: CategoryDto(categoryId: categoryId),
                    ),
                  );
              setState(() {
                selectedCategory = "All";
              });
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    int count,
    bool isSelected,
    VoidCallback onTap,
    {bool canDelete = false, VoidCallback? onDelete}
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.indigo : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$label ($count)",
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[800],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 14,
              ),
            ),
            if (canDelete) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<BookBloc>().add(BookRefreshCurrentEvent());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Icon(Icons.favorite_rounded, size: 24),
                const SizedBox(width: 8),
                const Text(
                  "My Favorites",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: _showAddCategoryDialog,
                tooltip: "Add Category",
              ),
            ],
          ),
          body: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, categoryState) {
                  if (categoryState is CategoryStateLoaded) {
                    categories = categoryState.categories;
                  }

                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo.shade50, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryChip(
                            "All",
                            bookUsecase.favoriteBooks.length,
                            selectedCategory == "All",
                            () => setState(() => selectedCategory = "All"),
                            canDelete: false,
                          ),
                          const SizedBox(width: 8),
                          ...categories.map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: _buildCategoryChip(
                                category.name,
                                category.bookIds.length,
                                selectedCategory == category.id,
                                () => setState(() => selectedCategory = category.id),
                                canDelete: !category.isDefault,
                                onDelete: () => _showDeleteCategoryDialog(category.id),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    if (state is BookStateFavorites) {
                      favorites = state.favorites;
                    }

                    List<Book> displayBooks = selectedCategory == "All"
                        ? favorites
                        : bookUsecase.getBooksInCategory(selectedCategory);

                    if (displayBooks.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark_border_rounded,
                                size: 80,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                selectedCategory == "All"
                                    ? "No favorite books yet"
                                    : "No books in this category",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Start adding books to your favorites!",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: displayBooks.length,
                      itemBuilder: (context, index) {
                        final book = displayBooks[index];
                        List<Category> bookCategories = 
                            categoryUsecase.getCategoriesForBookDirect(book.id);

                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Detail(bookId: book.id),
                              ),
                            );
                            _loadData();
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
                                        colors: [Colors.pink[300]!, Colors.pink[500]!],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.pink.withOpacity(0.3),
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
                                        if (bookCategories.isNotEmpty) ...[
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 6,
                                            runSpacing: 4,
                                            children: bookCategories.map((cat) {
                                              return Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo[50],
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  cat.name,
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
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.favorite_rounded, color: Colors.red),
                                        onPressed: () {
                                          context.read<BookBloc>().add(
                                                BookToggleFavoriteEvent(book: book),
                                              );
                                          Future.delayed(const Duration(milliseconds: 100), () {
                                            context.read<BookBloc>().add(BookLoadFavoritesEvent());
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.label_rounded, color: Colors.indigo),
                                        iconSize: 22,
                                        onPressed: () => _showBookCategoriesDialog(book),
                                      ),
                                    ],
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
      ),
    );
  }
}