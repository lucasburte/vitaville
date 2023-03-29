import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitaville/detail_actu.dart';

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
          scrolledUnderElevation:0.0,
        ),
        body: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSearchContainer(), //search bar qui marche pas
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
                            ),
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        )
      );
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
          final DocumentSnapshot documentSnapshot = snapshot.data!;
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return InkWell(
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailActuPage(documentSnapshot: documentSnapshot))));
            }),
            child: Container(
              key: _key1,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFBFE),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      spreadRadius: 0.1,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                    )
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(//titre, date publication, icones fav, calendrier, share
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 68,
                              width: 245,
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
                    //photo d'illustration
                    children: [
                      Image.asset("lib/assets/images/eau.jpg",
                      width: 340,//récupérer la largeur du container
                      ),
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
                      Flexible(child: Padding(padding: const EdgeInsets.all(10), child: Text(data['description']))), //idéal : n'afficher qu'une partie du long texte
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Card(
                          color: const Color.fromARGB(255, 139, 71, 113),
                          child: SizedBox(
                            width: 70,
                            height: 25,
                            child: Center(child: Text('${data['tags'][0]}',style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white,),)),
                          ),
                        ),
                        Card(
                          color: const Color.fromARGB(255, 139, 71, 113),
                          child: SizedBox(
                            width: 70,
                            height: 25,
                            child: Center(child: Text('${data['tags'][1]}',style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),)),
                          ),
                        ),//voir comment afficher le nombre de tags correct
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const Text("Chargement...");
      })),
    );
  }
}

class CustomSearchContainer extends StatelessWidget { // Widget barre de recherche
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Container(
        height: 50,

        decoration: BoxDecoration(color: Color.fromARGB(255, 235, 235, 235), borderRadius: BorderRadius.circular(30),),
        child: Row(
          children: <Widget>[
            SizedBox(width: 16),
            CustomUserAvatar(),
            CustomTextField(),
            SizedBox(width: 16),
            Icon(Icons.search),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          hintText: "Rechercher un post",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CustomUserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(color: Colors.grey[500], borderRadius: BorderRadius.circular(16)),
    );
  }
}