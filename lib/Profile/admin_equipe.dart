import 'package:flutter/material.dart';
import 'package:vitaville/Profile/profile_page.dart';

class AdminEquipe extends StatelessWidget {
  const AdminEquipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Administration Equipe",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFFFFFBFE), //Couleur utilisée sur Figma
        elevation: 0, //Retire l'ombre sous l'Appbar
        centerTitle: true, //Permet de centrer le texte)
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Paramètres du profil',
            ),
          ),
        ],
      ),
      body: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Explaining text
              const Text(
                "Administrez ici l’ensemble de l’équipe d’administration de votre mairie",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),

              //List of staff members
              SizedBox(
                height: 200,
                child: ListView(
                  children: const <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                      ),
                      title: Text('Anne-Marie Catherine'),
                      subtitle: Text('La Compta'),
                      trailing: Icon(Icons.more_vert),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                      title: Text('Jean-Eude Frosent'),
                      subtitle: Text('Secrétaire'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
