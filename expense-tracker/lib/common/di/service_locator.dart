import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton(() => Supabase.instance.client);
}
