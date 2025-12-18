import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';

class CharacterDetailsPage extends StatelessWidget{
  final Character character;
  const CharacterDetailsPage({super.key, required this.character,});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(character.image != null)
              ClipRRect(
                borderRadius:BorderRadius.circular(16),
                child: Image.network(
                  character.image!,
                  height:250,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 120),
                ),
              ),
            const SizedBox(height: 24),
            Text(
              character.name,
              style: const TextStyle(
                fontSize: 26,
                letterSpacing : 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _InfoRow(
              title:'House',
              value: character.house ?? 'Unknown',
            ),
          ],
        ),
      ),
    );
  }
}
class _InfoRow extends StatelessWidget{
  final String title;
  final String value;
  const _InfoRow({
    required this.title,
    required this.value,
});
  @override

  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title, style: TextStyle(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
          ),
          Text(
            value , style: const TextStyle(fontSize: 16),
          ),
        ],
      )
    );
  }
}