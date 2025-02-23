import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latihan/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _changePassword(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String oldPassword = prefs.getString('password') ?? 'admin';

    if (_oldPasswordController.text == oldPassword &&
        _newPasswordController.text == _confirmPasswordController.text) {
      prefs.setString('password', _newPasswordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password Updated'),
          backgroundColor: Colors.blue.shade300,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
      // Password changed successfully
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password Update Failed'),
          backgroundColor: Colors.red.shade300,
          duration: Duration(seconds: 2),
        ),
      );
      // Show error message
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
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(), // Navigate to LoginPage
                          ),
                        );
                      },
                      icon: Icon(Icons
                          .arrow_back_ios_new), // Example icon; replace with your desired icon
                      color: Colors.white, // Color of the icon
                      splashColor: Colors.transparent, // No splash effect
                      highlightColor: Colors.transparent, // No highlight effect
                      padding: EdgeInsets.zero, // No padding
                      alignment: Alignment.center, // Center alignment
                      iconSize: 24, // Icon size
                      tooltip: 'Navigate to Login', // Tooltip text
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/login.png',
                width: 180,
              ),
              Container(
                height: 250,
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
                    Container(
                      width: 250,
                      child: TextField(
                        controller: _oldPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'password lama',
                          suffixIcon: Icon(
                            FontAwesomeIcons.pen,
                            size: 17,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: _newPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'password baru',
                          suffixIcon: Icon(
                            FontAwesomeIcons.pen,
                            size: 17,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'konfirmasi password baru',
                          suffixIcon: Icon(
                            FontAwesomeIcons.eye,
                            size: 17,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _changePassword(
                            context); // Call function to change password
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          text:
                              'kembali kehalaman lupa password', // Success message text
                          autoCloseDuration: const Duration(
                              seconds: 2), // Duration to auto close the dialog
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue
                            .shade400, // Background color of the ElevatedButton
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
