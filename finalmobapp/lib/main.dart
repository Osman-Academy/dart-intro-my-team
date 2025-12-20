import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'injection_container.dart' as di;
import 'presentation/providers/camera_provider.dart';
import 'presentation/providers/cart_provider.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<CameraProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<CartProvider>()),
      ],
      child: MaterialApp(
        title: 'Camera Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF212121),
            primary: const Color(0xFF212121),
            secondary: const Color(0xFFD32F2F),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xFFF5F5F5),
            foregroundColor: Color(0xFF212121),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
