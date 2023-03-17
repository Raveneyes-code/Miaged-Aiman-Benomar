import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miagedv1/components/my_button.dart';
import 'package:miagedv1/components/my_buttonSu.dart';
import 'package:miagedv1/components/my_textfield.dart';
import 'package:miagedv1/pages/home_page.dart';
import 'package:miagedv1/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordRenterController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  Future<void> signUserUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                      'http://www.miage.fr/wp-content/uploads/2020/02/MIAGE_LOGO-SEUL_COULEURS.png'),
                ),
                const SizedBox(height: 50),
                Text(
                  'Welcome please Sign Up',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: _emailController,
                  hintText: 'Your Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Your Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                // renter password textfield
                MyTextField(
                  controller: _passwordRenterController,
                  hintText: 'Please re-enter your password.',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // sign in button
                MyButtonSu(
                  onTap: () {
                    String password = _passwordController.text;
                    String passwordRenter = _passwordRenterController.text;
                    if (password != passwordRenter) {
                      Fluttertoast.showToast(
                        msg: "Passwords do not match. Please try again.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else if (password.length < 6) {
                      Fluttertoast.showToast(
                        msg: "Password must be at least 6 characters long.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      signUserUp();
                    }
                  },
                ),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member ?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
