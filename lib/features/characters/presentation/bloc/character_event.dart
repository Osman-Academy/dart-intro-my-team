abstract class CharacterEvent{}

class LoadCharacters extends CharacterEvent{}

class SearchCharacters extends CharacterEvent{
  final String query;
  SearchCharacters(this.query);
}
