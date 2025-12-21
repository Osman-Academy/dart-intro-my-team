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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search movies...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                context.read<MovieBloc>().add(MovieSearchEvent(query: value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieStateLoading)
                  return const Center(child: CircularProgressIndicator());
                if (state is MovieStateLoaded) {
                  if (state.displayedMovies.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.50,
                        ),
                    itemCount: state.displayedMovies.length,
                    itemBuilder: (_, i) =>
                        MovieCard(movie: state.displayedMovies[i]),
                  );
                }
                if (state is MovieStateError)
                  return Center(child: Text(state.message));
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
