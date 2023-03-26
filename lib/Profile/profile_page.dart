import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaville/Profile/profile_page_elu.dart';
import 'package:vitaville/states/current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
        centerTitle: true, //Permet de centrer le texte
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
  //Elements d'un utilisateur (valeurs de défaut assignées)
  String? name = 'Nom inconnu';
  String? city = 'Ville inconnue';
  bool? elected = false;
  File? profilePicture;

  //Méthode pour récupérer les infos de l'utilisateur sur Firebase
  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      //print(snapshot.id); //debug
      //print(snapshot.exists); //debug

      if (snapshot.exists) {
        print("it exists + $snapshot"); //debug
        setState(() {
          name = snapshot.data()!["name"];
          city = snapshot.data()!["city"];
          elected = snapshot.data()!["isElected"];
          //age = snapshot.data()!["age"]; //il faut faire le calcul à partir de la date de naissance
        });
      } else {
        print("nooooop");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabase();
  }

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
                      children: [
                        Text(
                          name!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '\n${city!}',
                          style: const TextStyle(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilElu()));
                      },
                      icon: const Icon(
                        Icons.sync,
                        color: Colors.black,
                        size: 15.0,
                        semanticLabel: 'Accéder au profil élu',
                      ),
                      label: const Text(
                        'Acccéder au profil élu',
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
                  //Bouton Actualités favorites
                  SizedBox(
                    width: size.width,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.star_border_outlined,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Mes actualités favorites',
                      ),
                      label: const Text(
                        'Mes actualités favorites',
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Accéder à mon calendrier',
                      ),
                      label: const Text(
                        'Mon calendrier',
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

                  //Bouton Mes idées
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.how_to_vote,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Mes idées',
                      ),
                      label: const Text(
                        'Mes idées',
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

                  //Bouton Mes signalements
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Mes signalements',
                      ),
                      label: const Text(
                        'Mes signalements',
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
