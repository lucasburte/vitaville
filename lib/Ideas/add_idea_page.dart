import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'idees_page.dart';

class AddIdeaPage extends StatelessWidget {
  const AddIdeaPage({super.key});

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
        body: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _AddIdeaPageState();
}

class AddIdeasDb {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> addIdea(String user_uid, String name, String placename,
      String description) async {
    bool retVal = false;

    try {
      final idea = <String, dynamic>{
        "user_uid": user_uid,
        "name": name,
        "place_name": placename,
        "description": description,
      };
      db.collection("ideas").add(idea).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
      retVal = true;
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}

class _AddIdeaPageState extends State<RootPage> {
  TextEditingController _nameController = TextEditingController();//vérifier les champs inscrits
  TextEditingController _placenameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void _addIdea(String user_uid, String name, String placename, String description, BuildContext context)async{

    try{
      if(await AddIdeasDb().addIdea(user_uid, name, placename, description)){
        Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => const IdeesPage(),
            ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Idée non envoyée"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
        Container(
          height: 50,
          margin: const EdgeInsets.all(16.0),
          child: Center(
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nom",
                  hintText: 'Entrez le nom de votre idée',
                  suffixIcon: Icon(Icons.cancel),
                ),
              )
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.all(16.0),
          child: Center(
              child: TextFormField(
                controller: _placenameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.cancel),
                  labelText: "Localisation",
                  hintText: 'Recherchez une localisation',
                ),
              )
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.all(16.0),
          child: const Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  labelText: "Tags",
                  hintText: 'Recherchez un tag',
                ),
              )
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.all(16.0),
          child: Center(
              child: TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                  hintText: 'Décrivez votre idée',
                ),
              )
          ),
        ),
        Container(
        height: 50,
        margin: const EdgeInsets.all(16.0),
    child: Center(
    child: ElevatedButton(
              child: const Padding(padding: EdgeInsets.symmetric(horizontal: 80),
                child: Text(
                  "Déposer l'idée",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              onPressed: (){
                _addIdea("ZQZO4hafDWPczrwwg3J9F6hO52N2", _nameController.text, _placenameController.text, _descriptionController.text, context);
              },
            ),
    ),
    ),
      ],
                ),
      ),
    );
  }
}

