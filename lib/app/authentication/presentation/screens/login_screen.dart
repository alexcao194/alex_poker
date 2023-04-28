import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_paths.dart';
import '../../../../core/services/app_router/app_router.dart';
import '../../domain/entities/account.dart';
import '../bloc/account/account_cubit.dart';
import '../bloc/authentication/authentication_bloc.dart';
import 'widgets/app_drawer.dart';
import 'widgets/authentication_button.dart';
import 'widgets/input_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<AccountCubit, Account>(
      builder: (context, account) {
        if (emailController.value.text == "") emailController.text = account.email;
        if (passwordController.value.text == "") passwordController.text = account.password;
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            return Scaffold(
              floatingActionButton: Builder(builder: (context) {
                return FloatingActionButton(
                  onPressed: () {
                    if (!Scaffold.of(context).isDrawerOpen) {
                      Scaffold.of(context).openDrawer();
                    }
                  },
                  child: const Text('IP'),
                );
              }),
              drawer: const AppDrawer(),
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: AppColors.primary),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome,',
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Glad to see you',
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: Colors.white70,
                                  ),
                            ),
                            const SizedBox(height: 24.0),
                            InputText(title: AutofillHints.email, controller: emailController),
                            const SizedBox(height: 12.0),
                            InputText(title: AutofillHints.password, isObscure: true, controller: passwordController),
                            Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'Forgot password?',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AuthenticationButton(
                                onTap: () {
                                  _login(emailController.value.text, passwordController.value.text);
                                },
                                child: Text(
                                  'Login',
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.1),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(child: Container(height: 1.0, color: Colors.white)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Or login with',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(child: Container(height: 1.0, color: Colors.white))
                              ],
                            ),
                            const SizedBox(height: 24.0),
                            Row(
                              children: [
                                Expanded(
                                    child: AuthenticationButton(
                                        child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(AppPath.googleIcon),
                                ))),
                                const SizedBox(width: 12.0),
                                Expanded(
                                    child: AuthenticationButton(
                                        child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(AppPath.facebookIcon),
                                ))),
                              ],
                            ),
                            SizedBox(height: size.height * 0.2),
                            RichText(
                              text: TextSpan(children: [
                                const TextSpan(text: 'Don\'t have an account?'),
                                const WidgetSpan(child: SizedBox(width: 4.0)),
                                WidgetSpan(
                                    child: GestureDetector(
                                  onTap: () {
                                    _pushSignupScreen();
                                  },
                                  child: const Text(
                                    'Signup now',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ))
                              ]),
                            ),
                            const SizedBox(height: 32.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (authState is AuthenticationStateLoading)
                    Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      color: Colors.white60,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _pushSignupScreen() {
    AppRouter.push(AppRoutes.signup);
  }

  void _login(String email, String password) {
    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLogin(account: Account(email: email, password: password)));
  }
}
