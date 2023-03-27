import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaville/actu_page.dart';
import 'package:vitaville/states/current_user.dart';
import 'package:vitaville/main.dart';
import 'package:vitaville/nav_page.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "VitaVille",
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
              Column(
                children: [Image.asset("lib/assets/images/logo.png",
                  width: 100,//récupérer la largeur du container
                ),
                  const Text(
                    '\nTrouvez votre ville',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),

                  CustomSearchContainer(),

                  //Espacement
                  const SizedBox(
                    height: 10,
                  ),

                  //Bouton Créer un Compte
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8DEF8),
                      ),
                      onPressed: () {
                        //A l'appui, renvoie la page de création de compte
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreationComptePage()));
                      },
                      child: const Text(
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

                  //Bouton Se Connecter
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6750A4),
                      ),
                      onPressed: () {
                        //à l'appui, renvoie la page de connexion
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ConnexionPage()));
                      },
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          color: Colors.white,
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

class ConnexionPage extends StatefulWidget {
  //page de connexion
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  TextEditingController _emailController =
      TextEditingController(); //vérifier les champs inscrits
  TextEditingController _passwordController = TextEditingController();

  void _loginUser(String email, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      //une fois que l'utilisateur est connecté, envoie vers les actus
      if (await _currentUser.logInUser(email, password)) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const NavPage(), //renvoie la page actu sans la navbar jsp pourquoi
            ),
            (_) => false);

        AddUserDb()._getDataFromDatabase(email, password,
            context); //Appel de la fonction permettant de créer un document sur firebase pour le user

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Identifiants incorrects"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion à un compte'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
                  child: Image.asset("lib/assets/images/logo.png",
                    width: 10,//récupérer la largeur du container
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            4.0,
                            4.0,
                          ),
                        )
                      ]),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 8.0,
                        ),
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          hintText: "Votre adresse mail",
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "Votre mot de passe",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6750A4),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          _loginUser(_emailController.text,
                              _passwordController.text, context);
                        },
                      ),
                      TextButton(
                          //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreationComptePage()));
                          },
                          child:
                              const Text("Pas de compte ? Inscrivez-vous ici")),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CreationComptePage extends StatefulWidget {
  const CreationComptePage({super.key});

  @override
  State<CreationComptePage> createState() => _CreationComptePageState();
}

//Classe permettant la création d'un nouveau document sur Firebase pour le user qui crée son compte
//Création d'un nouveau document dans la collection "users"
class AddUserDb {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool isAlreadyCreated =
      false; //True if the user already has a document in the collection

  Future _getDataFromDatabase(
      String email, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((snapshot) {
      int numberOfUsers = snapshot.size;

      //Parcours de tous les users dans la collection users de Firebase
      for (int i = 0; i < numberOfUsers; i++) {
        //Vérification : est-ce que le user est déjà dans les documents de la collection Users de Firebase
        //si non, alors il faut lui créer un document
        if (isAlreadyCreated == false) {
          if (snapshot.docs[i].reference.id == _currentUser.getUid) {
            isAlreadyCreated = true;
          } else {
            isAlreadyCreated = false;
          }
        }
      }
    });

    if (isAlreadyCreated == false) {
      addUser(email, password, context, _currentUser);
    }
  }

  Future<void> addUser(
      String email, String password, BuildContext context, CurrentUser _currentUser)  async {
    //Récupérer l'uid attribué par défaut
    try {
      //CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false); // =====> Génère une erreur "Looking up a deactivated widget's ancestor is unsafe."

      String userID = _currentUser.getUid;

      //Création du document dans la collection users avec les infos de l'utilisateur
      try {
        final user = <String, dynamic>{
          "email": email,
          "password": password,
          "city": "non renseignée",
          "name" : "non renseigné",
          "elected" : false,
        };

        //Ajout du user dans un nouveau document de la collection users
        var collectionOfUsers = db.collection('users');
        collectionOfUsers
            .doc(userID)
            .set(user);

      } catch (e) {
        print("Error Catch 1 : $e");
      }
    } catch (e) {
      print("Error Catch 2: $e");
    }
  }
}

class _CreationComptePageState extends State<CreationComptePage> {
  //page de création de compte
  TextEditingController _pseudoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    //FirebaseAuth.instance.currentUser?.displayName; //Jsp maybe ça peut être utile

    try {
      if (await _currentUser.signUpUser(email, password)) {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Création de compte'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
                  child: Image.asset("lib/assets/images/logo.png",
                    width: 10,//récupérer la largeur du container
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            4.0,
                            4.0,
                          ),
                        )
                      ]),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 8.0,
                        ),
                        child: Text(
                          "Créer un compte",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _pseudoController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Votre pseudo",
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          hintText: "Votre adresse mail",
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "Votre mot de passe",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Confirmer le mot de passe",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6750A4),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Créer un compte',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          //vérifier que les deux mots de passe correspondent
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            _signUpUser(_emailController.text,
                                _passwordController.text, context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Les mots de passes ne correspondent pas"),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomSearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8), //adjust "40" according to the status bar size
      child: Container(
        height: 50,

        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey)),
        child: Row(
          children: <Widget>[
            SizedBox(width: 16),
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
