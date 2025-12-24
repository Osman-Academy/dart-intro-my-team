import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_search_app/core/di/injection.dart';
import 'package:string_search_app/domain/entities/product.dart';
import 'package:string_search_app/domain/entities/user.dart';
import 'package:string_search_app/presentation/bloc/search_bloc.dart';
import 'package:string_search_app/presentation/bloc/search_event.dart';
import 'package:string_search_app/presentation/bloc/search_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchBloc>(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'String Search',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                final currentType = state.when(
                  initial: (type) => type,
                  loading: (type) => type,
                  loadedUsers: (users, type) => type,
                  loadedProducts: (products, type) => type,
                  error: (message, type) => type,
                );
                return Row(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.people,
                        color: currentType == 'users' ? Colors.white : Colors.white70,
                      ),
                      label: const Text(
                        'Users',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentType == 'users' ? Colors.white24 : Colors.transparent,
                        elevation: currentType == 'users' ? 4 : 0,
                        side: BorderSide(
                          color: currentType == 'users' ? Colors.white : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        context.read<SearchBloc>().add(const SearchEvent.switchType('users'));
                      },
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.shopping_bag,
                        color: currentType == 'products' ? Colors.white : Colors.white70,
                      ),
                      label: const Text(
                        'Products',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentType == 'products' ? Colors.white24 : Colors.transparent,
                        elevation: currentType == 'products' ? 4 : 0,
                        side: BorderSide(
                          color: currentType == 'products' ? Colors.white : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        context.read<SearchBloc>().add(const SearchEvent.switchType('products'));
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 🔍 Search Field
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      final currentType = state.when(
                        initial: (type) => type,
                        loading: (type) => type,
                        loadedUsers: (users, type) => type,
                        loadedProducts: (products, type) => type,
                        error: (message, type) => type,
                      );
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search ${currentType == 'users' ? 'users' : 'products'} by name...',
                            prefixIcon: const Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          onChanged: (value) {
                            final currentType = context.read<SearchBloc>().state.when(
                              initial: (type) => type,
                              loading: (type) => type,
                              loadedUsers: (users, type) => type,
                              loadedProducts: (products, type) => type,
                              error: (message, type) => type,
                            );
                            context.read<SearchBloc>().add(
                              SearchEvent.search(value, type: currentType),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // 📦 Results
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        return state.when(
                          initial: (type) => _HintText(type: type),
                          loading: (type) => const Center(child: CircularProgressIndicator()),
                          loadedUsers: (users, type) {
                            if (users.isEmpty) {
                              return _HintText(text: 'No users found', type: type);
                            }
                            return _UserList(users: users);
                          },
                          loadedProducts: (products, type) {
                            if (products.isEmpty) {
                              return _HintText(text: 'No products found', type: type);
                            }
                            return _ProductList(products: products);
                          },
                          error: (message, type) => Center(
                            child: Text(
                              message,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final String name;
  final String email;

  const _UserCard({
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFF667EEA),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _HintText extends StatelessWidget {
  final String? text;
  final String type;

  const _HintText({this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    final hintText = text ?? 'Start typing to search ${type == 'users' ? 'users' : 'products'}';
    return Center(
      child: Text(
        hintText,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  final List<User> users;

  const _UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return _UserCard(
          name: user.name,
          email: user.email,
        );
      },
    );
  }
}

class _ProductList extends StatelessWidget {
  final List<Product> products;

  const _ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductCard(
          title: product.title,
          price: product.price,
          category: product.category,
          image: product.image,
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String category;
  final String image;

  const _ProductCard({
    required this.title,
    required this.price,
    required this.category,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF667EEA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: 40,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF667EEA),
            ),
          ),
        ],
      ),
    );
  }
}
