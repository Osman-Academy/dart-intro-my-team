import 'package:flutter/material.dart';
import 'package:movie_search/models/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  movie.safePoster,
                  width: 240,
                  height: 360,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.movie, size: 120),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(movie.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              '${movie.year} • ⭐ ${movie.imdbRating}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text('Plot', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(movie.plot),
          ],
        ),
      ),
    );
  }
}
