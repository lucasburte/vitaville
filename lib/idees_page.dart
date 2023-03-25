import 'package:flutter/material.dart';

class IdeesPage extends StatelessWidget {
  const IdeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: const IdeasHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IdeasHome extends StatelessWidget {
  const IdeasHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Boite à idées",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFFFFFBFE), //Couleur utilisée sur Figma
        elevation: 0, //Retire l'ombre sous l'Appbar
        centerTitle: true, //Permet de centrer le texte
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IdeaForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class IdeaForm extends StatelessWidget {
  const IdeaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Déposer une idée",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFFFFFBFE), //Couleur utilisée sur Figma
        elevation: 0, //Retire l'ombre sous l'Appbar
        centerTitle: true, //Permet de centrer le texte
      ),
    );
  }
}
