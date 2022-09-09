import 'package:flutter/material.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/components/navigation_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinnder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinnder,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputDecoration.copyWith(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputDecoration.copyWith(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: 24.0,
              ),
              NavigationButton(
                  buttonColor: Colors.lightBlueAccent,
                  onPressed: () async {
                    try {
                      setState(() {
                        showSpinnder = true;
                      });
                      final newUser = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      setState(() {
                        showSpinnder = false;
                      });
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.route);
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        showSpinnder = false;
                      });
                    }
                  },
                  buttonText: 'Login'),
            ],
          ),
        ),
      ),
    );
  }
}
