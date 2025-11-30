import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_store/screens/cart_screen.dart';
import 'providers/product_provider.dart';
import 'screens/home_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const TechStoreApp());
}

class TechStoreApp extends StatelessWidget {
  const TechStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..initAuth()),
        ChangeNotifierProvider(create: (_) => ProductProvider()..loadProducts()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        routes: {
          '/cart': (ctx) {
            final auth = ctx.read<AuthProvider>();
            if (!auth.isAuthenticated) {
              return const LoginScreen(redirectRoute: '/cart');
            }
            return const CartScreen();
          },
          '/login': (_) => const LoginScreen(),
          '/profile': (ctx) {
            final auth = ctx.read<AuthProvider>();
            if (!auth.isAuthenticated) {
              return const LoginScreen(redirectRoute: '/profile');
            }
            return const ProfileScreen();
          },
          '/home': (_) => const HomeScreen(),
        },
        home: const HomeScreen(),
      ),
    );
  }
}
