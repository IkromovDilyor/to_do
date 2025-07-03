import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubits/task_cubit/task_cubit.dart';
import 'package:to_do/screens/home_screen.dart';
import 'package:to_do/screens/login_screen.dart';
import 'package:to_do/screens/on_boarding.dart';
import 'package:to_do/service/shared_preference_storage.dart';
import 'package:to_do/utils/constants/store_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TaskCubit _taskCubit;

  @override
  void initState() {
    _taskCubit = TaskCubit();
    super.initState();
  }

  @override
  void dispose() {
    _taskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _loadInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else {
          return MultiBlocProvider(
            providers: [BlocProvider.value(value: _taskCubit)],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              home: snapshot.data!,
            ),
          );
        }
      },
    );
  }

  Future<Widget> _loadInitialScreen() async {
    final isFirstTime = SharedPreferenceStorage.getBool(StoreKeys.isFirsTime);
    final token = SharedPreferenceStorage.getString(StoreKeys.accessToken);

    if (isFirstTime == false) {
      return OnBoardingScreen();
    } else if (token.isNotEmpty) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
