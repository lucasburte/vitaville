import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vitaville/actu_page.dart';

class DetailIdeePage extends StatelessWidget {
  //récupération firebase
  final DocumentSnapshot documentSnapshot;
  DetailIdeePage({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          documentSnapshot['name'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
        backgroundColor: const Color(0xFFFFFBFE), //Couleur utilisée sur Figma
        elevation: 0, //Retire l'ombre sous l'Appbar
        centerTitle: true, //Permet de centrer le texte
        actions: const [
          Icon(Icons.more_horiz_rounded),
          SizedBox(
            width: 20.00,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),

            //Colonne avec les infos sur l'idée
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Likes Dislikes

                //Localisation
                Row(
                  children: [
                    //icone
                    Column(
                      children: const [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30.0,
                          semanticLabel: 'Localisation icon',
                        ),
                      ],
                    ),

                    //Espacement
                    const SizedBox(
                      width: 20,
                    ),

                    //Textes
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Texte légende
                        Row(
                          children: const [
                            //Text(""), //DEBUG GITHUB
                            Text(
                              "Localisation : ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        //Texte valeur
                        Row(
                          children: [
                            Text(
                              documentSnapshot['place_name']!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10.0,
                ),

                //Date de dépot
                Row(
                  children: [
                    //icone
                    Column(
                      children: const [
                        Icon(
                          Icons.date_range,
                          color: Colors.black,
                          size: 30.0,
                          semanticLabel: 'date icon',
                        ),
                      ],
                    ),

                    //Espacement
                    const SizedBox(
                      width: 20,
                    ),

                    //Textes
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Texte légende
                        Row(
                          children: const [
                            Text(
                              "Date de dépôt : ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        //Texte valeur
                        Row(
                          children: const [
                            Text(
                              //documentSnapshot['datetime_sent']!.toString(),
                              "14 mars 2023",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10.0,
                ),

                //Auteur
                Row(
                  children: [
                    //icone
                    Column(
                      children: const [
                        Icon(
                          Icons.person_outline,
                          color: Colors.black,
                          size: 30.0,
                          semanticLabel: 'person icon',
                        ),
                      ],
                    ),

                    //Espacement
                    const SizedBox(
                      width: 20,
                    ),

                    //Textes
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Texte légende
                        Row(
                          children: const [
                            Text(
                              "Auteur/Autrice : ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        //Texte valeur
                        Row(
                          children: const [
                            Text("Bertrand N."),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10.0,
                ),

                //Statut de l'idée
                Row(
                  children: [
                    //icone
                    Column(
                      children: const [
                        Icon(
                          Icons.hourglass_empty,
                          color: Colors.black,
                          size: 30.0,
                          semanticLabel: 'sablier icon',
                        ),
                      ],
                    ),

                    //Espacement
                    const SizedBox(
                      width: 20,
                    ),

                    //Textes
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Texte légende
                        Row(
                          children: const [
                            Text(
                              "Statut de l'idée : ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        //Texte valeur
                        Row(
                          children: [
                            Text(
                              documentSnapshot['status']!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),

            //Colonne avec les tags
            Column(
              children: [
                const Text(
                  'Mots-clés et informations supplémentaires :',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    //Tag 1
                    Card(
                      color: const Color.fromARGB(255, 139, 71, 113),
                      child: SizedBox(
                        width: 100,
                        height: 45,
                        child: Center(
                            child: Text(
                          documentSnapshot['tags'][0],
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                    //Tag 2
                    Card(
                      color: const Color.fromARGB(255, 139, 71, 113),
                      child: SizedBox(
                        width: 100,
                        height: 45,
                        child: Center(
                            child: Text(
                          documentSnapshot['tags'][1],
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            //Colonnes avec la descriptions

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  documentSnapshot['description'],
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),

            //Photos

            /*
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Row(
                    children: const [
                      Text(
                        'Mots-clés et informations supplémentaires :',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Card(
                          color: const Color.fromARGB(255, 139, 71, 113),
                          child: SizedBox(
                            width: 100,
                            height: 45,
                            child: Center(
                                child: Text(
                              '${documentSnapshot['tags'][0]}',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                        Card(
                          color: const Color.fromARGB(255, 139, 71, 113),
                          child: SizedBox(
                            width: 100,
                            height: 45,
                            child: Center(
                                child: Text(
                              '${documentSnapshot['tags'][1]}',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            )),
                          ),
                        ), //voir comment afficher le nombre de tags correct
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(children: const [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            documentSnapshot['description'],
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(children: const [
                      Text(
                        'Fichiers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //photo d'illustration
                    children: [
                      Image.asset(
                        "lib/assets/images/eau.jpg",
                        width: 342, //récupérer la largeur du container
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6750A4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(Icons.language),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Voir le site web de l'évènement",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
