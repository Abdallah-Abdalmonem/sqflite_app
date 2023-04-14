import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: _isLoggedIn == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('name'),
                    Text('email'),
                    TextButton(
                      onPressed: () {
                        FacebookAuth.instance.logOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                            _userObj = {};
                          });
                        });
                      },
                      child: Text('logOut'),
                    ),
                  ],
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () {
                      FacebookAuth.instance
                          .login(permissions: ['public_profile', 'email']).then(
                        (value) {
                          FacebookAuth.instance.getUserData().then(
                            (userData) async {
                              setState(() {
                                _isLoggedIn = true;
                                _userObj = userData;
                              });
                            },
                          );
                        },
                      );
                    },
                    child: Text('login'),
                  ),
                ),
        ),
      ),
    );
  }
}
