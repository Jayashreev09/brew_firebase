import 'package:brewfirebase/shared/loading.dart';
import'package:flutter/material.dart';
import 'package:brewfirebase/services/auth.dart';
import 'package:brewfirebase/shared/constants.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth=AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed:() {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In')
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/cp_reg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child:Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email=val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a strong password' : null,
                  onChanged: (val) {
                    setState(() => password=val);
                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.blueGrey,
                  child: Text(
                    'Register',
                    style: TextStyle(color:Colors.white70),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                      if(result==null){
                        setState(() {
                          error = ' Enter a valid email';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 14.0),
                ),
              ],
            ),
          )
      ),
    );
  }
}
