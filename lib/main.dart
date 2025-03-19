import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_danish/bloc/home_bloc.dart';
import 'package:portfolio_danish/firebase_options.dart';
import 'package:portfolio_danish/ui/home/home_screen.dart';
import 'package:portfolio_danish/utils/app_routes.dart';
import 'package:portfolio_danish/utils/app_theme.dart';

import 'bloc/bloc_observer.dart';

Future<void> main() async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: MaterialApp(
        title: 'Portfolio App',
        debugShowCheckedModeBanner: false,
        theme: PortfolioAppTheme.baseTheme(),
        initialRoute: HomeScreen.routeName,
        routes: routes,
      ),
    );
  }
}
