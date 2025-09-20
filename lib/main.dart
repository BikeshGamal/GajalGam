import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'database/database_helper.dart';
import 'pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  try {
    final dbHelper = DatabaseHelper();
    await dbHelper.initializeDatabase();
    print('Database initialized successfully in main');
  } catch (e) {
    print('Database initialization failed in main: $e');
    // Continue with app startup even if database fails
  }

  // Set system UI overlay style for full screen
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const GajalGamApp());
}

class GajalGamApp extends StatelessWidget {
  const GajalGamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Base screen design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'गजलगम',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFD2691E), // Dark orange
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFD2691E),
              foregroundColor: Colors.white,
              elevation: 2,
            ),
            primaryColor: const Color(0xFFD2691E),
            cardColor: const Color(0xFFFFF8DC),
          ),
          home: child,
          debugShowCheckedModeBanner: false,
        );
      },
      child: const SplashScreen(),
    );
  }
}
