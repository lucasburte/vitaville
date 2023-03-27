import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitaville/actu_page.dart';

class DetailIdeePage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const DetailIdeePage({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          documentSnapshot['name'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
        backgroundColor: const Color(0xFFFFFBFE), //Couleur utilisée sur Figma
        elevation: 0, //Retire l'ombre sous l'Appbar
        centerTitle: true, //Permet de centrer le texte
        actions: [
          Icon(Icons.more_horiz_rounded),
          SizedBox(
            width: 20.00,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black,
                  size: 35.0,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '14/04/2023',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.black,
                  size: 35.0,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  children: [
                    Text(
                      'Horaires',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'De 17h00 à 19h00',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  color: Colors.black,
                  size: 35.0,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  children: [
                    Text(
                      'Auteur',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Marie Martin',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Mots-clés et informations supplémentaires :',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
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
                            style: TextStyle(
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
                            style: TextStyle(
                                fontStyle: FontStyle.italic, color: Colors.white),
                          )),
                    ),
                  ), //voir comment afficher le nombre de tags correct
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(children: [
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
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      documentSnapshot['description'],
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(children: [
                Text(
                  'Fichiers',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ]),
            ),
            SizedBox(
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
            SizedBox(
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.language),
                        SizedBox(width: 10,),
                        const Text(
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
    );
  }
}
