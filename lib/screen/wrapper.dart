import 'file:///E:/flutter_firebase/brew_firebase/lib/authenticate/authenticate.dart';
import 'file:///E:/flutter_firebase/brew_firebase/lib/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewfirebase/models/user.dart';
import 'file:///E:/flutter_firebase/brew_firebase/lib/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user=Provider.of<User>(context);
    //print(user);
    //return either Home or authenticate
    if (user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
