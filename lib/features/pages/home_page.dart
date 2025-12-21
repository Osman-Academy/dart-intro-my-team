import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/features/bloc/movie_bloc.dart';
import 'package:movie_search/features/bloc/movie_event.dart';
import 'package:movie_search/features/bloc/movie_state.dart';
import 'package:movie_search/features/pages/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MovieLoadEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  ButtonStyle _hoverIconStyle() {
    return ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.white.withOpacity(0.12);
        }
        if (states.contains(WidgetState.pressed)) {
          return Colors.white.withOpacity(0.18);
        }
        return null;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Movie Search'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Reload',
            style: _hoverIconStyle(),
            onPressed: () {
              _searchController.clear();
              context.read<MovieBloc>().add(MovieLoadEvent());
            },
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: _SearchField(
              controller: _searchController,
              onChanged: (value) {
                context.read<MovieBloc>().add(MovieSearchEvent(query: value));
              },
              onClear: () {
                _searchController.clear();
                context.read<MovieBloc>().add(MovieSearchEvent(query: ''));
              },
              iconStyle: _hoverIconStyle(),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is MovieStateLoaded) {
                  if (state.displayedMovies.isEmpty) {
                    return _EmptyState(
                      title: 'No movies found',
                      subtitle: 'Try another search pattern.',
                      onReset: () {
                        _searchController.clear();
                        context.read<MovieBloc>().add(
                          MovieSearchEvent(query: ''),
                        );
                      },
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.52,
                        ),
                    itemCount: state.displayedMovies.length,
                    itemBuilder: (_, i) =>
                        MovieCard(movie: state.displayedMovies[i]),
                  );
                }

                if (state is MovieStateError) {
                  return _EmptyState(
                    title: 'Something went wrong',
                    subtitle: state.message,
                    onReset: () {
                      context.read<MovieBloc>().add(MovieLoadEvent());
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.iconStyle,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ButtonStyle iconStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      color: theme.colorScheme.surface,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search by title or plot...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Clear',
                style: iconStyle,
                onPressed: onClear,
                icon: const Icon(Icons.clear),
              );
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.title,
    required this.subtitle,
    required this.onReset,
  });

  final String title;
  final String subtitle;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_movies, size: 56),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onReset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
