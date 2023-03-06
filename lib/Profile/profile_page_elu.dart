import 'package:flutter/material.dart';
import 'package:vitaville/Profile/profile_page.dart';
import 'admin_equipe.dart';

class ProfilElu extends StatelessWidget {
  const ProfilElu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil",
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
            children: [
              //First part : profile picture and profile informations
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Profile picture in a circle
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.grey.shade200,
                        child: const CircleAvatar(
                          radius: 70,
                          //backgroundImage:
                              //AssetImage('assets/images/default.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  50,
                                ),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(2, 4),
                                  color: Colors.black.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 3,
                                ),
                              ]),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(Icons.add_a_photo, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Espacement
                  const SizedBox(
                    width: 20,
                  ),

                  // Profile informations (name...)
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '\n26 ans',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '\nHabite à Nancy',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              //Espacement
              const SizedBox(
                height: 10,
              ),

              //Bouton Changement profil (habitant vers élu)
              Row(
                children: [
                  SizedBox(
                    //width: size.width,
                    height: 30,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>const ProfilePage()));
                      },
                      icon: const Icon(
                        Icons.sync,
                        color: Colors.black,
                        size: 15.0,
                        semanticLabel: 'Accéder au profil habitant',
                      ),
                      label: const Text(
                        'Acccéder au profil habitant',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //Espacement
              const SizedBox(
                height: 10,
              ),

              //Buttons for redirections
              Column(
                children: [
                  //Bouton Actualités
                  SizedBox(
                    width: size.width,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.newspaper,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Accéder aux actualités',
                      ),
                      label: const Text(
                        'Actualités',
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

                  //Bouton Boite à idées
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.how_to_vote,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Accéder à la boîte à idées',
                      ),
                      label: const Text(
                        'Boîte à idées',
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

                  //Bouton Signalements
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Accéder aux signalements',
                      ),
                      label: const Text(
                        'Signalements',
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

                  //Bouton Sondages
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.poll,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Accéder aux sondages',
                      ),
                      label: const Text(
                        'Sondages',
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

                  //Bouton Administration équipe
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>const AdminEquipe()));
                      },
                      icon: const Icon(
                        Icons.groups,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: "Accéder à l'équipe",
                      ),
                      label: const Text(
                        "Administrer l'équipe",
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
