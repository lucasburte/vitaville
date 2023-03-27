import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'actus.dart';
import 'package:intl/intl.dart';

class ActuPage extends StatefulWidget {
  const ActuPage({super.key});

  @override
  State<ActuPage> createState() => _ActuPageState();
}

class _ActuPageState extends State<ActuPage> {
  List<String> docIDs = []; //liste des id des actus
  final TextEditingController _searchController = TextEditingController(); //controller pour la barre de recherche


  Future getDocId() async { //à chaque reload, vide la liste des actus pour ne pas avoir de doublons
    if(docIDs.isNotEmpty){
      docIDs.clear();
    }
    await FirebaseFirestore.instance.collection('actus').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
          print(document.reference);
          docIDs.add(document.reference.id); //add tous les docIDs pour chaque refresh --> doublons dans la liste des actus affichées
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Fil d'actualités",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          backgroundColor: const Color(0xFFFFFBFE), //Couleur utilisée sur Figma
          elevation: 0, //Retire l'ombre sous l'Appbar
          centerTitle: true, //Permet de centrer le texte
        ),
        body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //buildFloatingSearchBar(), //search bar qui marche pas
              Expanded(
                child: FutureBuilder(
                    future: getDocId(),
                    builder: (context, snapshot) {
                      return ListView.builder(

                        itemCount: docIDs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: GetActus(
                                documentId: docIDs[index],
                              ),
                              onTap: () {
                                return null;
                                //navigator.push(material route page détail actu)
                              },
                            ),
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        ));
  }
}

class GetActus extends StatelessWidget {
  final String documentId;
  final _key1 = GlobalKey();

  GetActus({required this.documentId});




  @override
  Widget build(BuildContext context) {
    CollectionReference actus = FirebaseFirestore.instance.collection('actus');

    return FutureBuilder<DocumentSnapshot>(
      future: actus.doc(documentId).get(),
      builder: (((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            key: _key1,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFBFE),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      4.0,
                      4.0,
                    ),
                  )
                ]),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    //titre, date publication, icones fav, calendrier, share
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 68,
                            width: 200,
                            child: ListTile(
                              title :Text('${data['title']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              //Text(DateTime.fromMillisecondsSinceEpoch(data['publication_date']*1000)), //TimeStamp to DateTime to String
                              subtitle: const Text('il y a un jour'), //en attendant d'arriver à mettre la date de publication
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star_border, color: Colors.black,),
                              SizedBox(width: 5,),
                              Icon(Icons.calendar_month_outlined, color: Colors.black,),
                              SizedBox(width: 5,),
                              Icon(Icons.share, color: Colors.black,),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                  Row(
                      children: [
                        Image.asset("lib/assets/images/eau.jpg", width: 310)
                      ],
                  ),
                const SizedBox(height: 10,),
                Row(
                  //date, lieu
                  children: [
                    Text('   '+'${data['place']}' + ' le 14/04/2023',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  //description
                  children: [
                    Flexible(child: Padding(padding: const EdgeInsets.all(10), child: Text(data['description']))), //regarder comment n'afficher qu'une partie du long texte
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Card(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: SizedBox(
                          width: 70,
                          height: 25,
                          child: Center(child: Text('${data['tags'][0]}',style: TextStyle(fontStyle: FontStyle.italic),)),
                        ),
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: SizedBox(
                          width: 70,
                          height: 25,
                          child: Center(child: Text('${data['tags'][1]}',style: TextStyle(fontStyle: FontStyle.italic),)),
                        ),
                      ),//Text('${data['tags'][2]}'), //voir comment afficher le nombre de tags correct
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Text("Chargement...");
      })),
    );
  }
}