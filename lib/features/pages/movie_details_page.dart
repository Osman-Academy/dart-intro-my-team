import 'package:flutter/material.dart';
import 'package:movie_search/models/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.black,
            title: Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.safePoster,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.movie, size: 96)),
                    ),
                  ),

                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black12,
                          Colors.black54,
                          Colors.black87,
                        ],
                      ),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 56,
                        left: 16,
                        right: 16,
                        bottom: 64,
                      ),
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Colors.black12,
                            child: Image.network(
                              movie.safePoster,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.movie, size: 96),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: titleStyle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _RatingBadge(ratingText: movie.imdbRating),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoChip(
                        icon: Icons.calendar_month,
                        label: _safeText(movie.year),
                      ),
                      const _InfoChip(icon: Icons.movie_filter, label: 'IMDb'),
                      _InfoChip(
                        icon: Icons.star,
                        label: _safeText(movie.imdbRating),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text('Plot', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    _safeText(movie.plot, fallback: 'No description'),
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.35),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _safeText(String value, {String fallback = '—'}) {
    final v = value.trim();
    if (v.isEmpty || v.toLowerCase() == 'n/a') return fallback;
    return v;
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.ratingText});
  final String ratingText;

  @override
  Widget build(BuildContext context) {
    final t = ratingText.trim();
    final shown = (t.isEmpty || t.toLowerCase() == 'n/a') ? '—' : t;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 18, color: Colors.amber),
          const SizedBox(width: 6),
          Text(
            shown,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    );
  }
}
