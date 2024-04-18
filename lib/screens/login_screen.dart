import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _saving = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _saving,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email'
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                 password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(Colors.lightBlueAccent, 'Log In', () async {
                setState(() {
                  _saving = true;
                });
                try{
                  final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(newUser != null){
                    Navigator.pushNamed(context, 'chatScreen');
                  }
                  setState(() {
                    _saving = false;
                  });
                }
                catch(e){
                  print(e);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
