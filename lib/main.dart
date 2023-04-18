// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat_app/application/bloc_search/search_bloc.dart';
import 'package:chat_app/auth_page/auth_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'application/bloc_current_user/current_user_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // initiallize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  // whenever  initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CurrentUserBloc()),
        BlocProvider(create: (context) => SearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Chat-App",
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.teal[900]),
          scaffoldBackgroundColor: Colors.grey.shade900,
          // textTheme
          textTheme: const TextTheme(
            titleMedium: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          //
        ),
        home: const AuthPage(),
      ),
    );
  }
}
