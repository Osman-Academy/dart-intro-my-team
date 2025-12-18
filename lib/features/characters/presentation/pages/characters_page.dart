import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/character_bloc.dart';
import '../bloc/character_event.dart';
import '../bloc/character_state.dart';
import 'character_details_page.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Wizarding World')),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged:(value){
                context.read<CharacterBloc>().add(SearchCharacters(value));
              },
              decoration: const InputDecoration(
                hintText: 'Search character...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(child:BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state){
              if(state is CharacterLoading){
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CharacterError) {
                return Center(
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              if(state is CharacterLoaded){
                return ListView.builder(
                  itemCount: state.characters.length,
                  itemBuilder: (context , index){
                    final c = state.characters[index];
                    return Card(
                        color: Colors.black.withOpacity(0.6),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,),
                        ),
                        child: ListTile(leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: c.image != null? Image.network(
                                c.image!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                const Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                              )
                                  : const Icon(
                                Icons.person,
                                size: 40,
                              ),
                            ),
                        title: Text(
                          c.name,
                          style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1.2,),
                        ),
                        subtitle: Text(
                          c.house ?? 'Unknown house',
                          style: TextStyle(
                          color:
                          Colors.amber.withOpacity(0.7),
                          fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CharacterDetailsPage(character: c),),);
                            },
                        ),
                      );
                    },
                );
              }
              return const SizedBox.shrink();
            }
          ),),
        ],
      ),
    );
  }
}

