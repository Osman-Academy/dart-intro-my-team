import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_search_bloc.dart';
import '../bloc/movie_search_event.dart';
import '../bloc/movie_search_state.dart';
import '../bloc/saved_movies_bloc.dart';
import '../widgets/movie_card.dart';
import 'movie_details_page.dart';
import 'saved_movies_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    // слушаем скролл для бесконечной прокрутки
    _scrollController.addListener(_onScroll);
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent * 0.8) {
      // загружаем еще когда дошли до 80% списка
      context.read<MovieSearchBloc>().add(const MovieSearchEvent.loadMore());
    }
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedMoviesPage(),
                ),
              ).then((_) {
                // обновляем список после возврата
                final currentState = context.read<MovieSearchBloc>().state;
                if (currentState is MovieSearchLoaded && currentState.searchQuery != null) {
                  context.read<MovieSearchBloc>().add(
                        MovieSearchEvent.searchMovies(currentState.searchQuery!),
                      );
                } else {
                  context.read<MovieSearchBloc>().add(
                        const MovieSearchEvent.loadPopular(),
                      );
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Поисковая панель
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<MovieSearchBloc>().add(
                                const MovieSearchEvent.clearSearch(),
                              );
                          context.read<MovieSearchBloc>().add(
                                const MovieSearchEvent.loadPopular(),
                              );
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (query) {
                if (query.trim().isNotEmpty) {
                  context.read<MovieSearchBloc>().add(
                        MovieSearchEvent.searchMovies(query),
                      );
                }
              },
              onChanged: (value) {
                setState(() {}); // для обновления suffixIcon
              },
            ),
          ),
          
          // Список фильмов
          Expanded(
            child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, state) {
                return state.when(
                  initial: () => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.movie, size: 64, color: Colors.grey[600]),
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
                  loaded: (movies, currentPage, hasMorePages, searchQuery) {
                    if (movies.isEmpty) {
                      return const Center(
                        child: Text('No movies found'),
                      );
                    }
                    
                    return GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: movies.length + (hasMorePages ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == movies.length) {
                          // индикатор загрузки в конце списка
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        
                        final movie = movies[index];
                        
                        return MovieCard(
                          movie: movie,
                          onTap: () {
                            // Открываем страницу деталей
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(movie: movie),
                              ),
                            ).then((_) {
                              // обновляем список после возврата
                              if (searchQuery != null) {
                                context.read<MovieSearchBloc>().add(
                                      MovieSearchEvent.searchMovies(searchQuery),
                                    );
                              } else {
                                context.read<MovieSearchBloc>().add(
                                      const MovieSearchEvent.loadPopular(),
                                    );
                              }
                            });
                          },
                          onSaveToggle: () {
                            final savedBloc = context.read<SavedMoviesBloc>();
                            
                            if (movie.isSaved) {
                              savedBloc.add(
                                SavedMoviesEvent.removeMovie(movie.id),
                              );
                            } else {
                              savedBloc.add(
                                SavedMoviesEvent.addMovie(movie),
                              );
                            }
                            
                            // перезагружаем поиск чтобы обновить статус isSaved
                            if (searchQuery != null) {
                              context.read<MovieSearchBloc>().add(
                                    MovieSearchEvent.searchMovies(searchQuery),
                                  );
                            } else {
                              context.read<MovieSearchBloc>().add(
                                    const MovieSearchEvent.loadPopular(),
                                  );
                            }
                          },
                        );
                      },
                    );
                  },
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MovieSearchBloc>().add(
                                  const MovieSearchEvent.loadPopular(),
                                );
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