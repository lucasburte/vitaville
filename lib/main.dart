import 'package:flutter/material.dart';
import 'package:vitaville/accueil_page.dart';
import 'package:vitaville/states/current_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
        home: const AccueilPage(),//changer par RootPage() parce qu'en l'état la connexion fonctionne mais qd on arrive sur les actus il y a pas de navbar
      ),
    );
  }
}