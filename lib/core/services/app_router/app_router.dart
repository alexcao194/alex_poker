import 'package:alex_poker/app/authentication/presentation/screens/login_screen.dart';
import 'package:alex_poker/app/authentication/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import '../../../app/home/presentation/screens/home_screen.dart';
import '../../../app/poker/presentation/screens/play_screen.dart';
import '../../../app/poker/presentation/screens/poker_room_screen.dart';
import '../../../splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.entry:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.play:
        return MaterialPageRoute(builder: (_) => const PlayScreen());
      case AppRoutes.pokerRoom:
        return MaterialPageRoute(builder: (_) => const PokerRoom());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(),
                  body: const Center(child: Text('Fallback')),
                ));
    }
  }

  static BuildContext get context => navigatorKey.currentState!.context;

  static push(String route) {
    navigatorKey.currentState?.pushNamed(route);
  }

  static pushReplacement(String route) {
    navigatorKey.currentState?.pushReplacementNamed(route);
  }

  static pushAndRemoveUntil(String route, String entry) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(route, ModalRoute.withName(entry));
  }

  static pop() {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState?.pop();
    }
  }
}

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String play = '/play';
  static const String pokerRoom = '/poker_room';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String entry = '/';
}
