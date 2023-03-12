import 'package:carrotmarket/features/authentication/views/login_screen.dart';
import 'package:carrotmarket/features/authentication/views/set_geolocation_screen.dart';
import 'package:carrotmarket/features/authentication/views/signup_screen.dart';
import 'package:carrotmarket/navigation/main_navigation_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      name: SignupScreen.routeName,
      path: SignupScreen.routeURL,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) {
        final place = state.queryParams["place"];
        return LoginScreen(
          place: place,
        );
      },
    ),
    GoRoute(
      name: SetGeolocationScreen.routeName,
      path: SetGeolocationScreen.routeURL,
      builder: (context, state) => const SetGeolocationScreen(),
    ),
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: "/:tab(home|community|gps|chat|profile)",
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
  ],
);
