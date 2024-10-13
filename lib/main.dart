import 'package:flutter/material.dart';
import 'package:my_app/app_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/pages/home/home_page.dart';
import 'package:my_app/data/repository/weather_repository.dart';
import 'package:my_app/presentation/pages/todo/add_todo_page.dart';
import 'package:my_app/presentation/pages/auth/bloc/auth_bloc.dart';
import 'package:my_app/data/data_provider/weather_data_provider.dart';
import 'package:my_app/presentation/pages/todo/cubit/todo_cubit.dart';
import 'package:my_app/presentation/pages/weather/weather_screen.dart';
import 'package:my_app/data/repository/current_weather_repository.dart';
import 'package:my_app/presentation/pages/auth/login/login_screen.dart';
import 'package:my_app/presentation/pages/counter/bloc/counter_bloc.dart';
import 'package:my_app/presentation/pages/weather/bloc/weather_bloc.dart';
import 'package:my_app/presentation/pages/counter/cubit/counter_cubit.dart';
import 'package:my_app/data/data_provider/current_weather_data_provider.dart';
import 'package:my_app/presentation/pages/current_weather/current_weather_screen.dart';
import 'package:my_app/presentation/pages/current_weather/bloc/current_weather_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => TodoCubit()),
        BlocProvider(create: (_) => AuthBloc()),
        RepositoryProvider(
          create: (context) => WeatherRepository(WeatherDataProvider()),
        ),
        RepositoryProvider(
          create: (context) =>
              CurrentWeatherRepository(CurrentWeatherDataProvider()),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(context.read<WeatherRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              CurrentWeatherBloc(context.read<CurrentWeatherRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const WeatherScreen(),
          '/home': (_) => const HomePage(),
          '/add-todo': (_) => AddTodoPage(),
          '/login': (_) => const LoginScreen(),
          '/weather': (_) => const WeatherScreen(),
          '/current_weather': (_) => const CurrentWeatherScreen()
        },
      ),
    );
  }
}
