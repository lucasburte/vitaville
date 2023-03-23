import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaville/actu_page.dart';
import 'package:vitaville/states/current_user.dart';
import 'package:vitaville/main.dart';

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
                children: [
                  const Icon(
                    //ExactAssetImage('assets/images/Logo VitaVille noir.jpg')), (Voir comment intégrer le logo)
                    Icons.calendar_month_outlined,
                    color: Colors.black,
                    size: 69.0, //Nice
                    semanticLabel: 'Logo',
                  ),

                  const Text(
                    '\nTrouvez votre ville',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),

                  const Text(
                    '\n<Barre de recherche ici>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),

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
                        backgroundColor: const Color(0xFF6750A4),
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
                          color: Colors.white,
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
                        backgroundColor: const Color(0xFFE8DEF8),
                      ),
                      onPressed: () {
                        //à l'appui, renvoie la page de connexion
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ConnexionPage()));
                      },
                      child: const Text(
                        'Se Connecter',
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

class ConnexionPage extends StatefulWidget {//page de connexion
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  TextEditingController _emailController = TextEditingController();//vérifier les champs inscrits
  TextEditingController _passwordController = TextEditingController();

  void _loginUser(String email, String password, BuildContext context)async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try{ //une fois que l'utilisateur est connecté, envoie vers les actus
      if(await _currentUser.logInUser(email, password)){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ActuPage(),//renvoie la page actu sans la navbar jsp pourquoi
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Identifiants incorrects"),
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
                const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text("Image du logo ici"),
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
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.alternate_email), hintText: "Votre adresse mail",),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.lock_outline), hintText: "Votre mot de passe",),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20.0,),
                      ElevatedButton(
                        child: const Padding(padding: EdgeInsets.symmetric(horizontal: 80),
                        child: Text(
                          'Se connecter',
                          style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          ),
                        ),
                        ),
                        onPressed: (){
                          _loginUser(_emailController.text, _passwordController.text, context);
                        },
                      ),
                      TextButton(
                        //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreationComptePage()));
                        },
                        child: const Text("Pas de compte ? Inscrivez-vous ici")),
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

class _CreationComptePageState extends State<CreationComptePage> {//page de création de compte
TextEditingController _pseudoController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();

void _signUpUser(String email, String password, BuildContext context) async {
  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen:false);

  try {
    if (await _currentUser.signUpUser(email, password)) {
      Navigator.pop(context);
    }
  } catch (e){
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
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
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.person), hintText: "Votre pseudo",),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.alternate_email), hintText: "Votre adresse mail",),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.lock_outline), hintText: "Votre mot de passe",),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.lock), hintText: "Confirmer le mot de passe",),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20.0,),
                      ElevatedButton(
                        child: const Padding(padding: EdgeInsets.symmetric(horizontal: 65),
                        child: Text(
                          'Créer un compte',
                          style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          ),
                        ),
                        ),
                        onPressed: (){//vérifier que les deux mots de passe correspondent
                          if (_passwordController.text == _confirmPasswordController.text){
                            _signUpUser(_emailController.text, _passwordController.text, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Les mots de passes ne correspondent pas"),
                              duration: Duration(seconds: 3),
                              )
                            );
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
