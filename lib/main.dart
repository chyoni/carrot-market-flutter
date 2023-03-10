import 'package:carrotmarket/config/repositories/config_repository.dart';
import 'package:carrotmarket/config/view_models/config_view_model.dart';
import 'package:carrotmarket/constants/sizes.dart';
import 'package:carrotmarket/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final ConfigRepository configRepository = ConfigRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        configProvider.overrideWith(
          () => ConfigViewModel(configRepository),
        ),
      ],
      child: const CarrotMarketApp(),
    ),
  );
}

class CarrotMarketApp extends ConsumerWidget {
  const CarrotMarketApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'CarrotMarket',
      themeMode:
          ref.watch(configProvider).darkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Color(0xFFF9893D)),
        primaryColor: const Color(0xFFF9893D),
        textTheme: GoogleFonts.hindGunturTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade500,
        ),
      ),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Color(0xFFF9893D)),
          primaryColor: const Color(0xFFF9893D),
          textTheme: GoogleFonts.hindGunturTextTheme(
              ThemeData(brightness: Brightness.light).textTheme),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
          )),
    );
  }
}
