import 'package:book_finder/models/category/category_dto.dart';

abstract class CategoryEvent {}

class CategoryLoadEvent implements CategoryEvent {}

class CategoryCreateEvent implements CategoryEvent {
  CategoryDto dto;
  CategoryCreateEvent({required this.dto});
}

class CategoryDeleteEvent implements CategoryEvent {
  CategoryDto dto;
  CategoryDeleteEvent({required this.dto});
}

class CategoryAddBookEvent implements CategoryEvent {
  CategoryDto dto;
  CategoryAddBookEvent({required this.dto});
}

class CategoryRemoveBookEvent implements CategoryEvent {
  CategoryDto dto;
  CategoryRemoveBookEvent({required this.dto});
}
