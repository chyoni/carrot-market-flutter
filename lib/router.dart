import 'package:carrotmarket/features/authentication/views/login_screen.dart';
import 'package:carrotmarket/features/authentication/views/set_geolocation_screen.dart';
import 'package:carrotmarket/features/authentication/views/signup_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: SignupScreen.routeName,
      path: SignupScreen.routeURL,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: SetGeolocationScreen.routeName,
      path: SetGeolocationScreen.routeURL,
      builder: (context, state) => const SetGeolocationScreen(),
    ),
  ],
);
