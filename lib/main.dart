import 'package:alex_poker/app/authentication/presentation/bloc/account/account_cubit.dart';
import 'package:alex_poker/app/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:alex_poker/app/authentication/presentation/bloc/ip/ip_cubit.dart';
import 'package:alex_poker/app/home/presentation/bloc/user_profile_bloc.dart';
import 'package:alex_poker/app/poker/presentation/bloc/page/page_cubit.dart';
import 'package:alex_poker/app/poker/presentation/bloc/room/room_bloc.dart';
import 'package:alex_poker/config/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/app_router/app_router.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  await di.init();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageCubit()),
          BlocProvider(create: (_) => di.sl<AuthenticationBloc>()),
          BlocProvider(create: (_) => di.sl<AccountCubit>()),
          BlocProvider(create: (_) => di.sl<IpCubit>()),
          BlocProvider(create: (_) => di.sl<UserProfileBloc>()),
          BlocProvider(create: (_) => di.sl<RoomBloc>()),
        ],
        child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alex Messenger',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: AppRouter.navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
        fontFamily: AppFonts.poppins
      ),
    );
  }
}