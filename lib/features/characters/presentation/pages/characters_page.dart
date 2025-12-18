import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/character_bloc.dart';
import '../bloc/character_event.dart';
import '../bloc/character_state.dart';

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
              decoration: const InputDecoration(
                hintText: 'Search character...',
                prefixIcon: Icon(Icons.search),
              ),
                onChanged: (value){
                context.read<CharacterBloc>().add(SearchCharacters(value));
              },
            ),
          ),
          Expanded(child:BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state){
              if(state is CharacterLoading){
                return const Center(child: CircularProgressIndicator());
              }
              if(state is CharacterLoaded){
                return ListView.builder(
                  itemCount: state.characters.length,
                  itemBuilder: (context , index){
                    final c = state.characters[index];
                    return ListTile(
                      title: Text(c.name),
                      subtitle: Text(c.house ?? 'Unknown house'),
                    );
                  },
                );
              }
              return const Center(child:Text('Error'));
            },
          ),),
        ],
      ),
    );
  }
}

