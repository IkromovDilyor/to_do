import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do/cubits/login_cubit/login_cubit.dart';
import 'package:to_do/models/login_params.dart';
import 'package:to_do/screens/home_screen.dart';
import 'package:to_do/utils/constants/app_icons.dart';
import 'package:to_do/utils/enums/enums.dart';
import 'package:to_do/widgets/custom_text_field.dart';
import 'package:to_do/widgets/cutom_button.dart';
import 'package:to_do/widgets/toast_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.registerStatus == StateStatus.success) {
              ToastUtils.show("Registratsiya muvaffaqiyatli! Emailingizni tasdiqlang.");
            }
            if (state.loginStatus == StateStatus.success) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
            }
            if (state.loginStatus == StateStatus.failure || state.registerStatus == StateStatus.failure) {
              ToastUtils.show("Xatolik yuz berdi. Email yoki parol noto‘g‘ri bo‘lishi mumkin.");
            }
          },
          builder: (context, state) {
            var loginCubit = context.read<LoginCubit>();
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(AppIcons.logo),
                        SizedBox(height: 20),
                        CustomTextField(controller: emailController, hintText: 'Email'),
                        SizedBox(height: 10),
                        CustomTextField(controller: passwordController, hintText: 'Password'),
                        SizedBox(height: 40),
                        CustomButton(
                          isLoading: state.loginStatus==StateStatus.inProgress,
                          text: "Login",
                          onTap: () {
                            loginCubit.login(
                              LoginParams(email: emailController.text.trim(), password: passwordController.text.trim()),
                            );
                          },
                        ),
                        SizedBox(height: 40),
                        CustomButton(
                          isLoading: state.registerStatus==StateStatus.inProgress,
                          text: "Register",
                          onTap: () {
                            loginCubit.register(
                              LoginParams(email: emailController.text.trim(), password: passwordController.text.trim()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
