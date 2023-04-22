// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat_app/auth_page/auth_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'application/bloc/users_bloc.dart';
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
    return BlocProvider(
      create: (context) => UsersBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Chat-App",
        theme: ThemeData(
          //scaffoldBackgroundColor: Colors.grey.shade100,
          scaffoldBackgroundColor: Colors.grey.shade900,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          // textTheme
          textTheme: const TextTheme(
            titleMedium: TextStyle(color: Colors.white),
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
