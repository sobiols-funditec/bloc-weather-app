
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/location/cubit/location_cubit.dart';
import 'package:weather_app/location/data/location_repository.dart';
import 'package:weather_app/weather/views/home_page.dart';
import 'package:weather_app/weather/cubit/weather_cubit.dart';
import 'package:weather_app/weather/data/weather_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => LocationRepository()),
        RepositoryProvider(create: (_) => WeatherRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LocationCubit(
              locationRepository: context.read<LocationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => WeatherCubit(
              locationCubit: context.read<LocationCubit>(),
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ),
      ),
    );
  }
}
