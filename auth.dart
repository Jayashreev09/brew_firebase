import 'package:brewfirebase/models/user.dart';
import 'package:brewfirebase/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brewfirebase/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user!=null ? User(uid: user.uid) : null;
  }
  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }


  //sign in anon
 Future signInAnon() async{
   try{
     AuthResult result=await _auth.signInAnonymously();
     FirebaseUser user=result.user;
     return _userFromFirebaseUser(user);
   }catch(e){
     print(e.toString());
     return null;
   }
 }
  //signin with email and pwd
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and pwd
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new doccument for the user wtih uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
       print(e.toString());
       return null;
    }
  }



  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
 
}