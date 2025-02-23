import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_passwordpage.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? 'admin';
    String password = prefs.getString('password') ?? '123';

    if (_usernameController.text == username &&
        _passwordController.text == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        _errorMessage = 'Username atau password salah';
      });
      //show eror
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.lightBlueAccent,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/forgot.png',
              width: 180,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 270,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'SELAMAT DATANG',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'username',
                        suffixIcon: Icon(
                          FontAwesomeIcons.pen,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'password',
                        suffixIcon: Icon(
                          FontAwesomeIcons.eye,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangePasswordPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'lupa password ?',
                            style: TextStyle(color: Colors.orange[900]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _login(); // Call function to handle login logic

                      // Show CoolAlert dialog
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        text: 'Login succes', // Success message text
                        // Duration to auto close the dialog
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue
                          .shade400, // Background color of the ElevatedButton
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
