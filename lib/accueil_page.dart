import 'package:flutter/material.dart';
//import 'package:vitaville/learn_flutter_page.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VitaVille - Accueil"),
      ),
      body: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              //Buttons for redirections
              Column(
                children: [
                  const Text(
                    '<Logo ici>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),

                  const Text(
                    '\nTrouvez votre ville',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),

                  //Espacement
                  const SizedBox(
                    height: 10,
                  ),

                  //Bouton Actualités favorites
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.star_border_outlined,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Créer un compte',
                      ),
                      label: const Text(
                        'Créer un compte',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  //Espacement
                  const SizedBox(
                    height: 10,
                  ),

                  //Bouton Mon calendrier
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Se Connecter',
                      ),
                      label: const Text(
                        'Se Connecter',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
