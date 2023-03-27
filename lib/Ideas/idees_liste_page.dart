import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:vitaville/Ideas/add_idea_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class IdeesListePage extends StatefulWidget {
  const IdeesListePage({super.key});

  @override
  State<IdeesListePage> createState() => _IdeesListePageState();
}

class _IdeesListePageState extends State<IdeesListePage> {
  List<String> docIDs = []; //liste des id des idees
  final TextEditingController _searchController = TextEditingController(); //controller pour la barre de recherche


  Future getDocId() async { //à chaque reload, vide la liste des idees pour ne pas avoir de doublons
    if(docIDs.isNotEmpty){
      docIDs.clear();
    }
    await FirebaseFirestore.instance.collection('ideas').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
          print(document.reference);
          docIDs.add(document.reference.id); //add tous les docIDs pour chaque refresh --> doublons dans la liste des idees affichées
        },
      ),
    );
  }

  TabBar get _tabBar =>
      TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.black,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.list),
          ),
          Tab(
            icon: Icon(Icons.map),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Boîte à idées",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          backgroundColor: const Color(0xFFFFFBFE), //Couleur utilisée sur Figma
          elevation: 0, //Retire l'ombre sous l'Appbar
          centerTitle: true,//Permet de centrer le texte
          scrolledUnderElevation:0.0,
          bottom: _tabBar, /*PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: const Color(0xFFFFFBFE),
              child: _tabBar,
            ),
          ),*/
        ),
        body:
        TabBarView(
          children: <Widget>[
            Stack(children: [
            Column(
            children: [
              CustomSearchContainer(),
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
                              title: GetIdeas(
                                documentId: docIDs[index],
                              ),
                              onTap: () {
                                return null;
                                //navigator.push(material route page détail idee)
                              },
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
            ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 12, 16),
              child:
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddIdeaPage()),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ]
              ),
            ),
          ),
            ],
          ),

            Stack(
              children: <Widget>[
                CustomMap(),
                CustomSearchContainer(),
                CustomHorizontallyScrollingRestaurants(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 12, 16),
                    child:
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  FloatingActionButton(
                    onPressed: null,
                    child: const Icon(Icons.my_location),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddIdeaPage()),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ]
                ),
                  ),
                ),
                /* DraggableScrollableSheet(
              initialChildSize: 0.30,
              minChildSize: 0.15,
              builder: (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: CustomScrollViewContent(),
                );
              },
            ),*/
              ],
            ),
      ],
        ),
    )
    );
  }
}

/// Map in the background
class CustomMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: null,
      options: MapOptions(
        center: LatLng(48.69821313814409, 6.18658746494504),
        zoom: 15,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: '© OpenStreetMap contributors',
          onSourceTapped: () {},
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.vitaville.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(48.69821313814409, 6.18658746494504),
              width: 40,
              height: 40,
              builder: (context) => const Icon(
                Icons.location_on,
                color: Colors.black,
                size: 40.0,
                semanticLabel: 'name of place',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomSearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 16, 25, 8), //adjust "40" according to the status bar size
      child: Container(
        height: 50,

        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey)),
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
          hintText: "Rechercher",
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

class CustomHorizontallyScrollingRestaurants extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16, right:80),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomRestaurantCategory(),
              SizedBox(width: 12),
              CustomRestaurantCategory(),
              SizedBox(width: 12),
              CustomRestaurantCategory(),
              SizedBox(width: 12),
              CustomRestaurantCategory(),
              SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRestaurantCategory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(8)),
      child: Text('ddd'),
    );
  }
}

class GetIdeas extends StatelessWidget {
  final String documentId;
  final _key1 = GlobalKey();

  GetIdeas({required this.documentId});




  @override
  Widget build(BuildContext context) {
    CollectionReference ideas = FirebaseFirestore.instance.collection('ideas');

    return FutureBuilder<DocumentSnapshot>(
      future: ideas.doc(documentId).get(),
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
                            width: 300,
                            child: ListTile(
                              title :Text('${data['name']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              //Text(DateTime.fromMillisecondsSinceEpoch(data['publication_date']*1000)), //TimeStamp to DateTime to String
                              subtitle: Text('${data['datetime_sent']}'), //en attendant d'arriver à mettre la date de publication
                            ),
                          ),
                        ],
                      ),
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
                    Text('   '+'${data['place_name']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  //description
                  children: [
                    Flexible(child: Padding(padding: const EdgeInsets.all(10), child: Text('description'))), //regarder comment n'afficher qu'une partie du long texte
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
                          child: Center(child: Text('tags',style: TextStyle(fontStyle: FontStyle.italic),)),
                        ),
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: SizedBox(
                          width: 70,
                          height: 25,
                          child: Center(child: Text('tags',style: TextStyle(fontStyle: FontStyle.italic),)),
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