import 'package:flutter/material.dart';
import 'package:vitaville/actu_page.dart';
import 'package:vitaville/signalements_page.dart';
import 'package:vitaville/Ideas/idees_page.dart';
import 'package:vitaville/sondages_page.dart';
import 'package:vitaville/Profile/profile_page.dart';



class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    ActuPage(),
    IdeesPage(),
    SignalementsPage(),
    SondagesPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage], // en fait ça ça fait que le body de RootPage c'est la page de la liste pages qui s'affiche
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.newspaper), label: 'Actualités'),
          NavigationDestination(icon: Icon(Icons.how_to_vote), label: 'Idées'),
          NavigationDestination(icon: Icon(Icons.warning_amber_rounded), label: 'Signaler'),
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
