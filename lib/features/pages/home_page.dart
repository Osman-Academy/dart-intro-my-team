import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/features/bloc/movie_bloc.dart';
import 'package:movie_search/features/bloc/movie_event.dart';
import 'package:movie_search/features/bloc/movie_state.dart';
import 'package:movie_search/features/widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 350);

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MovieLoadEvent());
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      if (!mounted) return;
      context.read<MovieBloc>().add(MovieSearchEvent(query: value));
    });
  }

  void _clearSearch() {
    _debounceTimer?.cancel();
    _searchController.clear();
    context.read<MovieBloc>().add(MovieSearchEvent(query: ''));
  }

  ButtonStyle _hoverIconStyle() {
    return ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.white.withAlpha(31);
        }
        if (states.contains(WidgetState.pressed)) {
          return Colors.white.withAlpha(46);
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
        actions: [
          IconButton(
            tooltip: 'Reload',
            style: _hoverIconStyle(),
            onPressed: () {
              _debounceTimer?.cancel();
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
              onChanged: _onSearchChanged,
              onClear: _clearSearch,
              iconStyle: _hoverIconStyle(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is! MovieStateLoaded) return const SizedBox.shrink();

                return Column(
                  children: [
                    _DropdownCard(
                      title: 'Sort',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<SortMode>(
                          value: state.sortMode,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: SortMode.titleAsc,
                              child: Text('Title: A → Z'),
                            ),
                            DropdownMenuItem(
                              value: SortMode.titleDesc,
                              child: Text('Title: Z → A'),
                            ),
                            DropdownMenuItem(
                              value: SortMode.yearAsc,
                              child: Text('Year: old → new'),
                            ),
                            DropdownMenuItem(
                              value: SortMode.yearDesc,
                              child: Text('Year: new → old'),
                            ),
                            DropdownMenuItem(
                              value: SortMode.ratingAsc,
                              child: Text('Rating: low → high'),
                            ),
                            DropdownMenuItem(
                              value: SortMode.ratingDesc,
                              child: Text('Rating: high → low'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            context.read<MovieBloc>().add(
                              MovieSortChangedEvent(sortMode: v),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    _RangeCard(
                      title: 'Year range',
                      subtitle:
                          '${state.selectedYearRange.start.round()} — ${state.selectedYearRange.end.round()}',
                      child: RangeSlider(
                        values: state.selectedYearRange,
                        min: state.availableYearRange.start,
                        max: state.availableYearRange.end,
                        divisions:
                            (state.availableYearRange.end -
                                    state.availableYearRange.start)
                                .round()
                                .clamp(1, 200),
                        labels: RangeLabels(
                          state.selectedYearRange.start.round().toString(),
                          state.selectedYearRange.end.round().toString(),
                        ),
                        onChanged: (v) {
                          context.read<MovieBloc>().add(
                            MovieYearRangeChangedEvent(yearRange: v),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    _RangeCard(
                      title: 'Rating range',
                      subtitle:
                          '${state.selectedRatingRange.start.toStringAsFixed(1)} — ${state.selectedRatingRange.end.toStringAsFixed(1)}',
                      child: RangeSlider(
                        values: state.selectedRatingRange,
                        min: state.availableRatingRange.start,
                        max: state.availableRatingRange.end,
                        divisions:
                            ((state.availableRatingRange.end -
                                        state.availableRatingRange.start) *
                                    10)
                                .round()
                                .clamp(1, 100),
                        labels: RangeLabels(
                          state.selectedRatingRange.start.toStringAsFixed(1),
                          state.selectedRatingRange.end.toStringAsFixed(1),
                        ),
                        onChanged: (v) {
                          context.read<MovieBloc>().add(
                            MovieRatingRangeChangedEvent(ratingRange: v),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is MovieStateLoaded) {
                  final total = state.allMovies.length;
                  final shown = state.displayedMovies.length;

                  if (shown == 0) {
                    return _EmptyState(
                      title: 'No movies found',
                      subtitle: 'Try changing search / ranges / sort.',
                      onReset: () {
                        _clearSearch();
                        context.read<MovieBloc>().add(MovieLoadEvent());
                      },
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                        child: Row(
                          children: [
                            Text(
                              'Showing $shown of $total',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            const double maxCardWidth = 220; 
                            final crossAxisCount = (constraints.maxWidth / maxCardWidth).floor();

                            return GridView.builder(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.52,
                              ),
                              itemCount: shown,
                              itemBuilder: (_, i) => MovieCard(movie: state.displayedMovies[i]),
                            );
                          },
                        ),
                      ),

                    ],
                  );
                }

                if (state is MovieStateError) {
                  return _EmptyState(
                    title: 'Something went wrong',
                    subtitle: state.message,
                    onReset: () =>
                        context.read<MovieBloc>().add(MovieLoadEvent()),
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
          hintText: 'Search by title',
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

class _DropdownCard extends StatelessWidget {
  const _DropdownCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.bodySmall),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}

class _RangeCard extends StatelessWidget {
  const _RangeCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: theme.textTheme.bodySmall)),
                Text(subtitle, style: theme.textTheme.bodySmall),
              ],
            ),
            child,
          ],
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
