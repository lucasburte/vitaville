import 'package:flutter/material.dart';
import 'package:vitaville/actu_page.dart';
import 'package:vitaville/signalements_page.dart';
import 'package:vitaville/idees_page.dart';
import 'package:vitaville/sondages_page.dart';
import 'package:vitaville/profile_page.dart';
import 'package:vitaville/accueil_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    ActuPage(),
    IdeesPage(),
    SignalementsPage(),
    SondagesPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.newspaper), label: 'Actualités'),
          NavigationDestination(icon: Icon(Icons.how_to_vote), label: 'Idées'),
          NavigationDestination(
              icon: Icon(Icons.warning_amber_rounded), label: 'Signaler'),
          NavigationDestination(icon: Icon(Icons.poll), label: 'Sondages'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
