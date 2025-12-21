import 'package:flutter/material.dart';
import 'package:movie_search/models/movie.dart';
import 'package:url_launcher/url_launcher.dart';

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

    final images = movie.images ?? [];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 675,
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
                      child: const Center(child: Icon(Icons.movie, size: 180)),
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
                        top: 84,
                        left: 16,
                        right: 16,
                        bottom: 96,
                      ),
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            color: Colors.black12,
                            child: Image.network(
                              movie.safePoster,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.movie, size: 180),
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
                    bottom: 24,
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
                        const SizedBox(width: 18),
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
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _InfoChip(icon: Icons.calendar_month, label: _safeText(movie.year)),
                      _InfoChip(icon: Icons.star, label: _safeText(movie.imdbRating)),
                      _InfoChip(icon: Icons.movie_filter, label: _safeText(movie.rated)),
                      _InfoChip(icon: Icons.access_time, label: _safeText(movie.runtime)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _InfoChip(icon: Icons.theater_comedy, label: _safeText(movie.genre)),
                      _InfoChip(icon: Icons.person, label: _safeText(movie.director)),
                      _InfoChip(icon: Icons.edit, label: _safeText(movie.writer)),
                      _InfoChip(icon: Icons.people, label: _safeText(movie.actors)),
                      _InfoChip(icon: Icons.flag, label: _safeText(movie.country)),
                      _InfoChip(icon: Icons.language, label: _safeText(movie.language)),
                      _InfoChip(icon: Icons.emoji_events, label: _safeText(movie.awards)),
                      _InfoChip(icon: Icons.calendar_today, label: _safeText(movie.released)),
                    ],
                  ),
                  if (movie.imdbID.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final url = 'https://www.imdb.com/title/${movie.imdbID}/';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Icons.link),
                      label: const Text('View on IMDb'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[800],
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text('Plot', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Text(
                    _safeText(movie.plot, fallback: 'No description'),
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.35),
                  ),
                  if (images.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    Text('Images', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 18,
                      runSpacing: 18,
                      children: images.map((img) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            img,
                            width: 330,
                            height: 240,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 330,
                              height: 240,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.movie, size: 96),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _safeText(String? value, {String fallback = '—'}) {
    final v = (value ?? '').trim();
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 24, color: Colors.amber),
          const SizedBox(width: 8),
          Text(
            shown,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
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
      avatar: Icon(icon, size: 24),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    );
  }
}
