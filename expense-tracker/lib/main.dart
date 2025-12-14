import 'package:expensetracker/common/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './screens/auth-screen.dart';
import './screens/home-screen.dart';
import 'package:get_it/get_it.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://uvsfvhlvaosihhkqvmac.supabase.co',
      anonKey: 'sb_publishable_yG4P7uT2oEpOTgtFYbvn7g_nEp9nKGo',
  );

  Supabase.instance.client.rest.headers.addAll({'apikey':'sb_publishable_yG4P7uT2oEpOTgtFYbvn7g_nEp9nKGo'});
  setupLocator();

  runApp(const MyApp());
}

final SupabaseClient supabase = GetIt.instance<SupabaseClient>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),

      initialRoute: '/auth',
      routes: {
        '/auth': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}


