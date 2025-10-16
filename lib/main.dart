import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_isaanita/data/services/auth_services.dart';
import 'package:technical_test_isaanita/presentation/blocs/crew_cast/crew_cast_bloc.dart';
import 'package:technical_test_isaanita/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieDetailBloc()),
        BlocProvider(create: (_) => CrewCastBloc()),
      ],
      child: MaterialApp(
        title: 'Technical Test Isaanita',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
