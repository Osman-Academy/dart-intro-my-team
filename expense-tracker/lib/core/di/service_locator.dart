import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/categories/data/repositories/category-repository.dart';
import '../../features/transaction/data/repositories/transaction-repository.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton(() => Supabase.instance.client);
  sl.registerLazySingleton(() => CategoryRepository());
  sl.registerLazySingleton(() => TransactionRepository());
}
