import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_search_bloc.dart';
import '../bloc/movie_search_event.dart';
import '../bloc/movie_search_state.dart';
import '../widgets/movie_card.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MovieSearchBloc>().add(
          const MovieSearchEvent.loadPopularMovies(),
        );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      context.read<MovieSearchBloc>().add(
            const MovieSearchEvent.loadPopularMovies(),
          );
    } else {
      context.read<MovieSearchBloc>().add(
            MovieSearchEvent.searchMovies(query),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, state) {
                return state.when(
                  initial: () => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 80,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search for movies',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (movies) {
                    if (movies.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.movie_filter_outlined,
                              size: 80,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No movies found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: movies[index]);
                      },
                    );
                  },
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 80,
                          color: Colors.red[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_searchController.text.isEmpty) {
                              context.read<MovieSearchBloc>().add(
                                    const MovieSearchEvent.loadPopularMovies(),
                                  );
                            } else {
                              context.read<MovieSearchBloc>().add(
                                    MovieSearchEvent.searchMovies(
                                      _searchController.text,
                                    ),
                                  );
                            }
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}