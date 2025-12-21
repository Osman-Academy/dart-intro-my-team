import 'package:flutter/material.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/features/pages/movie_details_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black54,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => MovieDetailsPage(movie: movie)),
          );
        },
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.safePoster,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.movie, size: 64)),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black26,
                          Colors.black87,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: _RatingPill(ratingText: movie.imdbRating),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _safeText(movie.year),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _safeText(String value) {
    final v = value.trim();
    if (v.isEmpty || v.toLowerCase() == 'n/a') return '—';
    return v;
  }
}

class _RatingPill extends StatelessWidget {
  const _RatingPill({required this.ratingText});
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
          const Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 6),
          Text(
            shown,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
