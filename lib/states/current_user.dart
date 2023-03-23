import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class CurrentUser extends ChangeNotifier {
  late String _uid;
  late String _email;
  //late bool role; //faux = citoyen, vrai = citoyen + admin

  String get getUid => _uid;
  String get getEmail => _email;
  

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<bool> signUpUser(String email, String password) async{//fonction de création de compte en lien avec firebase
    bool retVal = false;
    
    try {
      UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null){
        retVal = true;//vérifier si ça fonctionne
      }
    }catch(e) {
      print(e);
        }
    return retVal;
  }

  Future<bool> logInUser(String email, String password) async{//fonction de connexion en lien avec firebase
    bool retVal = false;
    try {
      UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final user = authResult.user;
      if (user != null){
        _uid = user.uid;
        _email = user.email!;
        retVal = true;
      }
    }catch(e) {
      print(e);
        }
    return retVal;
  }
}