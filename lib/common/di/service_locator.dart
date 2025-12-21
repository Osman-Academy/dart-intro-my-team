import 'package:get_it/get_it.dart';
import 'package:book_finder/repositories/repository_book.dart';
import 'package:book_finder/repositories/repository_book_remote.dart';
import 'package:book_finder/repositories/repository_category.dart';
import 'package:book_finder/repositories/repository_category_local.dart';
import 'package:book_finder/usecases/book_usecase.dart';
import 'package:book_finder/usecases/category_usecase.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton<RepositoryBook>(
    RepositoryBookRemote(),
    signalsReady: true,
  );
  
  sl.registerSingleton<RepositoryCategory>(
    RepositoryCategoryLocal(),
    signalsReady: true,
  );
  
  sl.registerSingleton<BookUsecase>(
    BookUsecase(
      bookRepo: sl<RepositoryBook>(),
      categoryRepo: sl<RepositoryCategory>(),
    ),
    signalsReady: true,
  );

  sl.registerSingleton<CategoryUsecase>(
    CategoryUsecase(categoryRepo: sl<RepositoryCategory>()),
    signalsReady: true,
  );
}