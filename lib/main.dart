import 'package:brewfirebase/models/user.dart';
import 'package:brewfirebase/screen/wrapper.dart';
import 'package:brewfirebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brewfirebase/screen/wrapper.dart';
import 'package:brewfirebase/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:brewfirebase/models/user.dart';
import 'package:brewfirebase/shared/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
      child: MaterialApp(
       home: Wrapper(),
      ),
    );
  }
}

